using System;
using System.IO;
using SpansLib.Data.PositionalFormats.FileReaders;
using SpansLib.Data.PositionalFormats.FileWriters;

namespace SpansLib.Data
{
    /// <summary>
    /// Determines readers and writers for files.
    /// </summary>
    public class FileFactory
    {
        /// <summary>
        /// Gets the file reader by file extension.
        /// </summary>
        /// <param name="fullFileName">Full name of the file.</param>
        /// <returns></returns>
        public static IFileReader GetReader(string fullFileName)
        {
            var ext = (Path.GetExtension(fullFileName) ?? string.Empty);

            if (ext.Equals(Constants.Pa2Ext, StringComparison.OrdinalIgnoreCase))
                return new Pa2FileReader(fullFileName);

            if (ext.Equals(Constants.Pa3Ext, StringComparison.OrdinalIgnoreCase))
                return new Pa3FileReader(fullFileName);

            if (ext.Equals(Constants.Pa5Ext, StringComparison.OrdinalIgnoreCase))
                return new Pa5FileReader(fullFileName);

            if (ext.Equals(Constants.Pa6Ext, StringComparison.OrdinalIgnoreCase))
                return new Pa6FileReader(fullFileName);

            return null;
        }

        /// <summary>
        /// Gets the file writer by file extension.
        /// </summary>
        /// <param name="fullFileName">Full name of the file.</param>
        /// <returns></returns>
        public static IFileWriter GetWriter(string fullFileName)
        {
            var ext = (Path.GetExtension(fullFileName) ?? string.Empty);

            if (ext.Equals(Constants.Pa2Ext, StringComparison.OrdinalIgnoreCase))
                return new Pa2FileWriter(fullFileName);

            if (ext.Equals(Constants.Pa3Ext, StringComparison.OrdinalIgnoreCase))
                return new Pa3FileWriter(fullFileName);

            if (ext.Equals(Constants.Pa5Ext, StringComparison.OrdinalIgnoreCase))
                return new Pa5FileWriter(fullFileName);

            if (ext.Equals(Constants.Pa6Ext, StringComparison.OrdinalIgnoreCase))
                return new Pa6FileWriter(fullFileName);

            return null;
        }
    }
}
