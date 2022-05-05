using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Collections.Specialized;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Xml.Linq;
using System.Web.DynamicData;
using SharedLibrary;
using UsersDb.Helpers;

namespace UsersUI.DynamicData.FieldTemplates
{
	using System.Collections.Generic;
	using System.IO;
	using System.Text;

	using UsersUI.Helpers;

	public partial class XsltFile_EditField : System.Web.DynamicData.FieldTemplateUserControl
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			DropDownList1.ToolTip = Column.Description;

			if (DropDownList1.Items.Count == 0)
			{
				if (Mode == DataBoundControlMode.Insert || !Column.IsRequired)
				{
					DropDownList1.Items.Add(new ListItem("[Not Set]", String.Empty));
				}
				
				LoadFiles();
			}

			SetUpValidator(RequiredFieldValidator1);
			SetUpValidator(DynamicValidator1);
		}

		private void LoadFiles()
		{
			DropDownList1.Items.AddRange(
				Directory.EnumerateFiles(Server.MapPath("~/Content/Xslt/Informers"), "*.xslt")
				.Select(f => new ListItem(new FileInfo(f).Name))
				.ToArray());
		}

		protected override void OnDataBinding(EventArgs e)
		{
			base.OnDataBinding(e);

			var val = GetColumnValue(Table.GetColumn("XsltParameters"));
			paramsValues.Value = (val == null) ? string.Empty : val.ToString();

			if (Mode == DataBoundControlMode.Edit && FieldValue != null)
			{
				ListItem item = DropDownList1.Items.FindByValue(FieldValue.ToString());
				if (item != null)
				{
					item.Selected = true;
				}

				DropDownList1_OnSelectedIndexChanged(null, null);
			}
		}

		protected override void ExtractValues(IOrderedDictionary dictionary)
		{
			string value = DropDownList1.SelectedValue;
			if (value == String.Empty)
			{
				value = null;
			}

			dictionary[Column.Name] = ConvertEditedValue(value);

			var p = XsltHelper.MergeXsltParameters(allParamsNames.Value);
			dictionary["XsltParameters"] = ConvertEditedValue(p);
		}

		public override Control DataControl
		{
			get
			{
				return DropDownList1;
			}
		}

		protected void DropDownList1_OnSelectedIndexChanged(object sender, EventArgs e)
		{
			var doc = XElement.Load(Server.MapPath(Path.Combine("~/Content/Xslt/Informers", DropDownList1.SelectedValue)));
			var @params = doc.Elements()
				.Where(n => n.Name.LocalName.ToLower() == "param")
				.Select(n => n.Attribute("name").Value)
				.ToList();

			if (@params.Any())
			{
				allParamsNames.Value = string.Join("|", @params);

				foreach (var pName in @params)
				{
					var div = new HtmlGenericControl("div");
					div.Attributes.Add("class", "dynamic-params");

					var paramsVals = XsltHelper.SplitXsltParameters(paramsValues.Value);

					var textBox = new TextBox { 
                        ID = pName + "TextBox", 
                        Text = XsltHelper.GetXsltParameter(paramsVals, pName),
                        CssClass = "DDTextBox" + (pName.EndsWith("color", StringComparison.InvariantCultureIgnoreCase) ? " smallhsvTextBox" : string.Empty)
                    };

                    textBox.Attributes.Add("pname", pName);

					div.Controls.Add(new Label { Text = pName.UppercaseFirst().SplitStringOnCaps() + ":&nbsp;", CssClass = "DDControl" });
					div.Controls.Add(new LiteralControl("<br>"));
					div.Controls.Add(textBox);

					Controls.Add(div);
				}
			}
		}
	}
}
