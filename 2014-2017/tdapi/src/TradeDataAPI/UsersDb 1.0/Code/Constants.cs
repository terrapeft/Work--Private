namespace UsersDb.Helpers
{
	public static class Constants
	{
		public const string XymRootTableName = "XymRootLevelGlOBAL";
        public const string XymReutersTableName = "XymREUTERSTradedSeriesGLOBAL";

	    public const string ExchangeCodesCacheKey = "UniqueExchangeCodes";
        public const string ContractTypesCacheKey = "UniqueContractTypes";
        public const string CurrentUserQueryCacheKey = "CurrentQuery";
        public const string CurrentIdCacheKey = "CurrentUserId";

		public const string SearchAlias = "GetBySymbol";
        public const string SuggestionsAlias = "Suggestions";
        public const string GetSeriesLoggingAlias = "Search, load series";
        public static string ExportLoggingAlias = "Export";
		
		public const string SearchForParam = "s";
        public const string SearchOptionParam = "so";
        public const string SearchGroupsParam = "sc";

        public const string ExchangeCodeColumn = "ExchangeCode";
        public const string ContractTypeColumn = "ContractType";
        public const string ContractNumberColumn = "ContractNumber";
        public const string ContractNameColumn = "ContractName";
        public const string TickerCodeColumn = "TickerCode";

        // root 
	    public static readonly string[] XymTablesPersistentColumns =
	    {
	        ExchangeCodeColumn, 
	        ContractTypeColumn,
	        ContractNameColumn,
	        ContractNumberColumn,
	        TickerCodeColumn
	    };

	    public const char DefaultDelimiter = ',';

        public const string ForeignKeyAutoPostBackSenderId = "ddlFkAutoPostBack";
        public const string MethodStoredProcedureSenderId = "ddlMethodStoredProcedure";
        public const string MethodStoredProcedureCustomeNameSenderId = "newMethodNameTextBox";

        public const string VirtualMethodSuffix = "API Help";

        public const string NewMethodCommand = "<New method>";
    }
}