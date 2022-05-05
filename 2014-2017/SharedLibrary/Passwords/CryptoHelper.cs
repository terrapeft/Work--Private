using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;

namespace SharedLibrary.Passwords
{
    /// <summary>
    /// Uses PBKDF2-SHA1 to hash the password.
    /// </summary>
    public class CryptoHelper
    {
        private readonly int iterations;
        private readonly int saltSize;
        private readonly int hashedPwdSize;

        /// <summary>
        /// Initializes a new instance of the <see cref="CryptoHelper"/> class.
        /// </summary>
        /// <param name="iterations">The iterations.</param>
        /// <param name="saltSize">Number of bytes of the salt (change won't brake existed passwords).</param>
        /// <param name="hashedPwdSize">Number of bytes of the password.</param>
        public CryptoHelper(int iterations = 10000, int saltSize = 32, int hashedPwdSize = 32)
        {
            this.iterations = iterations;
            this.saltSize = saltSize < 8 ? 8 : saltSize;
            this.hashedPwdSize = hashedPwdSize < 8 ? 8 : hashedPwdSize;
        }

        /// <summary>
        /// Verifies the password.
        /// </summary>
        /// <param name="proposedPwd">The proposed password.</param>
        /// <param name="storedPwd">The stored password.</param>
        /// <param name="storedSalt">The stored salt.</param>
        /// <returns></returns>
        public bool VerifyPassword(string proposedPwd, string storedPwd, string storedSalt)
        {
            return storedPwd == CreatePasswordHash(proposedPwd, storedSalt);
        }

        /// <summary>
        /// Creates the salt with cryptographic pseudo-random number generator.
        /// </summary>
        /// <returns></returns>
        public string CreateSalt()
        {
            var salt = new byte[saltSize];
            new RNGCryptoServiceProvider().GetBytes(salt);
            return Convert.ToBase64String(salt);
        }

        /// <summary>
        /// Creates the password hash with slow derivation function.
        /// </summary>
        /// <param name="password">The password as plain text.</param>
        /// <param name="salt">The salt as base64 string.</param>
        /// <returns></returns>
        public string CreatePasswordHash(string password, string salt)
        {
            var saltBytes = Convert.FromBase64String(salt);
            var hashBytes = new Rfc2898DeriveBytes(password, saltBytes, iterations).GetBytes(hashedPwdSize);
            return Convert.ToBase64String(hashBytes);
        }

        #region Static

        /// <summary>
        /// Encrypt string.
        /// </summary>
        /// <param name="str">The string.</param>
        /// <param name="key">The salt.</param>
        /// <returns></returns>
        public static string Encrypt(string str, string key)
        {
            var strArray = Encoding.UTF8.GetBytes(str);

            var md5 = new MD5CryptoServiceProvider();
            var keyArray = md5.ComputeHash(Encoding.UTF8.GetBytes(key));
            md5.Clear();

            var tdes = new TripleDESCryptoServiceProvider
            {
                Key = keyArray,
                Mode = CipherMode.ECB,
                Padding = PaddingMode.PKCS7
            };

            var cTransform = tdes.CreateEncryptor();
            var resultArray = cTransform.TransformFinalBlock(strArray, 0, strArray.Length);
            tdes.Clear();

            return Convert.ToBase64String(resultArray, 0, resultArray.Length);
        }

        /// <summary>
        /// Decrypt the specified cipher string.
        /// </summary>
        /// <param name="cipherString">The cipher string.</param>
        /// <param name="key">The key.</param>
        /// <returns></returns>
        public static string Decrypt(string cipherString, string key)
        {
            byte[] strArray;
            try
            {
                strArray = Convert.FromBase64String(cipherString);
            }
            catch
            {
                return cipherString;
            }

            var md5 = new MD5CryptoServiceProvider();
            var keyArray = md5.ComputeHash(Encoding.UTF8.GetBytes(key));
            md5.Clear();

            var tdes = new TripleDESCryptoServiceProvider
            {
                Key = keyArray,
                Mode = CipherMode.ECB,
                Padding = PaddingMode.PKCS7
            };

            var cTransform = tdes.CreateDecryptor();
            var resultArray = cTransform.TransformFinalBlock(strArray, 0, strArray.Length);
            tdes.Clear();

            return Encoding.UTF8.GetString(resultArray);
        }


        /// <summary>
        /// Generates the password.
        /// </summary>
        /// <param name="lowercase">The lowercase.</param>
        /// <param name="uppercase">The uppercase.</param>
        /// <param name="numerics">The numerics.</param>
        /// <returns></returns>
        public static string GeneratePassword(int lowercase, int uppercase, int numerics)
        {
            var lowers = "abcdefghijklmnopqrstuvwxyz";
            var uppers = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
            var number = "0123456789";

            var random = new Random();

            var generated = "_";
            for (var i = 1; i <= lowercase; i++)
                generated = generated.Insert(
                    random.Next(generated.Length),
                    lowers[random.Next(lowers.Length - 1)].ToString()
                );

            for (var i = 1; i <= uppercase; i++)
                generated = generated.Insert(
                    random.Next(generated.Length),
                    uppers[random.Next(uppers.Length - 1)].ToString()
                );

            for (var i = 1; i <= numerics; i++)
                generated = generated.Insert(
                    random.Next(generated.Length),
                    number[random.Next(number.Length - 1)].ToString()
                );

            return generated.Replace("_", string.Empty);

        }

        #endregion
    }
}