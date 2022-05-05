namespace UsersUI
{
	using System.Web.UI;

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
