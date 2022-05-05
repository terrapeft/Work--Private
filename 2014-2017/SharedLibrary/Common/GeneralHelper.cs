using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SharedLibrary.Common
{
    public class GeneralHelper
    {
        #region Directory

        /// <summary>
        /// Ensures the name of the file is unique, if file exists, the number will be added, e.g. file.txt -> file(1).txt -> file(2).txt.
        /// </summary>
        /// <param name="fileName">Name of the file.</param>
        /// <returns></returns>
        public static string EnsureFileName(string fileName)
        {
            var ext = Path.GetExtension(fileName) ?? string.Empty;

            var k = 0;
            while (File.Exists(fileName))
            {
                fileName = (k == 0)
                    ? fileName.Replace(ext, "(" + ++k + ")" + ext)
                    : fileName.Replace("(" + k + ")" + ext, "(" + ++k + ")" + ext);
            }

            return fileName;
        }

        /// <summary>
        /// Ensures the name of the folder is unique, if folder exists, the number will be added, e.g. Dir -> Dir(1) -> Dir(2).
        /// </summary>
        /// <param name="path">The path.</param>
        /// <returns></returns>
        public static string EnsureFolderName(string path)
        {
            var k = 0;
            while (Directory.Exists(path))
            {
                path = (k == 0)
                    ? path + "(" + ++k + ")"
                    : path.Replace("(" + k + ")", "(" + ++k + ")");
            }

            return path;
        }
        #endregion
    }
}
