using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UsersDb.Helpers
{
	using System.Xml.Linq;

	/// <summary>
	/// Methods which help to work with xml.
	/// </summary>
	public class XmlHelper
	{
		/// <summary>
		/// Removes the empty elements.
		/// </summary>
		/// <param name="doc">The doc.</param>
		public static void RemoveEmptyElements(XDocument doc)
		{
			// remove empty elements
			var emptyElements = doc.Descendants()
				.Where(n => n.IsEmpty || string.IsNullOrWhiteSpace(n.Value))
				.ToList();

			while (emptyElements.Any())
			{
				emptyElements.First().Remove();
				emptyElements.RemoveAt(0);
			}
		}

		/// <summary>
		/// Removes the element.
		/// </summary>
		/// <param name="root">The root.</param>
		/// <param name="name">The name.</param>
		public static void DeleteElement(XElement root, string name)
		{
			var el = root.Elements().FirstOrDefault(e => e.Name == name);
			if (el != null)
			{
				el.Remove();
			}
		}

		/// <summary>
		/// Renames the root element.
		/// </summary>
		/// <param name="doc">The doc.</param>
		/// <param name="newName">The new name.</param>
		public static void RenameRootElement(XDocument doc, string newName)
		{
			if (doc.Root != null)
			{
				doc.Root.Name = newName;
			}
		}

		/// <summary>
		/// Renames the element.
		/// </summary>
		/// <param name="root">The root.</param>
		/// <param name="currentName">Name of the current.</param>
		/// <param name="newName">The new name.</param>
		public static void RenameElement(XElement root, string currentName, string newName)
		{
			var el = root.Elements().FirstOrDefault(e => e.Name == currentName);
			if (el != null)
			{
				el.Name = newName;
			}
		}
	}
}
