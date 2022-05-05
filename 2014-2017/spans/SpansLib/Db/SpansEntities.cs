namespace SpansLib.Db
{
    public partial class SpansEntities
    {
        public static string EfConnectionString { get; set; }

        public SpansEntities(string connStr)
            : base(connStr)
        {
        }

        public static SpansEntities GetInstance()
        {
            if (EfConnectionString == null)
                return new SpansEntities();

            return new SpansEntities(EfConnectionString);
        }
    }
}
