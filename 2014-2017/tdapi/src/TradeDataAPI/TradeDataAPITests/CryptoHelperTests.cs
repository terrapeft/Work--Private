using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using SharedLibrary.Passwords;

namespace ExportDataServiceTests
{

	using UsersDb.Helpers;

	[TestClass]
	public class CryptoHelperTests
	{
		[TestMethod]
		public void VerifyPassword_WithMatching_SizesOf_SaltAndHash_Test()
		{
			var sut = new CryptoHelper(10000, 16, 20);

			var salt = "y4Gs4sjkFArTLNzxYjYqZw=="; //16
			var pwd = "jqzQLN8T62N5VS57z8iiT4bnd58="; //20

			Assert.AreEqual(pwd, sut.CreatePasswordHash("qwertyuiop44", salt));
		}

		[TestMethod]
		public void VerifyPassword_WithLess_SizesOf_SaltAndHash_Test()
		{
			var sut = new CryptoHelper(10000, 10, 20);

			var salt = "y4Gs4sjkFArTLNzxYjYqZw=="; //16
			var pwd = "jqzQLN8T62N5VS57z8iiT4bnd58="; //20

			Assert.AreEqual(pwd, sut.CreatePasswordHash("qwertyuiop44", salt));
		}

		[TestMethod]
		public void VerifyPassword_WithGreater_SizesOf_SaltAndHash_Test()
		{
			var sut = new CryptoHelper(10000, 24, 20);

			var salt = "y4Gs4sjkFArTLNzxYjYqZw=="; //16
			var pwd = "jqzQLN8T62N5VS57z8iiT4bnd58="; //20

			Assert.AreEqual(pwd, sut.CreatePasswordHash("qwertyuiop44", salt));
		}
	}
}
