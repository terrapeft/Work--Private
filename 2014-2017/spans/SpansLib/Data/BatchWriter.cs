using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices;
using System.Threading;
using Ionic.Zip;
using SharedLibrary;
using SpansLib.Data.XmlFormats;
using SpansLib.Db;
using SpansLib.Ftp;

namespace SpansLib.Data
{
    /// <summary>
    /// Processes files in the batch
    /// </summary>
    public class BatchWriter
    {
        private readonly int _batchId = -1;
        private readonly FileFormat _fileTypesToRun;
        private List<string> _prefList = new List<string>();
        private readonly string _path;
        private readonly DateTime _startDate;
        private SpansEntities _spansEntities;

        protected BatchWriter(FileFormat fileTypesToRun)
        {
            _fileTypesToRun = fileTypesToRun;

            if (fileTypesToRun.HasFlag(FileFormat.XmlFormats))
                PrefList.AddRange(AppSettings.XmlFormats);

            if (fileTypesToRun.HasFlag(FileFormat.PositionalFormats))
                PrefList.AddRange(AppSettings.TextFormats);
        }

        public BatchWriter(int batchId, FileFormat fileTypesToRun)
            : this(fileTypesToRun)
        {
            _batchId = batchId;
        }

        public BatchWriter(string path, FileFormat fileTypesToRun, DateTime startDate)
            : this(fileTypesToRun)
        {
            _path = path;
            _startDate = startDate;
        }

        public List<string> PrefList
        {
            get { return _prefList; }
            set { _prefList = value; }
        }

        /// <summary>
        /// Takes files by batchId,
        /// looks for them locally,
        /// unzip and create and run the reader and the writer.
        /// </summary>
        /// <param name="connectionString">The connection string.</param>
        /// <param name="cancellationToken">The cancellation token.</param>
        /// <param name="callback">The callback.</param>
        /// <param name="appendData">if set to <c>true</c> appends data to tables, otherwise drops and creates data tables.</param>
        public void Process(string connectionString, CancellationToken cancellationToken, Action<string> callback = null, bool appendData = true)
        {
            var files = new List<string>();

            // load batch data
            if (_batchId > 0)
            {
                var batch = new FtpBatches(null);
                files = batch.LoadBatch(_batchId)
                    .Select(f => f.Path)
                    .ToList();
            }
            else if (!string.IsNullOrEmpty(_path))
            {
                // Some archives have creation/last write date which is one day after of data file inside.
                // Here I filter out the majority of zipped files which are for sure of incorrect date,
                // later in the FilterFiles() method there will be another date check for unzipped data files.
                files = Directory
                    .GetFiles(_path, Constants.Star, SearchOption.AllDirectories)
                    .Where(f => File.GetLastWriteTime(f) >= _startDate)
                    .ToList();
            }

            Process(files, connectionString, cancellationToken, callback, appendData);
        }

        /// <summary>
        /// Takes files by batchId,
        /// looks for them locally,
        /// unzip and create and run the reader and the writer.
        /// </summary>
        /// <param name="zippedFiles">The files.</param>
        /// <param name="connectionString">The connection string.</param>
        /// <param name="cancellationToken">The cancellation token.</param>
        /// <param name="callback">The callback.</param>
        /// <param name="appendData">if set to <c>true</c> appends data to tables, otherwise drops and creates data tables.</param>
        private void Process(IEnumerable<string> zippedFiles, string connectionString, CancellationToken cancellationToken, Action<string> callback = null, bool appendData = true)
        {
            try
            {
                var files = new List<string>();
                _spansEntities = SpansEntities.GetInstance();

                callback.Answer(AppSettings.ReportDataStart + !appendData);
                callback.Answer(AppSettings.ReportDataFilesFound + zippedFiles.Count());

                // unzip
                if (!Unzip(zippedFiles, cancellationToken, callback, files))
                {
                    // let user's cancel be catched here 
                    return;
                }

                var existedFiles = appendData
                    ? (_fileTypesToRun == FileFormat.XmlFormats)
                        ? _spansEntities.SpanFiles.ToList().Select(f => new KeyValuePair<string, DateTime>(f.FileName, f.LoadTimeUtc.Value)).ToList()
                        : _spansEntities.PaFiles.ToList().Select(f => new KeyValuePair<string, DateTime>(f.Filename, f.StartDateUtc)).ToList()
                    : new List<KeyValuePair<string, DateTime>>();

                // exclude uploaded
                files = FilterFiles(files, existedFiles, callback);

                callback.Answer(AppSettings.ReportDataFilesToProcess + files.Count());

                // read and save to db
                foreach (var file in files.Distinct())
                {
                    if (cancellationToken.IsCancellationRequested)
                    {
                        return;
                    }

                    callback.Answer(AppSettings.ReportDataUploadFile + file);

                    var ext = (Path.GetExtension(file) ?? string.Empty);
                    if (ext == Constants.SpnExt || ext == Constants.XmlExt)
                    {
                        if (_fileTypesToRun.HasFlag(FileFormat.XmlFormats))
                        {
                            WriteXml(callback, connectionString, file, appendData);
                        }
                    }
                    else
                    {
                        if (_fileTypesToRun.HasFlag(FileFormat.PositionalFormats))
                        {
                            if (!WriteText(connectionString, callback, file, appendData))
                            {
                                callback.Answer(AppSettings.ReportDataUnknownFormat);
                            }
                        }
                    }

                    FreeUpMemory();
                }

                callback.Answer(AppSettings.ReportComplete);
            }
            catch (Exception ex)
            {
                callback.Answer(ex.ToString());
                DbLogger.Instance.LogError(message: ex.ToString());
            }
        }

        /// <summary>
        /// Filters the files.
        /// </summary>
        /// <param name="filesQueue">The files.</param>
        /// <param name="existedFiles">The existed files.</param>
        /// <param name="callback">The callback.</param>
        /// <returns></returns>
        /// <exception cref="System.NotImplementedException"></exception>
        public List<string> FilterFiles(List<string> filesQueue, List<KeyValuePair<string, DateTime>> existedFiles, Action<string> callback)
        {
            var startDateUtc = _startDate.ToUniversalTime();

            if (_fileTypesToRun == FileFormat.XmlFormats)
            {
                filesQueue = filesQueue
                    .Where(f => AppSettings.XmlFormats.Contains(Path.GetExtension(f), StringComparer.OrdinalIgnoreCase))
                    .ToList();

                if (existedFiles.Any())
                {
                    // get list of uploaded files
                    var uploadedFiles = existedFiles//_spansEntities.SpanFiles
                        .Where(f => f.Value >= startDateUtc)
                        .Select(f => f.Key);

                    // put to log
                    filesQueue
                        .Intersect(uploadedFiles)
                        .ToList()
                        .ForEach(f => callback.Answer(string.Format(AppSettings.ReportDataSkipInsertTemplate, f)));

                    // remove uploaded files from the queue
                    filesQueue = filesQueue
                        .Except(uploadedFiles)
                        .ToList();
                }
            }

            if (_fileTypesToRun == FileFormat.PositionalFormats)
            {
                filesQueue = filesQueue
                    .Where(f => AppSettings.TextFormats.Contains(Path.GetExtension(f), StringComparer.OrdinalIgnoreCase))
                    .ToList();

                if (existedFiles.Any())
                {
                    // get list of uploaded files
                    var uploadedFiles = existedFiles//_spansEntities.PaFiles
                        .Where(f => f.Value >= startDateUtc)
                        .Select(f => f.Key);

                    // put to log
                    filesQueue
                        .Intersect(uploadedFiles)
                        .ToList()
                        .ForEach(f => callback.Answer(string.Format(AppSettings.ReportDataSkipInsertTemplate, f)));

                    // remove uploaded files from the queue
                    filesQueue = filesQueue
                        .Except(uploadedFiles)
                        .ToList();
                }
            }

            // uzipped files date check as it may differ from the archive date
            filesQueue = filesQueue
                .Where(f => File.GetLastWriteTime(f) >= _startDate)
                .ToList();

            // if there are files which differs by extension, choose one according to the preference list of 
            // extensions, defined in the app.config
            if (filesQueue.Any())
            {
                var filteredByExt = filesQueue
                    .Select(f => new FileInfo(f))
                    .Select(f => new { File = f.FullName.Replace(f.Extension, string.Empty), Ext = f.Extension })
                    .GroupBy(a => a.File)
                    .Select(g => g.Key + GetPreferredExtension(g.Select(a => a.Ext)))
                    .ToList();

                return filteredByExt;
            }

            return filesQueue;
        }

        /// <summary>
        /// Gets the preferred extension.
        /// </summary>
        /// <param name="extensions">The extensions.</param>
        /// <returns></returns>
        public string GetPreferredExtension(IEnumerable<string> extensions)
        {
            // The prefList contains extensions in the preferred order,
            // so I build a sorted list of indicies and take the first (minimal) one.
            // Not using the Min() instead of Select() here, because if one of the extensions was not found, the Min value is -1.
            var indicies = extensions
                .Select(e => PrefList.IndexOf(e))
                .Where(i => i > -1)
                .OrderBy(i => i)
                .Take(1);

            return (indicies.Any())
                ? PrefList[indicies.First()]
                : extensions.First();
        }

        /// <summary>
        /// Writes the XML file to db.
        /// </summary>
        /// <param name="callback">The callback.</param>
        /// <param name="connectionString">The connection string.</param>
        /// <param name="file">The file.</param>
        /// <param name="appendData">if set to <c>true</c> [append data].</param>
        protected virtual void WriteXml(Action<string> callback, string connectionString, string file, bool appendData)
        {
            try
            {
                var processor = new SpnFileProcessor();

                processor.BulkLoad(connectionString, AppSettings.SpanSchemaFile, file, !appendData);

                // update spanFile table
                var sf = _spansEntities.SpanFiles.FirstOrDefault(f => string.IsNullOrEmpty(f.FileName));
                if (sf == null)
                {
                    throw new Exception(AppSettings.ErrorJobFinishedIncorrectly);
                }

                sf.FileName = file;
                sf.LoadTimeUtc = DateTime.UtcNow;
                _spansEntities.SaveChanges();
            }
            catch (Exception ex)
            {
                callback.Answer(ex.ToString());
                DbLogger.Instance.LogError(file, ex.ToString());
            }
        }

        /// <summary>
        /// Writes the data from the positional format file to database.
        /// </summary>
        /// <param name="connectionString">The connection string.</param>
        /// <param name="callback">The callback.</param>
        /// <param name="file">The file.</param>
        /// <param name="appendData"></param>
        /// <returns></returns>
        protected virtual bool WriteText(string connectionString, Action<string> callback, string file, bool appendData)
        {
            try
            {
                var overwrite = !appendData ? 1 : 0;

                var reader = FileFactory.GetReader(file);
                var writer = FileFactory.GetWriter(file);

                if (reader != null && writer != null)
                {
                    // overwrite means delete all before writing new data,
                    // so in batch, if user wants to overwrite, we need it only once, before the first file only
                    writer.UploadData(connectionString, reader, _batchId, overwrite-- < 1);
                }
                else
                {
                    return false;
                }
            }
            catch (Exception ex)
            {
                callback.Answer(ex.ToString());
                DbLogger.Instance.LogError(file, ex.ToString());
            }
            return true;
        }

        /// <summary>
        /// Unzips the specified files.
        /// </summary>
        /// <param name="zippedFiles">The files.</param>
        /// <param name="cancellationToken">The cancellation token.</param>
        /// <param name="callback">The callback.</param>
        /// <param name="files">The files for upload.</param>
        /// <returns></returns>
        protected virtual bool Unzip(IEnumerable<string> zippedFiles, CancellationToken cancellationToken, Action<string> callback, List<string> files)
        {
            foreach (var file in zippedFiles)
            {
                if (cancellationToken.IsCancellationRequested)
                {
                    return false;
                }

                var ext = (Path.GetExtension(file) ?? string.Empty);
                var path = Path.GetDirectoryName(file) ?? string.Empty;

                if (ext.Equals(Constants.ZipExt, StringComparison.OrdinalIgnoreCase))
                {
                    callback.Answer(AppSettings.ReportDataUnzipFile + file);

                    try
                    {
                        var zip = new ZipFile(file)
                        {
                            FlattenFoldersOnExtract = true,
                        };

                        zip.ExtractAll(path, ExtractExistingFileAction.DoNotOverwrite);

                        files.AddRange(zip.EntryFileNames
                            .Select(f => Path.Combine(path, f))
                            .ToList());
                    }
                    catch (Exception ex)
                    {
                        callback.Answer(AppSettings.ReportDataErrorPrefix + ex);
                        DbLogger.Instance.LogError(message: ex.ToString());
                    }
                }
                else
                {
                    files.Add(file);
                }
            }

            return true;
        }


        [DllImport("kernel32.dll", EntryPoint = "SetProcessWorkingSetSize", ExactSpelling = true, CharSet = CharSet.Ansi, SetLastError = true)]
        private static extern int SetProcessWorkingSetSize(IntPtr process, int minimumWorkingSetSize, int maximumWorkingSetSize);
        public static void FreeUpMemory()
        {
            GC.Collect();
            GC.WaitForPendingFinalizers();
            SetProcessWorkingSetSize(System.Diagnostics.Process.GetCurrentProcess().Handle, -1, -1);
        }
    }

    [Flags]
    public enum FileFormat
    {
        PositionalFormats = 1,
        XmlFormats = 2
    }
}
