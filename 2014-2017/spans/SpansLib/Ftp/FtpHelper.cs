using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Threading;
using System.Threading.Tasks;
using SharedLibrary;
using SpansLib.Data;
using SpansLib.Db;
using WinSCP;

namespace SpansLib.Ftp
{

    /// <summary>
    /// Deals with FTP tasks
    /// </summary>
    public class FtpHelper : IDisposable
    {
        private DateTime? _startDateInclusive;
        private Action<int, List<KeyValuePair<string, RemoteFileInfo>>> _jobFinishedCallback;
        private Action<string> _messageCallback;
        private CancellationToken _cancellationToken;

        private readonly SessionOptions _sessionOptions;
        private Session _session;
        private readonly Uri _ftpUri;
        private int _batchId;
        private SpansEntities _entities;

        private readonly NetworkCredential _credentials = new NetworkCredential();

        private readonly int _runningThreadsLimit;
        private int _runningThreads;
        private readonly Queue<KeyValuePair<string, RemoteFileInfo>> _folders = new Queue<KeyValuePair<string, RemoteFileInfo>>();
        private readonly List<KeyValuePair<string, RemoteFileInfo>> _files = new List<KeyValuePair<string, RemoteFileInfo>>();
        private readonly List<Task> _tasks = new List<Task>();
        private List<string> _skipFileTypes = new List<string>();
        private readonly List<string> _customStopList = new List<string>();
        private readonly List<string> _systemStopList = new List<string> { Constants.LevelUp };

        public FtpHelper(Uri uri, Protocol protocol, int numberOfThreads = 4)
        {
            _ftpUri = uri;
            _runningThreadsLimit = numberOfThreads;

            _sessionOptions = new SessionOptions
            {
                Protocol = protocol,
                HostName = uri.Host,
                UserName = AppSettings.FtpLogin,
                Password = AppSettings.FtpPassword,
                PortNumber = 21,
            };
        }

        #region Public methods

        /// <summary>
        /// Downloads the specified file.
        /// </summary>
        /// <param name="paths">The paths.</param>
        /// <param name="errorCallback">The error callback.</param>
        /// <param name="creationDateTime">The creation date time.</param>
        /// <param name="useBinary">if set to <c>true</c> [use binary].</param>
        /// <param name="overwrite">if set to <c>true</c> [overwrite].</param>
        /// <returns></returns>
        public KeyValuePair<string, string> Download(FtpFilePaths paths, Action<string> errorCallback, DateTime? creationDateTime = null,
            bool useBinary = true, bool overwrite = true)
        {
            return Download(paths.FileName, paths.FullFtpPath, paths.FullDiskPath, errorCallback, creationDateTime, useBinary, overwrite);
        }

        /// <summary>
        /// Downloads the specified file.
        /// </summary>
        /// <param name="file">The file.</param>
        /// <param name="ftpPath">The FTP path.</param>
        /// <param name="savePath">The local path to save to.</param>
        /// <param name="errorCallback">The error callback.</param>
        /// <param name="creationDateTime">The creation date time.</param>
        /// <param name="useBinary">True for downloading binary files.</param>
        /// <param name="overwrite">True to overwrite files with the same name, False to skip them.</param>
        /// <returns></returns>
        public KeyValuePair<string, string> Download(string file, string ftpPath, string savePath, Action<string> errorCallback, DateTime? creationDateTime = null,
            bool useBinary = true, bool overwrite = true)
        {
            try
            {
                // file URL
                var url = Combine(ftpPath, file);

                // file local path
                var filename = Path.Combine(savePath, file);

                var request = (FtpWebRequest)WebRequest.Create(url);
                request.Method = WebRequestMethods.Ftp.DownloadFile;
                request.UseBinary = useBinary;
                request.Credentials = _credentials;
                request.Timeout = AppSettings.FtpTimeoutInMilliseconds;

                // ensure folder exists
                Directory.CreateDirectory(savePath);

                // overwrite?
                if (File.Exists(filename))
                {
                    if (overwrite)
                    {
                        File.Delete(filename);
                    }
                    else
                    {
                        errorCallback.Answer(filename + AppSettings.ReportSkipDownload);
                        return new KeyValuePair<string, string>();
                    }
                }

                // download ...
                using (var response = (FtpWebResponse)request.GetResponse())
                using (var responseStream = response.GetResponseStream())
                using (var outputStream = File.OpenWrite(filename))
                {
                    if (responseStream != null)
                    {
                        responseStream.CopyTo(outputStream);
                    }
                }

                // ... and set dates same as ftp file
                if (creationDateTime != null)
                {
                    File.SetCreationTime(filename, (DateTime)creationDateTime);
                    File.SetLastWriteTime(filename, (DateTime)creationDateTime);
                }

                return new KeyValuePair<string, string>(file, filename);
            }
            catch (Exception ex)
            {
                DbLogger.Instance.LogError(message: ex.ToString());
                errorCallback.Answer(ex.ToString());
            }

            return new KeyValuePair<string, string>();
        }


        /// <summary>
        /// Parallels the download.
        /// </summary>
        /// <param name="files">The files.</param>
        /// <param name="savePath">The file path.</param>
        /// <param name="callback">The callback.</param>
        /// <param name="overwrite">True to overwrite files with the same name, False to skip them.</param>
        public void ParallelDownload(IEnumerable<KeyValuePair<string, RemoteFileInfo>> files, string savePath, Action<string> callback, bool overwrite = true)
        {
            ParallelDownload(
                files.Select(f => new KeyValuePair<string, DateTime?>(Combine(f.Key, f.Value.Name), f.Value.LastWriteTime)),
                savePath,
                callback);
        }

        /// <summary>
        /// Parallels the download.
        /// </summary>
        /// <param name="files">The files.</param>
        /// <param name="savePath">The file path.</param>
        /// <param name="callback">The callback.</param>
        /// <param name="overwrite">True to overwrite files with the same name, False to skip them.</param>
        public void ParallelDownload(IEnumerable<FilesList> files, string savePath, Action<string> callback, bool overwrite = true)
        {
            ParallelDownload(
                files.Select(f => new KeyValuePair<string, DateTime?>(f.Url, f.FileDate)),
                savePath,
                callback);
        }

        /// <summary>
        /// Parallels files download.
        /// </summary>
        /// <param name="files">The files.</param>
        /// <param name="savePath">The file path.</param>
        /// <param name="callback">The callback.</param>
        /// <param name="overwrite">True to overwrite files with the same name, False to skip them.</param>
        public void ParallelDownload(IEnumerable<KeyValuePair<string, DateTime?>> files, string savePath, Action<string> callback, bool overwrite = true)
        {
            try
            {
                if (_cancellationToken.IsCancellationRequested)
                {
                    callback.Answer(AppSettings.ReportCanceled);
                    return;
                }

                var downloadedFiles = new List<KeyValuePair<string, string>>();

                var options = new ParallelOptions { MaxDegreeOfParallelism = Math.Min(files.Count(), 8) };
                Parallel.ForEach(files, options, fileData =>
                {
                    callback.Answer(AppSettings.ReportFtpDownloadFile + fileData.Key);

                    var paths = GetFilePaths(fileData.Key, savePath, _ftpUri);
                    downloadedFiles.Add(Download(paths, callback, fileData.Value, overwrite: overwrite));
                });

                using (_entities = SpansEntities.GetInstance())
                {
                    foreach (var filePair in downloadedFiles)
                    {
                        var fileInfo = _entities.FilesLists.FirstOrDefault(f => f.BatchId == _batchId && f.Url.EndsWith(filePair.Key));
                        if (fileInfo != null)
                        {
                            fileInfo.Path = filePair.Value;
                        }
                    }

                    _entities.SaveChanges();
                }
            }
            catch (Exception ex)
            {
                DbLogger.Instance.LogError(message: ex.ToString());
                callback.Answer(ex.ToString());
            }
        }

        /// <summary>
        /// Gets the file paths for ftp and disk.
        /// </summary>
        /// <param name="file">The file.</param>
        /// <param name="saveTo">The save to.</param>
        /// <param name="uri">The URI.</param>
        /// <returns></returns>
        public static FtpFilePaths GetFilePaths(string file, string saveTo, Uri uri)
        {
            var fl = new FtpFilePaths
            {
                FileName = GetFileName(file),
                FullFtpPath = GetFtpFullPath(file, uri),
                FullDiskPath = GetDiskFullPath(saveTo, file, uri)
            };

            return fl;
        }

        /// <summary>
        /// Downloads all files int the batch.
        /// </summary>
        /// <param name="ftpUrl">The FTP URL.</param>
        /// <param name="saveTo">The save to.</param>
        /// <param name="batchId">The batch identifier.</param>
        /// <param name="callback">The callback.</param>
        public void DownloadBatchFiles(string ftpUrl, string saveTo, int batchId, Action<string> callback)
        {
            _batchId = batchId;

            var batch = new FtpBatches(ftpUrl);
            var batchFiles = batch.LoadBatch(batchId);

            ParallelDownload(batchFiles, saveTo, callback);
        }

        /// <summary>
        /// Synchronizes the ftp and local folders.
        /// </summary>
        /// <param name="savePath">The local path.</param>
        /// <param name="messageCallback">The message callback.</param>
        /// <param name="cancellationToken">The cancellation token.</param>
        /// <param name="startDateInclusive">The start date inclusive.</param>
        /// <param name="overwrite">True to overwrite files with the same name, False to skip them.</param>
        /// <param name="stopList">The folders stop list.</param>
        /// <param name="skipFileTypes">The file types to skip during download.</param>
        public void SyncFolders(string savePath, Action<string> messageCallback, CancellationToken cancellationToken, DateTime? startDateInclusive = null, bool overwrite = false, IEnumerable<string> stopList = null, IEnumerable<string> skipFileTypes = null)
        {
            try
            {
                _cancellationToken = cancellationToken;

                IEnumerable<KeyValuePair<string, RemoteFileInfo>> ftpFiles = null;
                IEnumerable<FileInfo> localFiles = null;

                messageCallback.Answer(AppSettings.ReportSyncStart + savePath);
                messageCallback.Answer(AppSettings.ReportSyncIgnoreFolders + string.Join(Constants.CommaWhitespace, stopList ?? new List<string>()));
                messageCallback.Answer(AppSettings.ReportSyncIgnoreFiles + string.Join(Constants.CommaWhitespace, skipFileTypes ?? new List<string>()));
                messageCallback.Answer(AppSettings.ReportSyncStartTime + (startDateInclusive ?? DateTime.MinValue));
                messageCallback.Answer(AppSettings.ReportSyncOverwrite + overwrite);

                InvokeFileListing(
                    messageCallback,
                    (id, files) =>
                    {
                        _batchId = id;
                        ftpFiles = files;
                    },
                    cancellationToken,
                    startDateInclusive,
                    stopList,
                    skipFileTypes)
                .Wait(cancellationToken);

                localFiles = Directory.Exists(savePath)
                    ? new DirectoryInfo(savePath).EnumerateFiles(Constants.Star, SearchOption.AllDirectories)
                    : new List<FileInfo>();

                // now we have both collections
                if (ftpFiles != null)
                {
                    var missedFiles = ftpFiles
                        .Where(fi => !localFiles.Any(lf => lf.Name == fi.Value.Name && lf.LastWriteTime == fi.Value.LastWriteTime))
                        .ToList();

                    missedFiles = SelectPreferredFiles(missedFiles, Constants.ZipExt);

                    if (missedFiles.Count > 0)
                    {
                        messageCallback.Answer(string.Format(AppSettings.ReportSyncFilesToDownloadTemplate,
                            missedFiles.Count, missedFiles.Sum(f => f.Value.Length).ToPrettySize()));

                        ParallelDownload(missedFiles, savePath, messageCallback, overwrite);
                    }
                    else
                    {
                        messageCallback.Answer(string.Format(AppSettings.ReportSyncUpToDateTemplate, startDateInclusive));
                    }
                }
                else
                {
                    messageCallback.Answer(string.Format(AppSettings.ReportSyncNoFilesTemplate, startDateInclusive));
                }
            }
            catch (Exception ex)
            {
                DbLogger.Instance.LogError(message: ex.ToString());
                messageCallback.Answer(ex.ToString());
            }
        }

        /// <summary>
        /// Invokes the file listing task.
        /// </summary>
        /// <param name="messageCallback">The message callback.</param>
        /// <param name="jobFinishedCallback">The job finished callback.</param>
        /// <param name="cancellationToken">The cancellation token.</param>
        /// <param name="startDateInclusive">The start date inclusive.</param>
        /// <param name="stopList">The folders stop list.</param>
        /// <param name="skipFileTypes">File extensions to skip.</param>
        /// <returns></returns>
        public async Task InvokeFileListing(
            Action<string> messageCallback,
            Action<int, IEnumerable<KeyValuePair<string, RemoteFileInfo>>> jobFinishedCallback,
            CancellationToken cancellationToken,
            DateTime? startDateInclusive = null,
            IEnumerable<string> stopList = null,
            IEnumerable<string> skipFileTypes = null)
        {
            try
            {
                _jobFinishedCallback = jobFinishedCallback;
                _messageCallback = messageCallback;
                _cancellationToken = cancellationToken;
                if (stopList != null) _customStopList.AddRange(stopList);
                _customStopList.AddRange(_systemStopList);
                _startDateInclusive = startDateInclusive;
                _skipFileTypes = (skipFileTypes ?? new List<string>()).ToList();

                _session = new Session();
                _session.Open(_sessionOptions);

                GetFolder(_ftpUri.LocalPath);
                Dequeue();

                await Task.Factory.ContinueWhenAll(_tasks.ToArray(), t =>
                {
                    var batch = new FtpBatches(_ftpUri.LocalPath);
                    var id = batch.SaveBatch(startDateInclusive, _files);

                    jobFinishedCallback.Answer(id, _files);

                    if (cancellationToken.IsCancellationRequested)
                    {
                        ClearTasks(_folders, _files);

                        messageCallback.Answer(AppSettings.ReportCanceled);
                    }
                },
                cancellationToken);

            }
            catch (Exception ex)
            {
                DbLogger.Instance.LogError(message: ex.ToString());
                messageCallback.Answer(ex.ToString());
            }
        }



        #endregion


        /// <summary>
        /// Checks if it is possible to start next folder.
        /// </summary>
        private void Dequeue()
        {
            if (_cancellationToken.IsCancellationRequested)
            {
                ClearTasks(_folders, _files);

                _messageCallback.Answer(AppSettings.ReportCanceled);

                return;
            }

            if (_runningThreads == 0 && _folders.Count == 0)
            {
                return;
            }

            while (_runningThreads < _runningThreadsLimit && _folders.Count > 0)
            {
                KeyValuePair<string, RemoteFileInfo> dir;

                lock (_folders)
                {
                    dir = _folders.Dequeue();
                }

                _runningThreads++;

                var task = Task.Factory.StartNew(() =>
                {
                    try
                    {
                        GetFolder(dir.Key);
                    }
                    catch (Exception ex)
                    {
                        _messageCallback.Answer(ex.Message);
                    }
                }, _cancellationToken);

                _tasks.Add(task);
                task.Wait(_cancellationToken);

                _runningThreads--;
                Dequeue();
            }
        }

        /// <summary>
        /// Receives the folder content.
        /// Subfolders go to folders queue, files to the aggregation list.
        /// </summary>
        private void GetFolder(string url)
        {
            _messageCallback.Answer(AppSettings.ReportFtpListDirectory + url);

            var dir = _session.ListDirectory(url);

            _files.AddRange(dir.Files
                .Where(f => !f.IsDirectory)
                .Where(f => _startDateInclusive == null || f.LastWriteTime >= _startDateInclusive)
                .Where(f => !_skipFileTypes.Any(s => f.Name.EndsWith(s)))
                .Select(f => new KeyValuePair<string, RemoteFileInfo>(url, f)));

            lock (_folders)
            {
                dir.Files
                    .Where(f => f.IsDirectory)
                    .Where(d => !_customStopList.Contains(d.Name))
                    .ToList()
                    .ForEach(f => _folders.Enqueue(new KeyValuePair<string, RemoteFileInfo>(Combine(url, f.Name), f)));
            }
        }


        /// <summary>
        /// Clears the folders queue and list of files.
        /// </summary>
        /// <param name="folders">The folders.</param>
        /// <param name="files">The files.</param>
        private void ClearTasks(Queue<KeyValuePair<string, RemoteFileInfo>> folders, List<KeyValuePair<string, RemoteFileInfo>> files)
        {
            folders.Clear();
            files.Clear();
        }

        /// <summary>
        /// Combines the specified parts of url.
        /// </summary>
        /// <param name="parts">The parts.</param>
        /// <returns></returns>
        public static string Combine(params string[] parts)
        {
            var trm = parts
                .Where(p => !string.IsNullOrEmpty(p))
                .Select(p => p.Trim('/'));

            var t = string.Join("/", trm);
            return t;
        }

        /// <summary>
        /// Gets the name of the file.
        /// </summary>
        /// <param name="ftpPath">The FTP path.</param>
        /// <returns></returns>
        public static string GetFileName(string ftpPath)
        {
            var i = ftpPath.LastIndexOf("/", StringComparison.Ordinal) + 1;
            return ftpPath.Substring(i == -1 ? 0 : i, ftpPath.Length - i);
        }

        /// <summary>
        /// Gets the ftp full path.
        /// </summary>
        /// <param name="ftpPath">The FTP path.</param>
        /// <param name="uri">The URI.</param>
        /// <returns></returns>
        public static string GetFtpFullPath(string ftpPath, Uri uri)
        {
            var i = ftpPath.LastIndexOf("/", StringComparison.Ordinal) + 1;
            var p = ftpPath.Substring(0, i);
            return string.Format("{0}://{1}/{2}", uri.Scheme, uri.Host, p.Trim('/'));
        }

        /// <summary>
        /// Gets the disk full path.
        /// </summary>
        /// <param name="diskRoot">The disk root.</param>
        /// <param name="ftpPath">The FTP path.</param>
        /// <param name="uri">The URI.</param>
        /// <returns></returns>
        public static string GetDiskFullPath(string diskRoot, string ftpPath, Uri uri)
        {
            var i = ftpPath.LastIndexOf("/", StringComparison.Ordinal) + 1;
            var p = ftpPath.Substring(0, i);
            return p.Length == 0
                ? diskRoot
                : Path.Combine(diskRoot, p.Replace(uri.LocalPath.Trim('/'), string.Empty).Trim('/'));
        }

        /// <summary>
        /// If there are files with the same name, but different extensions 
        /// you may want to prefer one of them, for example archieved and uncompressed files in the same directory.
        /// </summary>
        /// <param name="list">The list.</param>
        /// <param name="endsWith">The ends with.</param>
        /// <returns></returns>
        public static List<KeyValuePair<string, RemoteFileInfo>> SelectPreferredFiles(List<KeyValuePair<string, RemoteFileInfo>> list, string endsWith)
        {
            // same name, different extension
            var groups = list
                .GroupBy(fi => Combine(fi.Key, Path.GetFileNameWithoutExtension(fi.Value.Name)));

            var filteredCollection = groups
                .Where(g => g.Any(f => f.Value.Name.EndsWith(endsWith)))
                .SelectMany(g => g.Where(f => f.Value.Name.EndsWith(endsWith)))
                .Union(groups
                .Where(g => !g.Any(f => f.Value.Name.EndsWith(endsWith)))
                .SelectMany(g => g.Select(f => f)))
                .ToList();

            // name with reqular extension has ".zip" at the end
            var exclude = filteredCollection
                .Where(p => p.Value.Name.EndsWith(endsWith))
                .Select(p => p.Value.Name.Replace(endsWith, string.Empty)).ToList();

            var cleanFiles = filteredCollection
                .Select(p => p.Value.Name)
                .Except(exclude)
                .ToList();

            filteredCollection = filteredCollection
                .Where(p => cleanFiles.Contains(p.Value.Name))
                .ToList();

            return filteredCollection;
        }


        public void Dispose()
        {
            if (_session != null)
            {
                _session.Dispose();
            }
        }
    }
}
