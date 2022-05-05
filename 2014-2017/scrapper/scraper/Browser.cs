using System;
using System.Data;
using System.Drawing;
using System.Windows.Forms;
using HtmlDocument = HtmlAgilityPack.HtmlDocument;

namespace Scraper
{

    /// <summary>
    /// Highly specialized class to load one page and scrape the data from the named element.
    /// </summary>
    public class Browser
    {
        private static Action<string, DataTable> _getResultAction;

        /// <summary>
        /// Loads the sirt page.
        /// </summary>
        /// <param name="url">The URL.</param>
        /// <param name="showBrowser">if set to <c>true</c> [show browser].</param>
        /// <param name="getResultAction">The get result action.</param>
        public static void Load(string url, bool showBrowser, Action<string, DataTable> getResultAction)
        {
            _getResultAction = getResultAction;

            // By default WebBrowser works in IE7 emulation mode, the sirt page is not updated on the click in this mode.
            // I check the IE version, and set emulation mode for the sirt.exe to this or nearest value.
            // There is a reg key for this, so this check can be done once for the machine.
            if (!IeEmulation.IsBrowserEmulationSet())
            {
                IeEmulation.SetBrowserEmulationVersion();
            }

            HtmlElement checkbox;
            var browser = new WebBrowser();

            if (showBrowser)
            {
                var form1 = new Form { Size = new Size(AppSettings.FormInitialWidth, AppSettings.FormInitialHeight) };
                browser.Dock = DockStyle.Fill;

                // as we have and Application.Run() call further in the code, the console app won't close automatically
                form1.FormClosed += (sender, args) => Application.Exit();

                form1.Controls.Add(browser);
                form1.Show();
            }

            var currentStep = 0;

            browser.DocumentCompleted += (sender, args) =>
            {
                currentStep++;

                try
                {
                    if (currentStep == 2) // this is after checkbox click
                    {
                        var doc = ((WebBrowser)sender).Document;
                        if (doc?.Body != null)
                        {
                            var hdoc = new HtmlDocument();
                            hdoc.Load(((WebBrowser) sender).DocumentStream);
                            var dt = hdoc.ToDataTable(AppSettings.DataTableId);

                            SendData("Captured, ready to save.", dt);
                        }
                        else
                        {
                            PrintMessage("Clicked, but no data was received.");
                        }
                    }
                    else if (currentStep == 1) // this is the initial page load, with paged table
                    {
                        var doc = ((WebBrowser)sender).Document;
                        if (doc != null)
                        {
                            PrintMessage("Page is loaded, looking for the checkbox.");

                            checkbox = doc.GetElementById(AppSettings.CheckBoxId);

                            if (checkbox != null)
                            {
                                // do click
                                checkbox.InvokeMember("click");
                                PrintMessage("Found, clicked.");
                            }
                            else
                            {
                                PrintMessage("Checkbox was not found:");
                                PrintMessage(((WebBrowser)sender).DocumentText);
                                Application.Exit();
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    PrintMessage(ex.ToString());
                }
            };

            try
            {
                // start loading
                browser.Navigate(url);

                // we need a message loop to wait until the document is loaded
                Application.Run();
            }
            catch (Exception ex)
            {
                PrintMessage(ex.ToString());
            }
        }

        private static void PrintMessage(string msg)
        {
            if (_getResultAction != null)
            {
                _getResultAction.Invoke(msg, null);
            }
        }

        private static void SendData(string msg, dynamic data)
        {
            if (_getResultAction != null)
            {
                _getResultAction.Invoke(msg, data);
            }
        }
    }
}
