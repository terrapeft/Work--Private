using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace UsersUI.Helpers
{
	using System.Text;

	public class XsltHelper
	{
		/// <summary>
		/// Splits the XSLT parameters taken from the Informers table.
		/// </summary>
		/// <param name="value">The value.</param>
		/// <returns></returns>
		public static Dictionary<string, string> SplitXsltParameters(string value)
		{
			return value
				.Split(new[] { '|' }, StringSplitOptions.RemoveEmptyEntries)
				.Select(pair => pair.Split(new[] { '=' }, StringSplitOptions.RemoveEmptyEntries))
				.ToDictionary(part => part[0], part => part.Length == 1 ? string.Empty : part[1]);
		}

		/// <summary>
		/// Gets the XSLT parameter value, checking the key for existance and returns empty string if a key not found.
		/// </summary>
		/// <param name="dict">The dict.</param>
		/// <param name="pName">Name of the p.</param>
		/// <returns></returns>
		public static string GetXsltParameter(Dictionary<string, string> dict, string pName)
		{
			return dict.ContainsKey(pName) ? dict[pName] : string.Empty;
		}

		/// <summary>
		/// Merges the XSLT parameters.
		/// </summary>
		/// <param name="value">The value.</param>
		/// <returns></returns>
		public static string MergeXsltParameters(string value)
		{
			var sb = new StringBuilder();

			if (!string.IsNullOrEmpty(value))
			{
				var @params = value.Split(new[] { '|' });

				foreach (string name in @params)
				{
					sb.AppendFormat("{0}={1}|", name, GetRequestParamValue(name));
				}
			}

			return sb.Length == 0 ? string.Empty : sb.Remove(sb.Length - 1, 1).ToString();
		}

		/// <summary>
		/// Gets the input value from the Form keys collection.
		/// </summary>
		/// <param name="name">The name.</param>
		/// <returns></returns>
		public static string GetRequestParamValue(string name)
		{
			var key = HttpContext.Current.Request.Form.AllKeys.FirstOrDefault(k => k.EndsWith(name + "TextBox"));
			return (key != null) ? HttpContext.Current.Request.Form[key] : null;
		}
	}
}