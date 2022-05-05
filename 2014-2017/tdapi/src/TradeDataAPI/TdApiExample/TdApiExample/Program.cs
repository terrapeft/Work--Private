using System;
using System.Diagnostics;
using System.IO;
using System.Net;
using System.Net.Http;

namespace TdApiExample
{
    class Program
    {
        static void Main(string[] args)
        {
            ServicePointManager.ServerCertificateValidationCallback = delegate { return true; };

            // take some data from the service and output to console
            DownloadData();

            // export search results into zip file and open it
            ExportSearchData();
        }

        static private void DownloadData()
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri("http://api.dev/");
                client.DefaultRequestHeaders.Accept.Clear();

                HttpResponseMessage response = null;

                try
                {
                    response = client.GetAsync("tda/GetBankHolidays/csv?u=vchupaev@mail.ru&p=123").Result;
                    response.EnsureSuccessStatusCode(); // treat http error codes as exceptions

                    var content = response.Content.ReadAsStringAsync().Result;
                    Console.WriteLine(content);
                }
                catch (HttpRequestException rex)
                {
                    var status = response?.StatusCode;
                    if (status != null)
                    {
                        Console.WriteLine($"{(int) status} {status}");
                    }
                    else
                    {
                        Console.WriteLine(rex);
                    }

                    response?.Dispose();
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex);
                }
            }
        }

        static private void ExportSearchData()
        {
            const string fileName = "example.zip";

            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri("http://api.dev/");

                HttpResponseMessage response = null;

                try
                {
                    // for search we use the GetBySymbol method 
                    // s - search string
                    // zip=1 - results will be compressed and send as file
                    // se=1 - include series information
                    // ps=3 - page size
                    // pn=1 - page number
                    response = client.GetAsync("tda/GetBySymbol/csv?u=vchupaev@mail.ru&p=123&s=amex&zip=1&se=1&ps=30&pn=1").Result;
                    response.EnsureSuccessStatusCode(); // treat http error codes as exceptions

                    SaveStreamInFile(response.Content.ReadAsStreamAsync().Result, fileName);
                    
                }
                catch (HttpRequestException rex)
                {
                    var status = response?.StatusCode;
                    if (status != null)
                    {
                        Console.WriteLine($"{(int)status} {status}");
                    }
                    else
                    {
                        Console.WriteLine(rex);
                    }

                    response?.Dispose();
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex);
                }
            }
        }

        private static void SaveStreamInFile(Stream stream, string fileName)
        {
            if (stream == null)
                return;

            var filePath = Path.Combine(Environment.CurrentDirectory, fileName);

            if (File.Exists(filePath))
            {
                File.Delete(filePath);
            }

            using (stream)
            using (var file = new FileStream(filePath, FileMode.Create, FileAccess.Write))
            {
                stream.CopyTo(file);
            }

            Process.Start(filePath);
        }
    }
}
