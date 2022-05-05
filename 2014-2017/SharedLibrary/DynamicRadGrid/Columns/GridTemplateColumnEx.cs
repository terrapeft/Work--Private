using Telerik.Web.UI;

namespace SharedLibrary.DynamicRadGrid.Columns
{
    public class GridTemplateColumnEx : GridTemplateColumn
    {
        public string UniqueNames { get; set; }
        public bool HasStoredProcParameters { get; set; }
        public string Multiple { get; set; }
    }
}