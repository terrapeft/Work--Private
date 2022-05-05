using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Sockets;

namespace SharedLibrary.IPAddress
{
    using System.Net;
    using System.Text.RegularExpressions;

    using LukeSkywalker.IPNetwork;

    /// <summary>
    /// IP addresses to list.
    /// Splits by ",", " ", ";", "\r\n", "\n", understands CIDR
    /// </summary>
    public class IpListSplitter
    {
        /// <summary>
        /// The delimiters to split strings by.
        /// </summary>
        public static readonly string[] Delimiters = { ",", " ", ";", "\r\n", "\n" };


        /// <summary>
        /// Returns array of incorrect input lines.
        /// </summary>
        /// <param name="input">The input.</param>
        /// <param name="isValid">Input is valid, when true.</param>
        /// <returns></returns>
        public static List<string> SplitErrors(string input, out bool isValid)
        {
            var rows = input.Split(Delimiters, StringSplitOptions.RemoveEmptyEntries);
            var res = rows
                .Where(ipAddr => !IsValidIp(ipAddr))
                .Select(ipAddr => $"{ipAddr} - {"invalid IP."}")
                .ToList();

            isValid = res.Count > 0;

            return res;
        }

        /// <summary>
        /// Splits the specified IPs list.
        /// Symbols ",", ";", " " "\r\n" are treated as delimiters.
        /// It is allowed to specify ip range like 127.0.0.1/24.
        /// </summary>
        /// <param name="input">The input.</param>
        /// <param name="expandRanges">When true, ranges will be expanded, otherwise mask bits will be left as is.</param>
        /// <returns>
        /// A list of IPs. Ranges are expanded and all possible IPs are returned.
        /// </returns>
        public static List<string> Split(string input, bool expandRanges = false)
        {
            List<string> temp1;
            bool temp2;
            return Split(input, out temp2, out temp1, expandRanges);
        }

        /// <summary>
        /// Splits the specified IPs list.
        /// Symbols ",", ";", " " "\r\n" are treated as delimiters.
        /// It is allowed to specify ip range like 127.0.0.1/24.
        /// </summary>
        /// <param name="input">The input.</param>
        /// <param name="isValid">Are there are any errors.</param>
        /// <param name="errors">The errors.</param>
        /// <param name="expandRanges">When true, ranges will be expanded, otherwise mask bits will be left as is.</param>
        /// <returns>
        /// A list of IPs. Ranges are expanded and all possible IPs are returned.
        /// </returns>
        public static List<string> Split(string input, out bool isValid, out List<string> errors, bool expandRanges = false)
        {
            var expandedList = new List<string>();
            errors = new List<string>();
            var rows = input.Split(Delimiters, StringSplitOptions.RemoveEmptyEntries);
            isValid = true;

            foreach (var ipAddr in rows)
            {
                if (expandRanges && (ipAddr.Contains('/') || ipAddr.Contains('\\')))
                {
                    byte? byteCidr;
                    var ip = ipAddr.Split(new[] { "/", "\\" }, StringSplitOptions.RemoveEmptyEntries)[0];

                    if (!IsValidIp(ip))
                    {
                        isValid = false;
                        errors.Add($"{ipAddr} - {"invalid IP."}");

                        continue;
                    }

                    var cidr = ipAddr.Split(new[] { "/", "\\" }, StringSplitOptions.RemoveEmptyEntries)[1];

                    if (!IPNetwork.TryParseCidr(cidr, out byteCidr))
                    {
                        isValid = false;
                        errors.Add($"{ipAddr} - {"invalid CIDR."}");

                        continue;
                    }

                    if (byteCidr != null && !IPNetwork.ValidNetmask(IPNetwork.ToNetmask((byte)byteCidr)))
                    {
                        isValid = false;
                        errors.Add($"{ipAddr} - {"invalid mask."}");

                        continue;
                    }

                    IPNetwork network = null;
                    if (!IPNetwork.TryParse(ipAddr, out network))
                    {
                        isValid = false;
                        errors.Add($"{ipAddr} - {"invalid IP or CIDR."}");

                        continue;
                    }

                    if (byteCidr == 32)
                    {
                        if (!expandedList.Contains(ip))
                        {
                            expandedList.Add(ip);
                        }

                        continue;
                    }

                    List<IPAddress> list = null;

                    try
                    {
                        list = IPNetwork.ListIPAddress(network).ToList();
                    }
                    catch (Exception ex)
                    {
                        isValid = false;
                        errors.Add($"{ipAddr} - {ex.Message}");

                        continue;
                    }

                    if (list.Any())
                    {
                        expandedList.AddRange(list.Select(i => i.ToString()).Except(expandedList));
                    }
                }
                else
                {
                    if (!IsValidIp(ipAddr))
                    {
                        isValid = false;
                        errors.Add($"{ipAddr} - {"invalid IP."}");

                        continue;
                    }

                    if (!expandedList.Contains(ipAddr))
                    {
                        expandedList.Add(ipAddr);
                    }
                }
            }

            return expandedList;
        }

        /// <summary>
        /// Test string for valid ip address format
        /// </summary>
        /// <param name="address">The ip address string</param>
        /// <returns>Returns true if address is a valid format</returns>
        public static bool IsValidIp(IPAddress address)
        {
            byte[] addBytes = address.GetAddressBytes();

            switch (address.AddressFamily)
            {
                case AddressFamily.InterNetwork:
                    if (addBytes.Length == 4)
                        return true;
                    break;
                case AddressFamily.InterNetworkV6:
                    if (addBytes.Length == 16)
                        return true;
                    break;
                default:
                    break;
            }

            return false;
        }

        /// <summary>
        /// Test string for valid ip address format
        /// </summary>
        /// <param name="address">The ip address string</param>
        /// <returns>Returns true if address is a valid format</returns>
        public static bool IsValidIp(string address)
        {
            IPAddress ip;
            if (IPAddress.TryParse(address, out ip))
            {
                switch (ip.AddressFamily)
                {
                    case AddressFamily.InterNetwork:
                        if (address.Length > 6 && address.Contains("."))
                        {
                            string[] s = address.Split('.');
                            if (s.Length == 4 && s[0].Length > 0 && s[1].Length > 0 && s[2].Length > 0 && s[3].Length > 0)
                                return true;
                        }
                        break;
                    case AddressFamily.InterNetworkV6:
                        if (address.Contains(":") && address.Length > 15)
                            return true;
                        break;
                    default:
                        break;
                }
            }

            return false;
        }
    }
}