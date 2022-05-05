using System;
using System.Linq;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using SharedLibrary.IPAddress;

namespace SharedLibraryTests
{
    [TestClass]
    public class IpListSplitterTests
    {
        [TestMethod]
        public void Check_If_IP_Of_Version_4()
        {
            Assert.IsTrue(IpListSplitter.IsIPv4("127.0.0.1"), "Check 1");

            Assert.IsFalse(IpListSplitter.IsIPv4(".0.0.1.2"), "Check 2");
            Assert.IsFalse(IpListSplitter.IsIPv4("127.0.0"), "Check 3");
            Assert.IsFalse(IpListSplitter.IsIPv4("127.0.0."), "Check 4");
            Assert.IsFalse(IpListSplitter.IsIPv4("127.0.0.1.2"), "Check 5");
            Assert.IsFalse(IpListSplitter.IsIPv4("FE80::0202:B3FF:FE1E:8329"), "Check 6");
        }

        [TestMethod]
        public void Get_IP_List_ReturnInvalidResults()
        {
            var input = "127.0.0.1,127.0.0.2; 127.0.0.3 FE80::0202:B3FF:FE1E:8329  1.1.1.1\r\n1.1.1.2\n1.1.1.3=1.1.1.4";
            var list = IpListSplitter.Split(input);
            
            Assert.IsTrue(list.Count == 7, "Wrong list.");
            Assert.IsTrue(list[3].Contains("invalid IP"), "Changed message?");
            Assert.IsTrue(list[6].Contains("invalid IP"), "Changed message?");
        }

        [TestMethod]
        public void Get_IP_List_SkipInvalidResults()
        {
            var input = "127.0.0.1,127.0.0.2; 127.0.0.3 FE80::0202:B3FF:FE1E:8329  1.1.1.1\r\n1.1.1.2\n1.1.1.3=1.1.1.4";
            var list = IpListSplitter.Split(input, true);

            Assert.IsTrue(list.Count == 5, "Wrong list.");
            Assert.IsTrue(list.All(IpListSplitter.IsIPv4), "Invalid items in IP list.");
        }

        [TestMethod]
        public void Expand_IP_List_From_CIDR_And_Check_FirstAndLast_Items()
        {
            var list = IpListSplitter.Split("127.0.0.0/30", true);
            Assert.IsTrue(list.Count == 4, "Wrong list 1.");
            Assert.IsTrue(list[0] == "127.0.0.0", "Wrong first item 1.");
            Assert.IsTrue(list[3] == "127.0.0.3", "Wrong slast item 1.");

            list = IpListSplitter.Split("127.0.0.3/30", true);
            Assert.IsTrue(list.Count == 4, "Wrong list 2.");
            Assert.IsTrue(list[0] == "127.0.0.0", "Wrong first item 2.");
            Assert.IsTrue(list[3] == "127.0.0.3", "Wrong slast item 2.");
        }

        [TestMethod]
        public void Expand_IP_List_From_CIDR_And_Check_FirstAndLast_Items_2()
        {
            var list = IpListSplitter.Split("127.0.0.4/30", true);
            Assert.IsTrue(list.Count == 4, "Wrong list.");
            Assert.IsTrue(list[0] == "127.0.0.4", "Wrong first item.");
            Assert.IsTrue(list[3] == "127.0.0.7", "Wrong slast item.");
        }

        [TestMethod]
        public void Expand_IP_List_From_CIDR_Number_Of_Elements()
        {
            var list = IpListSplitter.Split("127.0.0.4/27", true);
            Assert.IsTrue(list.Count == 32, "Wrong list /27.");

            list = IpListSplitter.Split("127.0.0.4/16", true);
            Assert.IsTrue(list.Count == 65536, "Wrong list /16.");
        }

        [TestMethod]
        public void Expand_IP_List_From_CIDR_With_Backslash_Fail()
        {
            var list = IpListSplitter.Split("127.0.0.4\\30", true);
            Assert.IsTrue(list.Count == 0, "Wrong list.");

            list = IpListSplitter.Split("127.0.0.4\\30");
            Assert.IsTrue(list.Count == 1);
            Assert.IsTrue(list[0].Contains("invalid IP or CIDR"));
        }

        [TestMethod]
        public void Expand_IP_Invalid_Mask()
        {
            var list = IpListSplitter.Split("127.0.0.4/55", true);
            Assert.IsTrue(list.Count == 0);

            list = IpListSplitter.Split("127.0.0.4/55");
            Assert.IsTrue(list.Count == 1);
            Assert.IsTrue(list[0].Contains("invalid CIDR"));
        }

        [TestMethod]
        public void Expand_IP_Invalid_CIDR()
        {
            var list = IpListSplitter.Split("127.0.0.4/qw", true);
            Assert.IsTrue(list.Count == 0);

            list = IpListSplitter.Split("127.0.0.4/qw");
            Assert.IsTrue(list.Count == 1);
            Assert.IsTrue(list[0].Contains("invalid CIDR"));
        }
    }
}
