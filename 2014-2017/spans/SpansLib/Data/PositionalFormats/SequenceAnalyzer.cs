using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading;
using SpansLib.Data;
using SpansLib.Db;

namespace SpansLib.PositionalFormats
{
    public class SequenceAnalyzer
    {
        public void Run(string startFolder, string fileFilter, CancellationToken cancellationToken, Action<string> currFileCb, Action<List<string>> callback)
        {
            var en = SpansEntities.GetInstance();
            var sequences = en.Relationships.Where(r => r.FileFormat == Constants.Pa2).ToList();
            var unknownSequences = new List<string>();

            var files = Directory.EnumerateFiles(startFolder, fileFilter, SearchOption.AllDirectories);

            foreach (var file in files)
            {
                if (cancellationToken.IsCancellationRequested)
                {
                    return;
                }

                currFileCb.Invoke(file);

                var types = new List<KeyValuePair<string, string>>();
                using (var fileStream = new StreamReader(File.OpenRead(file)))
                {
                    string line;
                    int k = 0;

                    while ((line = fileStream.ReadLine()) != null)
                    {
                        k++;

                        if (!string.IsNullOrEmpty(line))
                        {
                            var len = Math.Min(line.Length, 2);
                            types.Add(new KeyValuePair<string, string>(k.ToString(), line.Substring(0, len).Trim()));
                        }
                    }
                }

                types = types.Distinct().ToList();

                if (types.Count > 1)
                {
                    for (var k = types.Count - 1; k > 0; k -= 2)
                    {
                        var t = types[k];
                        var t1 = types[k - 1];
                        if (!sequences.HasSequence(t.Value, t1.Value) && !sequences.AreOneLevelChildren(t.Value, t1.Value))
                        {
                            unknownSequences.Add(string.Format("{0}, lines {1}-{2}: {3} {4}", file, t1.Key, t.Key,
                                t1.Value, t.Value));
                        }
                    }
                }
            }

            callback.Invoke(unknownSequences);
        }
    }
}
