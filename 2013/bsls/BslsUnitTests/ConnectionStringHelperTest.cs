using Jnj.ThirdDimension.Data;
using Jnj.ThirdDimension.Utils.BarcodeSeries;
using NUnit.Framework;

namespace BslsUnitTests
{
    
    
    /// <summary>
    ///This is a test class for ConnectionStringHelperTest and is intended
    ///to contain all ConnectionStringHelperTest Unit Tests
    ///</summary>
   [TestFixture]
   public class ConnectionStringHelperTest
   {

      /// <summary>
      ///A test for GetUser
      ///</summary>
      [Test]
      public void GetDevartUserTest()
      {
         string connectionString = "User Id=USERXXX;Password=JSw0PksxJCBc;Server=rndusraabcdd2.rndus.na.jnj.com;Direct=True;Sid=ABCDDev;Persist Security Info=False;Port=1521";
         string expected = "USERXXX";
         string actual = ConnectionStringHelper.GetUser(connectionString);

         Assert.AreEqual(expected, actual);
      }

      /// <summary>
      ///A test for GetUser
      ///</summary>
      [Test]
      public void GetODPUserTest()
      {
         string connectionString = "Data Source=(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=rndusraabcdd1.rndus.na.jnj.com)(PORT=1521))(ADDRESS=(PROTOCOL=TCP)(HOST=rndusraabcdd2.rndus.na.jnj.com)(PORT=1521)))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=ABCDDev)(FAILOVER_MODE=(TYPE=SELECT)(METHOD=BASIC)(RETRIES=180)(DELAY=5))));User Id=USERXXX;Password=JSw0PksxJCBc;Pooling=true";
         string expected = "USERXXX";
         string actual = ConnectionStringHelper.GetUser(connectionString);

         Assert.AreEqual(expected, actual);
      }

      /// <summary>
      ///A test for GetUser
      ///</summary>
      [Test]
      public void GetODPDsnTest2()
      {
         string connectionString = "Data Source=(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=rndusraabcdd1.rndus.na.jnj.com)(PORT=1521))(ADDRESS=(PROTOCOL=TCP)(HOST=rndusraabcdd2.rndus.na.jnj.com)(PORT=1521)))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=ABCDDev)(FAILOVER_MODE=(TYPE=SELECT)(METHOD=BASIC)(RETRIES=180)(DELAY=5))));User Id=USERXXX;Password=JSw0PksxJCBc;Pooling=true";
         string expected = "(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=rndusraabcdd1.rndus.na.jnj.com)(PORT=1521))(ADDRESS=(PROTOCOL=TCP)(HOST=rndusraabcdd2.rndus.na.jnj.com)(PORT=1521)))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=ABCDDev)(FAILOVER_MODE=(TYPE=SELECT)(METHOD=BASIC)(RETRIES=180)(DELAY=5))))";
         string actual = ConnectionStringHelper.GetDsn(connectionString);

         Assert.AreEqual(expected, actual, "Assert 1");

         connectionString = "(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=rndusraabcdd1.rndus.na.jnj.com)(PORT=1521))(ADDRESS=(PROTOCOL=TCP)(HOST=rndusraabcdd2.rndus.na.jnj.com)(PORT=1521)))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=ABCDDev)(FAILOVER_MODE=(TYPE=SELECT)(METHOD=BASIC)(RETRIES=180)(DELAY=5))))";
         expected = "(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=rndusraabcdd1.rndus.na.jnj.com)(PORT=1521))(ADDRESS=(PROTOCOL=TCP)(HOST=rndusraabcdd2.rndus.na.jnj.com)(PORT=1521)))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=ABCDDev)(FAILOVER_MODE=(TYPE=SELECT)(METHOD=BASIC)(RETRIES=180)(DELAY=5))))";
         actual = ConnectionStringHelper.GetDsn(connectionString);

         Assert.AreEqual(expected, actual, "Assert 2");
      }

      /// <summary>
      ///A test for GetPassword
      ///</summary>
      [Test]
      public void GetDevartPasswordTest()
      {
         string connectionString = "User Id=USERXXX;Password=JSw0PksxJCBc;Server=rndusraabcdd2.rndus.na.jnj.com;Direct=True;Sid=ABCDDev;Persist Security Info=False;Port=1521";
         bool decrypt = true;
         string expected = "TEST PWD";
         string actual = ConnectionStringHelper.GetPassword(connectionString, decrypt);
         
         Assert.AreEqual(expected, actual);
      }

      /// <summary>
      ///A test for GetPassword
      ///</summary>
      [Test]
      public void GetODPPasswordTest()
      {
         string connectionString = "Data Source=(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=rndusraabcdd1.rndus.na.jnj.com)(PORT=1521))(ADDRESS=(PROTOCOL=TCP)(HOST=rndusraabcdd2.rndus.na.jnj.com)(PORT=1521)))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=ABCDDev)(FAILOVER_MODE=(TYPE=SELECT)(METHOD=BASIC)(RETRIES=180)(DELAY=5))));User Id=USERXXX;Password=JSw0PksxJCBc;Pooling=true";
         bool decrypt = true;
         string expected = "TEST PWD";
         string actual = ConnectionStringHelper.GetPassword(connectionString, decrypt);
         
         Assert.AreEqual(expected, actual);
      }


      /// <summary>
      ///A test for GetOdpConnectionString
      ///</summary>
      [Test()]
      public void GetOdpConnectionStringTest()
      {
         string info = "<DEVART_CONNECTION_STRING>User Id=USERXXX;Password=PWDXXX;Server=rndusraabcdd2.rndus.na.jnj.com;Direct=True;Sid=ABCDDev;Persist Security Info=False;Port=1521</DEVART_CONNECTION_STRING><ODP_CONNECTION_STRING>Data Source=(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=rndusraabcdd1.rndus.na.jnj.com)(PORT=1521))(ADDRESS=(PROTOCOL=TCP)(HOST=rndusraabcdd2.rndus.na.jnj.com)(PORT=1521)))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=ABCDDev)(FAILOVER_MODE=(TYPE=SELECT)(METHOD=BASIC)(RETRIES=180)(DELAY=5))));User Id=USERXXX;Password=PWDXXX;Pooling=true</ODP_CONNECTION_STRING>";
         string expected = "Data Source=(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=rndusraabcdd1.rndus.na.jnj.com)(PORT=1521))(ADDRESS=(PROTOCOL=TCP)(HOST=rndusraabcdd2.rndus.na.jnj.com)(PORT=1521)))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=ABCDDev)(FAILOVER_MODE=(TYPE=SELECT)(METHOD=BASIC)(RETRIES=180)(DELAY=5))));User Id=USERXXX;Password=PWDXXX;Pooling=true";
         string actual = ConnectionStringHelper.GetOdpConnectionString(info);
         
         Assert.AreEqual(expected, actual);
      }

      /// <summary>
      ///A test for GetKey
      ///</summary>
      [Test()]
      public void GetKeyTest()
      {
         string start = "string.Empty;";
         string end = "an appropriate value";
         string source = "string.Empty; // TODO: Initialize to an appropriate value";
         string expected = " // TODO: Initialize to ";
         string actual = ConnectionStringHelper.GetKey(start, end, source);

         Assert.AreEqual(expected, actual);
      }

      /// <summary>
      ///A test for DecryptedConnectionString
      ///</summary>
      [Test()]
      public void DecryptedConnectionStringTest()
      {
         string connectionString = "Data Source=(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=rndusraabcdd1.rndus.na.jnj.com)(PORT=1521))(ADDRESS=(PROTOCOL=TCP)(HOST=rndusraabcdd2.rndus.na.jnj.com)(PORT=1521)))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=ABCDDev)(FAILOVER_MODE=(TYPE=SELECT)(METHOD=BASIC)(RETRIES=180)(DELAY=5))));User Id=USERXXX;Password=ISQkIj4oOC9/;Pooling=true";
         string pwdBefore = ConnectionStringHelper.GetPassword(connectionString, true);
         string actual = ConnectionStringHelper.DecryptedConnectionString(connectionString);
         string pwdAfter = ConnectionStringHelper.GetPassword(actual, false);

         Assert.AreEqual(pwdBefore, pwdAfter);
      }

      /// <summary>
      /// 
      /// </summary>
      [Test()]
      public void EncryptConnectionStringTest()
      {
         string connectionString = "Data Source=(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=rndusraabcdd1.rndus.na.jnj.com)(PORT=1521))(ADDRESS=(PROTOCOL=TCP)(HOST=rndusraabcdd2.rndus.na.jnj.com)(PORT=1521)))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=ABCDDev)(FAILOVER_MODE=(TYPE=SELECT)(METHOD=BASIC)(RETRIES=180)(DELAY=5))));User Id=USERXXX;Password=password;Pooling=true";
         string encConnString = ConnectionStringHelper.EncryptConnectionString(connectionString);
         string pwdAfter = ConnectionStringHelper.GetPassword(encConnString, true);

         Assert.AreNotEqual(connectionString, encConnString, "Assert 1");
         Assert.AreEqual("password", pwdAfter, "Assert 2");
      }

      /// <summary>
      ///A test for ChangeUser
      ///</summary>
      [Test()]
      public void ChangeUserTest()
      {
         string connectionString = "Data Source=(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=rndusraabcdd1.rndus.na.jnj.com)(PORT=1521))(ADDRESS=(PROTOCOL=TCP)(HOST=rndusraabcdd2.rndus.na.jnj.com)(PORT=1521)))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=ABCDDev)(FAILOVER_MODE=(TYPE=SELECT)(METHOD=BASIC)(RETRIES=180)(DELAY=5))));User Id=USERXXX;Password=PASSWORD;Pooling=true";
         string newValue = "My user";
         string expected = "Data Source=(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=rndusraabcdd1.rndus.na.jnj.com)(PORT=1521))(ADDRESS=(PROTOCOL=TCP)(HOST=rndusraabcdd2.rndus.na.jnj.com)(PORT=1521)))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=ABCDDev)(FAILOVER_MODE=(TYPE=SELECT)(METHOD=BASIC)(RETRIES=180)(DELAY=5))));User Id=My user;Password=PASSWORD;Pooling=true";
         string actual = ConnectionStringHelper.ChangeUser(connectionString, newValue);
         
         Assert.AreEqual(expected, actual);
      }

      /// <summary>
      ///A test for ChangePassword
      ///</summary>
      [Test()]
      public void ChangePasswordTest()
      {
         string connectionString = "Data Source=(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=rndusraabcdd1.rndus.na.jnj.com)(PORT=1521))(ADDRESS=(PROTOCOL=TCP)(HOST=rndusraabcdd2.rndus.na.jnj.com)(PORT=1521)))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=ABCDDev)(FAILOVER_MODE=(TYPE=SELECT)(METHOD=BASIC)(RETRIES=180)(DELAY=5))));User Id=USERXXX;Password=PASSWORD;Pooling=true";
         string newValue = "new pwd";
         string expected = "Data Source=(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=rndusraabcdd1.rndus.na.jnj.com)(PORT=1521))(ADDRESS=(PROTOCOL=TCP)(HOST=rndusraabcdd2.rndus.na.jnj.com)(PORT=1521)))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=ABCDDev)(FAILOVER_MODE=(TYPE=SELECT)(METHOD=BASIC)(RETRIES=180)(DELAY=5))));User Id=USERXXX;Password=new pwd;Pooling=true";
         string actual = ConnectionStringHelper.ChangePassword(connectionString, newValue);

         Assert.AreEqual(expected, actual);
      }

      [Test]
      public void ParseConnectionStringTest1()
      {
         var connectionString = "Data Source=(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=rndusraabcdd1.rndus.na.jnj.com)(PORT=1521))(ADDRESS=(PROTOCOL=TCP)(HOST=rndusraabcdd2.rndus.na.jnj.com)(PORT=1521)))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=ABCDDev)(FAILOVER_MODE=(TYPE=SELECT)(METHOD=BASIC)(RETRIES=180)(DELAY=5))));User Id=USERXXX;Password=ISQmPCYqJTV7;Pooling=true;Connection Timeout=120;";
         var dsn = "(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=rndusraabcdd1.rndus.na.jnj.com)(PORT=1521))(ADDRESS=(PROTOCOL=TCP)(HOST=rndusraabcdd2.rndus.na.jnj.com)(PORT=1521)))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=ABCDDev)(FAILOVER_MODE=(TYPE=SELECT)(METHOD=BASIC)(RETRIES=180)(DELAY=5))))";
         var user = "USERXXX";
         var password = "PASSWORD";

         var info = ConnectionStringHelper.ParseConnectionString(connectionString, DataProviderType.ODP);

         Assert.AreEqual(dsn, info.Dsn);
         Assert.AreEqual(user, info.UserName);
         Assert.AreEqual(password, info.Password);
         Assert.IsTrue(info.HasCustomConnectionString);
         Assert.IsTrue(info.CustomConnectionString.EndsWith("Timeout=120;"));
      }

      [Test]
      public void ParseConnectionStringTest2()
      {
         var connectionString = "Data Source=(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=rndusrahpbl06.rndus.na.jnj.com)(PORT=1521)))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=coatsp1.prdus.jnj.com)));User Id=USERXXX;Password=OjwlPCs/bw==;Pooling=true";
         var dsn = "(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=rndusrahpbl06.rndus.na.jnj.com)(PORT=1521)))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=coatsp1.prdus.jnj.com)))";
         var user = "USERXXX";
         var password = "PWDXXX"; // decrypted

         var info = ConnectionStringHelper.ParseConnectionString(connectionString, DataProviderType.ODP);

         Assert.AreEqual(dsn, info.Dsn);
         Assert.AreEqual(user, info.UserName);
         Assert.AreEqual(password, info.Password);
      }
   }
}
