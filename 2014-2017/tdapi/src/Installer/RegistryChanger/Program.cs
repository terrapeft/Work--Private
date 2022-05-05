using System;
using System.Diagnostics;
using System.Linq;
using System.Runtime.InteropServices;
using Microsoft.Win32;

namespace RegistryChanger
{
    /// <summary>
    /// This small 64 bit utility do changes in the registry to enable system proxy.
    /// It is called from the custom action during setup process with impersonation.
    /// One particular change cannot be done from the setup directly - setting the ProxyEnable=1,
    /// always results in ProxyEnable=0.
    /// </summary>
    class Program
    {
        [DllImport("wininet.dll")]
        public static extern bool InternetSetOption(IntPtr hInternet, int dwOption, IntPtr lpBuffer, int dwBufferLength);
        public const int InternetOptionSettingsChanged = 95; //39;
        public const int InternetOptionRefresh = 37;

        private static void Main(string[] args)
        {
#if DEBUG
            Debugger.Launch();
#endif
            var enableProxy = args.FirstOrDefault(a => a.StartsWith("-enableproxy", StringComparison.OrdinalIgnoreCase))?.Split('=')[1] == "1";
            var enableScripting = args.FirstOrDefault(a => a.StartsWith("-enablescripting", StringComparison.OrdinalIgnoreCase))?.Split('=')[1] == "1";
            var iSettings = Registry.CurrentUser.OpenSubKey("Software\\Microsoft\\Windows\\CurrentVersion\\Internet Settings", true);

            if (enableProxy)
            {
                var address = args.FirstOrDefault(a => a.StartsWith("-address", StringComparison.OrdinalIgnoreCase))?.Split('=')[1];
                Console.WriteLine($"address: {address ?? "null"}");

                var exceptions = args.FirstOrDefault(a => a.StartsWith("-exclude", StringComparison.OrdinalIgnoreCase))?.Split('=')[1];
                Console.WriteLine($"exceptions: {exceptions ?? "null"}");

                var existedExclusions = iSettings?.GetValue("ProxyOverride")?.ToString().TrimEnd(' ', ';');
                Console.WriteLine($"existed exceptions: {existedExclusions ?? "null"}");

                exceptions = string.Join(";", (existedExclusions ?? string.Empty).Split(';')
                    .Union((exceptions ?? string.Empty).Split(';'))).Trim(';');
                Console.WriteLine($"merged exceptions: {exceptions ?? "null"}");

                iSettings?.SetValue("ProxyOverride", exceptions);
                iSettings?.SetValue("ProxyEnable", 1);
                if (address != null) iSettings?.SetValue("ProxyServer", address);

                InternetSetOption(IntPtr.Zero, InternetOptionSettingsChanged, IntPtr.Zero, 0);
                InternetSetOption(IntPtr.Zero, InternetOptionRefresh, IntPtr.Zero, 0);
            }

            if (enableScripting)
            {
                var internetZoneSettings = iSettings?.OpenSubKey("Zones\\3", true);
                internetZoneSettings?.SetValue("1400", 0, RegistryValueKind.DWord);
            }
        }
    }
}
