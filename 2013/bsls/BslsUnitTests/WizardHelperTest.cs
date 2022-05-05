using Jnj.ThirdDimension.Utils.BarcodeSeries;
using NUnit.Framework;
namespace BslsUnitTests
{
    
    
    /// <summary>
    ///This is a test class for WizardHelperTest and is intended
    ///to contain all WizardHelperTest Unit Tests
    ///</summary>
   [TestFixture]
   public class WizardHelperTest
   {

      /// <summary>
      ///A test for SetTitle
      ///</summary>
      [Test]
      public void SetTitleTest()
      {
         string currentTitle = "Default Title";
         string userName = "Cool User";
         string dbName = "Data Source=(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=rndusraabcdd1.rndus.na.jnj.com)(PORT=1521))(ADDRESS=(PROTOCOL=TCP)(HOST=rndusraabcdd2.rndus.na.jnj.com)(PORT=1521)))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=ABCDDev)(FAILOVER_MODE=(TYPE=SELECT)(METHOD=BASIC)(RETRIES=180)(DELAY=5))));User Id=USERXXX;Password=JSw0PksxJCBc;Pooling=true";
         string expected = "Default Title - Cool User - ABCDDEV";
         string actual = WizardHelper.SetTitle(currentTitle, userName, dbName);
         
         Assert.AreEqual(expected, actual);
      }
   }
}
