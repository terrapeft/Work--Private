using System;
using System.Collections.Specialized;
using System.Web.UI;
using System.Web.UI.WebControls;
using SharedLibrary.Passwords;

namespace AdministrativeUI.DynamicData.FieldTemplates
{
    public partial class Password_EditField : System.Web.DynamicData.FieldTemplateUserControl
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			SetUpValidator(RequiredFieldValidator1);
			SetUpValidator(DynamicValidator1);
		}

		protected override void ExtractValues(IOrderedDictionary dictionary)
		{
			var salt = userValueForSaltInput.Value;
			var pwd = userValueForPasswordInput.Value;
			
			if (!TextBox1.Text.Contains("●") && !string.IsNullOrWhiteSpace(TextBox1.Text))
			{
				var ch = new CryptoHelper();
				salt = ch.CreateSalt();
				pwd = ch.CreatePasswordHash(this.TextBox1.Text, salt);
			}

			dictionary["Password"] = this.ConvertEditedValue(pwd);
			dictionary["Salt"] = this.ConvertEditedValue(salt);
		}

		protected override void OnDataBinding(EventArgs e)
		{
			if (Mode == DataBoundControlMode.Edit)
			{
				userValueForPasswordInput.Value = FieldValueEditString;
				userValueForSaltInput.Value = this.GetColumnValue(Table.GetColumn("Salt")).ToString();

				TextBox1.Text = string.IsNullOrWhiteSpace(FieldValueEditString) ? string.Empty : new String('●', 7);
			}
		}

		public override Control DataControl
		{
			get
			{
				return this.TextBox1;
			}
		}
	}
}
