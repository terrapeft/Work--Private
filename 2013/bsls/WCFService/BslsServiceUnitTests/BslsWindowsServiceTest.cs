using WindowsService;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;

namespace BslsServiceUnitTests
{
    
    
    /// <summary>
    ///This is a test class for BslsWindowsServiceTest and is intended
    ///to contain all BslsWindowsServiceTest Unit Tests
    ///</summary>
    [TestClass()]
    public class BslsWindowsServiceTest
    {


        private TestContext testContextInstance;

        /// <summary>
        ///Gets or sets the test context which provides
        ///information about and functionality for the current test run.
        ///</summary>
        public TestContext TestContext
        {
            get
            {
                return testContextInstance;
            }
            set
            {
                testContextInstance = value;
            }
        }

        #region Additional test attributes
        // 
        //You can use the following additional attributes as you write your tests:
        //
        //Use ClassInitialize to run code before running the first test in the class
        //[ClassInitialize()]
        //public static void MyClassInitialize(TestContext testContext)
        //{
        //}
        //
        //Use ClassCleanup to run code after all tests in a class have run
        //[ClassCleanup()]
        //public static void MyClassCleanup()
        //{
        //}
        //
        //Use TestInitialize to run code before running each test
        //[TestInitialize()]
        //public void MyTestInitialize()
        //{
        //}
        //
        //Use TestCleanup to run code after each test has run
        //[TestCleanup()]
        //public void MyTestCleanup()
        //{
        //}
        //
        #endregion


        /// <summary>
        ///A test for GetStartTime
        ///</summary>
        [TestMethod()]
        [DeploymentItem("ThirdDimension.WindowsService.BarcodeSeries.exe")]
        public void GetStartTimeTest()
        {
            //BslsWindowsService_Accessor target = new BslsWindowsService_Accessor(); // TODO: Initialize to an appropriate value
            //DateTime expected = new DateTime(); // TODO: Initialize to an appropriate value
            //var actual = target.GetStartTime("02:30");
            //var actual11 = target.GetStartTime("13:57");
            //var actual1 = target.GetStartTime("13:56");
            //var actual2 = target.GetStartTime("13:00");
            ////Assert.AreEqual(expected, actual);
            //Assert.Inconclusive("Verify the correctness of this test method.");
        }
    }
}
