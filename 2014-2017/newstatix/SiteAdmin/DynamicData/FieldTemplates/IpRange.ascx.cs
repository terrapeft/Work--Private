using System.Web.UI;

namespace AdministrativeUI.DynamicData.FieldTemplates
{
	public partial class IpRange : System.Web.DynamicData.FieldTemplateUserControl
	{
		public override Control DataControl
		{
			get
			{
				return Literal1;
			}
		}
	}
}
