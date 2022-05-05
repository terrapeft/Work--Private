using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Data.Objects;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using SharedLibrary.IPAddress;
using UsersDb.DataContext;
using UsersDb.Helpers;

namespace UsersUI.DynamicData.FieldTemplates
{
    public partial class IpRange_EditField : System.Web.DynamicData.FieldTemplateUserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            TextBox1.MaxLength = Column.MaxLength;
            if (Column.MaxLength < 20)
                TextBox1.Columns = Column.MaxLength;

            if (Mode == DataBoundControlMode.Insert)
            {
                TextBox1.TextMode = TextBoxMode.MultiLine;
                TextBox1.Height = 350;
            }

            TextBox1.Width = 340;
            TextBox1.ToolTip = Column.Description;

            SetUpValidator(RequiredFieldValidator1);
            SetUpValidator(RegularExpressionValidator1);
            SetUpValidator(DynamicValidator1);
        }

        protected override void ExtractValues(IOrderedDictionary dictionary)
        {
            dictionary[Column.Name] = ConvertEditedValue(TextBox1.Text.Trim());
        }

        public override Control DataControl => TextBox1;

        protected void CustomValidator1_OnServerValidate(object source, ServerValidateEventArgs args)
        {
            try
            {
                bool isValid;
                var errorsSum = new List<string>();
                var exclude = new List<string>();
                var iplist = new List<string>();

                List<string> errors;

                if (Mode == DataBoundControlMode.Insert)
                {
                    iplist = IpListSplitter.Split(TextBox1.Text, out isValid, out errors);
                    errorsSum = errors;
                }
                else
                {
                    if (!IpListSplitter.IsValidIp(TextBox1.Text))
                    {
                        isValid = false;
                        errorsSum.Add($"{TextBox1.Text} - {"invalid IP."}");
                    }
                    else
                    {
                        isValid = true;
                        iplist = new List<string> { TextBox1.Text };
                        exclude.Add(origValueTextBox.Value);
                    }
                }

                using (var dc = new UsersDataContext())
                {
                    // compare strings
                    var ips = dc.IPs
                        .Select(i => i.Ip)
                        .Except(exclude)
                        .ToList();

                    isValid &= IpAddressHelper.EnsureIntersections(ips, iplist, out errors);
                    errorsSum = errorsSum.Concat(errors).ToList();

                    CustomValidator1.ErrorMessage = string.Join("<br>", errorsSum);

                    args.IsValid = isValid;
                }
            }
            catch
            {
                args.IsValid = false;
            }
        }
    }
}
