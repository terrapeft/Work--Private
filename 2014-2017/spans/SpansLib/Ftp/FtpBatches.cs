using System;
using System.Collections.Generic;
using System.Linq;
using SpansLib.Db;
using WinSCP;

namespace SpansLib.Ftp
{
    /// <summary>
    /// Saves to database and loads collections of ftp files.
    /// </summary>
    public class FtpBatches
    {
        private readonly string _url;
        private readonly SpansEntities _entities;

        public FtpBatches(string url)
        {
            _url = url;
            _entities = SpansEntities.GetInstance();
        }

        public int SaveBatch(DateTime? date, IEnumerable<KeyValuePair<string, RemoteFileInfo>> files)
        {
            var batch = new Batch { SearchFromDate = date, Url = _url };
            _entities.Batches.Add(batch);

            foreach (var p in files)
            {
                _entities.FilesLists.Add(new FilesList
                {
                    BatchId = batch.Id,
                    FileDate = p.Value.LastWriteTime,
                    FileSize = p.Value.Length,
                    Url = FtpHelper.Combine(p.Key, p.Value.Name),
                });
            }

            _entities.SaveChanges();

            return batch.Id;
        }

        public IEnumerable<FilesList> LoadBatch(int batchId)
        {
            var batch = _entities.Batches.FirstOrDefault(b => b.Id == batchId);
            return batch != null ? batch.FilesLists.ToList() : new List<FilesList>();
        }
    }
}
