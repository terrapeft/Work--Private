using System;
using System.Globalization;
using System.Linq;
using System.Text.RegularExpressions;

namespace UsersDb.Helpers
{
    public class HtmlHighlightHelper
    {
        private const string highlightSpan = "<span class=\"{0}\">{1}</span>";

        /// <summary>
        /// Wraps matched strings in HTML span elements styled with a background-color
        /// </summary>
        /// <param name="htmlText">The HTML text.</param>
        /// <param name="keywords">Comma|space-separated list of strings to be highlighted</param>
        /// <param name="cssClass">The Css color to apply</param>
        /// <param name="option">The option.</param>
        /// <returns></returns>
        public static string HighlightKeyWords(string htmlText, string keywords, string cssClass, SearchOptions option)
        {
            if (string.IsNullOrWhiteSpace(htmlText) || string.IsNullOrWhiteSpace(keywords) || string.IsNullOrWhiteSpace(cssClass))
            {
                return htmlText;
            }

            var words = keywords.Split(new[] { Constants.DefaultDelimiter }, StringSplitOptions.RemoveEmptyEntries);

            switch (option)
            {
                case SearchOptions.Equals:
                    htmlText = words
                        .Select(word => "\\b" + word.Trim() + "\\b")
                        .Aggregate(htmlText, (current, pattern) => Regex.Replace(current, pattern, string.Format(highlightSpan, cssClass, "$0"), RegexOptions.IgnoreCase));
                    break;
                case SearchOptions.StartsWith:
                    htmlText = words
                        .Select(word => "^" + word.Trim())
                        .Aggregate(htmlText, (current, pattern) => Regex.Replace(current, pattern, string.Format(highlightSpan, cssClass, "$0"), RegexOptions.IgnoreCase));
                    break;
                case SearchOptions.EndsWith:
                    htmlText = words
                        .Select(word => word.Trim() + "$")
                        .Aggregate(htmlText, (current, pattern) => Regex.Replace(current, pattern, string.Format(highlightSpan, cssClass, "$0"), RegexOptions.IgnoreCase));
                    break;
                case SearchOptions.Contains:
                default:
                    htmlText = words
                        .Select(word => word.Trim())
                        .Aggregate(htmlText, (current, pattern)
                            => Regex.Replace(current, pattern, string.Format(highlightSpan, cssClass, "$0"), RegexOptions.IgnoreCase));
                    break;
            }

            return htmlText;
        }

        /// <summary>
        /// Test if htmlText contains the keyword.
        /// </summary>
        /// <param name="htmlText">The HTML text.</param>
        /// <param name="keyword">The keyword.</param>
        /// <param name="option">The option.</param>
        /// <returns></returns>
        public static bool MatchKeyword(string htmlText, string keyword, SearchOptions option)
        {
            if (string.IsNullOrWhiteSpace(htmlText) || string.IsNullOrWhiteSpace(keyword))
            {
                return false;
            }

            switch (option)
            {
                case SearchOptions.Equals:
                    return htmlText.Equals(keyword.Trim(), StringComparison.InvariantCultureIgnoreCase);

                case SearchOptions.StartsWith:
                    return htmlText.StartsWith(keyword.Trim(), StringComparison.InvariantCultureIgnoreCase);

                case SearchOptions.EndsWith:
                    return htmlText.EndsWith(keyword.Trim(), StringComparison.InvariantCultureIgnoreCase);

                case SearchOptions.Contains:
                default:
                    return CultureInfo.InvariantCulture.CompareInfo.IndexOf(htmlText, keyword, CompareOptions.IgnoreCase) > -1;
            }
        }
    }
}
