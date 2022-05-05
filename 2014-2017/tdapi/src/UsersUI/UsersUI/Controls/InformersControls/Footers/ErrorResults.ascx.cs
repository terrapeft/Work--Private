using System;

namespace UsersUI.Controls.InformersControls.Footers
{
	public partial class ErrorResults : System.Web.UI.UserControl
	{
		public string AppName { get; set; }
        public string ExceptionType { get; set; }
	    public bool Include { get; set; }

	    protected override void OnLoad(EventArgs e)
	    {
	        base.OnLoad(e);
            link1.HRef += string.Format("?app={0}", AppName);
            if (!string.IsNullOrWhiteSpace(ExceptionType))
            {
                link1.HRef += string.Format("&ex={0}", ExceptionType);
                link1.HRef += string.Format("&i={0}", Include ? 1 : 0);
            }
	    }
	}
}