using System;
using System.IO;
using System.Linq;
using System.Text;
using System.Xml;
using System.Xml.Linq;
using SharedLibrary;

namespace SpansLib.Data.XmlFormats
{
    public class XmlChecker
    {
        /// <summary>
        /// At the moment it reads file as 1251 and saves as UTF-8, currently there is a problem with the right single quotation mark - &#8217;.
        /// </summary>
        /// <param name="path">The path.</param>
        /// <param name="callback">The callback.</param>
        public static void TryFixXml(string path, Action<string> callback)
        {
            if (File.Exists(path))
            {
                var rewrite = true;
                try
                {
                    XDocument.Load(path);
                    rewrite = false;
                }
                catch (XmlException ex)
                {
                    callback.Answer(AppSettings.ReportXmlCheckerInvalidXmlTemplate, path);
                    callback.Answer(ex.ToString());
                }

                if (rewrite)
                {
                    File.WriteAllText(path, 
                        File.ReadAllText(path, Encoding.GetEncoding(AppSettings.XmlReadEncoding)), 
                        Encoding.GetEncoding(AppSettings.XmlWriteEncoding));

                    callback.Answer(AppSettings.ReportXmlCheckerReencodeTemplate, AppSettings.XmlReadEncoding, AppSettings.XmlWriteEncoding);
                }
            }
        }


        /// <summary>
        /// Removes the invalid XML chars.
        /// </summary>
        /// <param name="text">The text.</param>
        /// <returns></returns>
        public static string RemoveInvalidXmlChars(string text)
        {
            return new string(text.Where(XmlConvert.IsXmlChar).ToArray());
        }
    }
}
