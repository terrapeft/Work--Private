using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using SharedLibrary.IPAddress;

namespace UsersUITests
{
	using System.Collections.Generic;

	using UsersDb.Helpers;

	[TestClass]
	public class IpSplitterTests
	{
		[TestMethod]
		public void IpListSplitter_Single_IP_Test()
		{
			var expected = new List<string> { "127.0.0.1" };

			var res = IpListSplitter.Split("127.0.0.1");

			Assert.IsTrue(res.Count == 1, "Single IP test 1 failed.");
			Assert.AreEqual(expected[0], res[0], "Single IP test 1.1 failed.");



			res = IpListSplitter.Split(" 127.0.0.1 ");

			Assert.IsTrue(res.Count == 1, "Single IP test 2 failed.");
			Assert.AreEqual(expected[0], res[0], "Single IP test 2.1 failed.");



			res = IpListSplitter.Split(string.Format("{0} 127.0.0.1 {0}", Environment.NewLine));

			Assert.IsTrue(res.Count == 1, "Single IP test 3 failed.");
			Assert.AreEqual(expected[0], res[0], "Single IP test 3.1 failed.");



			res = IpListSplitter.Split(string.Format(", 127.0.0.1; {0},", Environment.NewLine));

			Assert.IsTrue(res.Count == 1, "Single IP test 4 failed.");
			Assert.AreEqual(expected[0], res[0], "Single IP test 4.1 failed.");
		}

		[TestMethod]
		public void IpListSplitter_IP_List_Test()
		{
			var expected = new List<string> { "127.0.0.1", "192.168.0.1", "1.1.1.1" };



			var res = IpListSplitter.Split("127.0.0.1 192.168.0.1, 1.1.1.1");

			Assert.IsTrue(res.Count == 3, "List IP test 1 failed.");
			Assert.AreEqual(expected[0], res[0], "List IP test 1.1 failed.");
			Assert.AreEqual(expected[1], res[1], "List IP test 1.2 failed.");
			Assert.AreEqual(expected[2], res[2], "List IP test 1.3 failed.");



			res = IpListSplitter.Split(string.Format("   127.0.0.1 {0} 192.168.0.1, 1.1.1.1", Environment.NewLine));

			Assert.IsTrue(res.Count == 3, "List IP test 2 failed.");
			Assert.AreEqual(expected[0], res[0], "List IP test 2.1 failed.");
			Assert.AreEqual(expected[1], res[1], "List IP test 2.2 failed.");
			Assert.AreEqual(expected[2], res[2], "List IP test 2.3 failed.");



			res = IpListSplitter.Split(string.Format("{0}127.0.0.1{0}192.168.0.1{0}1.1.1.1{0}{0},{0}", Environment.NewLine));

			Assert.IsTrue(res.Count == 3, "List IP test 3 failed.");
			Assert.AreEqual(expected[0], res[0], "List IP test 3.1 failed.");
			Assert.AreEqual(expected[1], res[1], "List IP test 3.2 failed.");
			Assert.AreEqual(expected[2], res[2], "List IP test 3.3 failed.");
		}

		[TestMethod]
		public void IpListSplitter_IP_CIDR_Test()
		{
			// all's good
			var res = IpListSplitter.Split("192.168.0.1/31");

			Assert.IsTrue(res.Count == 2, "CIDR IP test 1 failed.");
			Assert.AreEqual("192.168.0.0", res[0], "CIDR IP test 1.1 failed.");
			Assert.AreEqual("192.168.0.1", res[1], "CIDR IP test 1.2 failed.");


			// max value
			res = IpListSplitter.Split("192.168.0.1/32");

			Assert.IsTrue(res.Count == 1, "CIDR IP test 2 failed.");
			Assert.AreEqual("192.168.0.1", res[0], "CIDR IP test 2.1 failed.");


			// zero
			res = IpListSplitter.Split("192.168.0.1/0");

			Assert.IsTrue(res.Count == 0, "CIDR IP test 3 failed.");
			//Assert.AreEqual("192.168.0.1/0: ...", res[0], "CIDR IP test 3.1 failed.");

			
			// incorrect CIDR
			res = IpListSplitter.Split("192.168.0.1/-2");

			Assert.IsTrue(res.Count == 1, "CIDR IP test 4 failed.");
			Assert.AreEqual("192.168.0.1/-2: invalid CIDR.", res[0], "CIDR IP test 4.1 failed.");


			// letter in CIDR
			res = IpListSplitter.Split("192.168.0.1/24r");

			Assert.IsTrue(res.Count == 1, "CIDR IP test 5 failed.");
			Assert.AreEqual("192.168.0.1/24r: invalid CIDR.", res[0], "CIDR IP test 5.1 failed.");


			// CIDR out of range
			res = IpListSplitter.Split("192.168.0.1/33");

			Assert.IsTrue(res.Count == 1, "CIDR IP test 6 failed.");
			Assert.AreEqual("192.168.0.1/33: invalid CIDR.", res[0], "CIDR IP test 6.1 failed.");
		}


		[TestMethod]
		public void IpListSplitter_IP_All_Together_With_Duplicates_In_List_And_Range_Test()
		{
			var res = IpListSplitter.Split("127.0.0.1, 127.0.0.1; 127.0.0.1/32 192.168.0.1/31\r\n, 127.0.0.1/31");

			Assert.IsTrue(res.Count == 4, "All IP test 1 failed.");
			Assert.AreEqual("127.0.0.1", res[0], "All IP test 1.1 failed.");
			Assert.AreEqual("192.168.0.0", res[1], "All IP test 1.2 failed.");
			Assert.AreEqual("192.168.0.1", res[2], "All IP test 1.3 failed.");
			Assert.AreEqual("127.0.0.0", res[3], "All IP test 1.4 failed.");
		}

		[TestMethod]
		public void IpListSplitter_Invalid_IP_Test()
		{
			var res = IpListSplitter.Split("mangalore, 127.o.o.1; 256.0.0.1; 127.a.0.1/31");

			Assert.IsTrue(res.Count == 4, "Invalid IP test 1 failed.");
			Assert.AreEqual("mangalore: invalid IP.", res[0], "Invalid IP test 1.1 failed.");
			Assert.AreEqual("127.o.o.1: invalid IP.", res[1], "Invalid IP test 1.2 failed.");
			Assert.AreEqual("256.0.0.1: invalid IP.", res[2], "Invalid IP test 1.3 failed.");
			Assert.AreEqual("127.a.0.1/31: invalid IP.", res[3], "Invalid IP test 1.4 failed.");
		}

		[TestMethod]
		public void IpListSplitter_Skip_Errors_Test()
		{
			var res = IpListSplitter.Split("mangalore, 127.11.11.22, 300.256.1.1; 127.o.o.1; 127.a.0.1/31 127.0.0.1/zzzz", true);

			Assert.IsTrue(res.Count == 1, "Skip errors test 1 failed.");
			Assert.AreEqual("127.11.11.22", res[0], "Skip errors test 1.1 failed.");
		}


	}
}