using System.Web.UI;

namespace AdministrativeUI.DynamicData.FieldTemplates
{
    public partial class Password : System.Web.DynamicData.FieldTemplateUserControl
	{
		public override Control DataControl
		{
			get
			{
				return this.Literal1;
			}
		}
	}
}
