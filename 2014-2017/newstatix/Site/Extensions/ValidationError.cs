using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace UsersUI.Extensions
{
	using System.Web.UI;

	public class ValidationError : IValidator
	{
		private ValidationError(string message)
		{
			ErrorMessage = message;
			IsValid = false;
		}

		public string ErrorMessage { get; set; }

		public bool IsValid { get; set; }

		public void Validate()
		{
			// no action required
		}

		public static void Display(string message)
		{
			var currentPage = HttpContext.Current.Handler as Page;
			if (currentPage != null)
			{
				currentPage.Validators.Add(new ValidationError(message));
			}
		}
	}
}