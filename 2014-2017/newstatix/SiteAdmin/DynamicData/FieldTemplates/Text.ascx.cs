using System.Web.UI;

namespace AdministrativeUI
{
    public partial class TextField : System.Web.DynamicData.FieldTemplateUserControl
    {
        public override string FieldValueString
        {
            get { return base.FieldValueString.Length > 250 ? base.FieldValueString.Substring(0, 250) + " [...]" : base.FieldValueString; }
        }

        public override Control DataControl
        {
            get
            {
                return Literal1;
            }
        }

    }
}
