using System;
using System.Collections.Specialized;
using System.ComponentModel.DataAnnotations;
using System.Web.DynamicData;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SharedLibrary;
using UsersDb;
using UsersDb.DataContext;
using UsersDb.Helpers;

namespace UsersUI
{
    public partial class DateTimeField : System.Web.DynamicData.FieldTemplateUserControl
    {
        public override Control DataControl
        {
            get
            {
                return Literal1;
            }
        }

        protected string GetDisplayString()
        {
            if (FieldValue == null || FieldValue == DBNull.Value) return null;

            var code = UsersDataContext.CurrentSessionUser.TimeZone.Code;
            return ((DateTime)FieldValue).ToUserLocalDateTimeString(code);
        }
    }
}
