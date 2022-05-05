using System.Web;
using System.Web.UI;

namespace SharedLibrary.DynamicRadGrid
{
    /// <summary>
    /// Shows a validation error in ValidationSummary control without necessity to have validator.
    /// </summary>
    public class ValidationError : IValidator
	{
		private ValidationError(string message)
		{
			ErrorMessage = message;
			IsValid = false;
		}

        /// <summary>
        /// Gets or sets the error message text generated when the condition being validated fails.
        /// </summary>
		public string ErrorMessage { get; set; }

        /// <summary>
        /// Gets or sets a value indicating whether the user-entered content in the specified control passes validation.
        /// </summary>
		public bool IsValid { get; set; }

        /// <summary>
        /// Evaluates the condition it checks and updates the <see cref="P:System.Web.UI.IValidator.IsValid" /> property.
        /// </summary>
		public void Validate()
		{
			// no action required
		}

        /// <summary>
        /// Forces the page to show the specified message.
        /// </summary>
        /// <param name="message">The message.</param>
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