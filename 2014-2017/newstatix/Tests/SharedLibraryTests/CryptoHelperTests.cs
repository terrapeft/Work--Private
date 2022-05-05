using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using SharedLibrary.Passwords;

namespace SharedLibraryTests
{
    [TestClass]
    public class CryptoHelperTests
    {
        [TestMethod]
        public void VerifyPassword_Fail()
        {
            var sut = new CryptoHelper();
            var pwd = "$123#";
            var salt = sut.CreateSalt();
            var pwdHash = sut.CreatePasswordHash(pwd, salt);
            var result = sut.VerifyPassword("wrong", pwdHash, salt);

            Assert.IsFalse(result);
        }

        [TestMethod]
        public void VerifyPassword_DefaultParameters()
        {
            var sut = new CryptoHelper();
            var pwd = "$123#";
            var salt = sut.CreateSalt();
            var pwdHash = sut.CreatePasswordHash(pwd, salt);
            var result = sut.VerifyPassword(pwd, pwdHash, salt);

            Assert.IsTrue(result);
        }

        [TestMethod]
        public void VerifyPassword_CustomParameters()
        {
            var sut = new CryptoHelper(731, 8, 8);
            var pwd = "$123#";
            var salt = sut.CreateSalt();
            var pwdHash = sut.CreatePasswordHash(pwd, salt);
            var result = sut.VerifyPassword(pwd, pwdHash, salt);

            Assert.IsTrue(result);
        }

        [TestMethod]
        public void VerifyPassword_CustomParameters_MinimalSize()
        {
            var sut = new CryptoHelper(731, 4, 4);
            var salt = sut.CreateSalt();
            var pwdHash = sut.CreatePasswordHash("123", salt);

            Assert.AreEqual(8, Convert.FromBase64String(salt).Length, "Salt size is incorrect");
            Assert.AreEqual(8, Convert.FromBase64String(pwdHash).Length, "Pwd length is incorrect");
        }
    }
}
