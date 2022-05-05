using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading;
using System.Windows.Forms;

namespace Scraper
{
    class Program
    {
        private static string[] _args;

        /// <summary>
        /// STA is required, as we use WebBrowser which is actually an ActiveX wrapper.
        /// </summary>
        /// <param name="args">The arguments.</param>
        [STAThread]
        static void Main(string[] args)
        {
            EventLogHelper.VerifyLog(AppSettings.EventLog);

            try
            {
                _args = args;

                if (_args.Any(a => a.EndsWith("start", StringComparison.OrdinalIgnoreCase)))
                {
                    var thdBrowser = new Thread(Start);
                    thdBrowser.SetApartmentState(ApartmentState.STA);
                    thdBrowser.Start();
                }
                else
                {
                    PrintLine("To start scraping, specify the -start parameter");
                    PrintLine("To show browser window, specify the -spy parameter");
                    PrintLine();
                    PrintLine("Example: sirt.exe -start -spy");
                }
            }
            catch (Exception ex)
            {
                PrintLine(ex.Message);
                Application.Exit();
            }
        }

        private static void Start()
        {
            try
            {
                var showBrowser = _args.Any(a => a.EndsWith("spy", StringComparison.OrdinalIgnoreCase));

                Browser.Load(AppSettings.Url, showBrowser, (msg, data) =>
                {
                    //Debugger.Launch();

                    PrintLine(msg);

                    // data is null for the initial page load, when only a message for console is returned
                    if (data != null)
                    {
                        using (var conn = new SqlConnection(ConfigurationManager.ConnectionStrings["connString"].ConnectionString))
                        {
                            var cmd = new SqlCommand("spFOPCompareAndInsertRecord", conn) { CommandType = CommandType.StoredProcedure, CommandTimeout = 3600000};
                            cmd.Parameters.Add("@user", SqlDbType.NVarChar).Value = $@"{Environment.UserDomainName}\{Environment.UserName}";
                            cmd.Parameters.Add("@data", SqlDbType.Structured).Value = data;
                            cmd.Parameters.Add("@recipients", SqlDbType.NVarChar).Value = AppSettings.RecipientsTemplate;
                            cmd.Parameters.Add("@mail_profile", SqlDbType.NVarChar).Value = AppSettings.SqlServerMailProfile;
                            cmd.Parameters.Add("@subject_text", SqlDbType.NVarChar).Value = string.Format(AppSettings.SubjectFormat, DateTime.Now);

                            var @return = cmd.Parameters.Add("@Return", SqlDbType.Int);
                            @return.Direction = ParameterDirection.ReturnValue;

                            Print("Sending data to SQL server...");
                            conn.Open();

                            var dataset = new DataSet();
                            using (var adp = new SqlDataAdapter(cmd))
                            {
                                adp.Fill(dataset);
                            }

                            // 101 means record was added, 
                            // 0 means previous record is the same and nothing was added to db.
                            PrintLine((int)@return.Value == 101 ? "done." : 
                                (int)@return.Value == 100 
                                    ? "no changes, record was not added." 
                                    : $"Unknown return value: {@return.Value}");

                            if (!showBrowser)
                            {
                                Application.Exit();
                            }
                        }
                    }
                });

            }
            catch (Exception ex)
            {
                PrintLine(ex.Message);
                Application.Exit();
            }
        }

        private static void Print(string msg)
        {
            Console.Write(msg);
            EventLogHelper.Write(msg);
        }

        private static void PrintLine(string msg)
        {
            Console.WriteLine(msg);
            EventLogHelper.Write(msg);
        }

        private static void PrintLine()
        {
            Console.WriteLine();
        }
    }
}
