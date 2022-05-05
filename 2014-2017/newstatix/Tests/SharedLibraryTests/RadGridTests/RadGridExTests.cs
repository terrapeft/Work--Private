using System;
using System.Data.Objects;
using System.Linq;
using System.Web;
using System.Web.DynamicData;
using System.Web.Routing;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using SharedLibraryTests.RadGridTests;
using Subtext.TestLibrary;
using Telerik.Web.UI.DynamicData;

namespace SharedLibraryTests
{
    [TestClass]
    public class RadGridExTests
    {
        private static EntityDataSource eds;
        private static TestEntities dataContext;
        private static MetaTable table;
        private static MetaModel defaultModel;
        private static HttpContext httpContext;

        [ClassInitialize]
        public static void ClassSetup(TestContext a)
        {
            new HttpSimulator().SimulateRequest(new Uri("http://localhost/Cars/List.aspx"));
            httpContext = HttpContext.Current;

            // create a new DbConnection using Effort
            var conn = Effort.EntityConnectionFactory.CreateTransient("name=TestEntities");

            // create the DbContext class using the connection
            dataContext = new TestEntities(conn);
            dataContext.Cars.AddObject(new Car { Id = 1, Manufacturer = "Skoda", ModelName = "Octavia", Manufactured = new DateTime(2010, 07, 15), VIN = "FDGD123DFE445345FDGB" });
            dataContext.Cars.AddObject(new Car { Id = 2, Manufacturer = "Peugeout", ModelName = "207", Manufactured = new DateTime(2008, 08, 10), VIN = "TFG4553DFSRF66767FGA" });
            dataContext.SaveChanges();

            // use the same DbConnection object to create the context object the test will use.
            eds = new EntityDataSource(conn);

            // make entties MetaData available
            RegisterRoutes(dataContext, RouteTable.Routes);
        }

        [TestMethod]
        public void Columns_Visibility_In_List_Mode()
        {
            var grid = CreateGridFor("List", typeof(Car));
            var colsNumber = grid.Columns.Count;

            // 5 columns in the entity.
            // Primary key and those that marked as ScaffoldColumn(false) are removed by the system.
            // Fields marked as HideIn are present in the grid but set to be invisible.

            Assert.AreEqual(3, colsNumber, "Some hidden columns seems to be visible.");

            Assert.IsTrue(grid.Table.Columns.Any(c => c.DisplayName == "Id"), "Expected column is missed.");
            Assert.IsTrue(grid.Table.Columns.Any(c => c.DisplayName == "ModelName"), "Expected column is missed.");
            Assert.IsTrue(grid.Table.Columns.Any(c => c.DisplayName == "Manufacturer"), "Expected column is missed.");
            Assert.IsTrue(grid.Table.Columns.Any(c => c.DisplayName == "VIN"), "Expected column is missed.");
            Assert.IsTrue(grid.Table.Columns.Any(c => c.DisplayName == "Manufactured"), "Expected column is missed.");

            Assert.IsFalse(grid.Columns.FindByDataField("VIN").Visible, "VIN is hidden for List action.");
            Assert.IsTrue(grid.Columns.FindByDataField("Manufacturer").Visible, "Manufacturer is visible in List mode.");
            Assert.IsTrue(grid.Columns.FindByDataField("Manufactured").Visible, "Manufactured should be visible.");
        }

        [TestMethod]
        public void Columns_Visibility_In_Edit_Mode()
        {
            var grid = CreateGridFor("Edit", typeof(Car));
            var colsNumber = grid.Columns.Count;

            // 5 columns in the entity.
            // Primary key and those that marked as ScaffoldColumn(false) are removed by the system.
            // Fields marked as HideIn are present in the grid but set to be invisible.

            Assert.AreEqual(3, colsNumber, "Some hidden columns seems to be visible.");

            Assert.IsTrue(grid.Table.Columns.Any(c => c.DisplayName == "Id"), "Expected column is missed.");
            Assert.IsTrue(grid.Table.Columns.Any(c => c.DisplayName == "ModelName"), "Expected column is missed.");
            Assert.IsTrue(grid.Table.Columns.Any(c => c.DisplayName == "Manufacturer"), "Expected column is missed.");
            Assert.IsTrue(grid.Table.Columns.Any(c => c.DisplayName == "VIN"), "Expected column is missed.");
            Assert.IsTrue(grid.Table.Columns.Any(c => c.DisplayName == "Manufactured"), "Expected column is missed.");

            Assert.IsTrue(grid.Columns.FindByDataField("VIN").Visible, "VIN is visible in Edit mode.");
            Assert.IsFalse(grid.Columns.FindByDataField("Manufacturer").Visible,
                "Manufacturer is hidden for Edit action.");
            Assert.IsTrue(grid.Columns.FindByDataField("Manufactured").Visible, "Manufactured should be visible.");
        }

        private RadGridEx CreateGridFor(string action, Type entityType)
        {
            if (HttpContext.Current == null)
            {
                HttpContext.Current = httpContext;
            }

            table = defaultModel.GetTable(entityType);

            var route = new RouteData();
            route.Values.Add("action", action);

            HttpContext.Current.Request.RequestContext =
                new RequestContext(new HttpContextWrapper(HttpContext.Current), route);
            HttpContext.Current.Handler = new Page();

            var grid = new RadGridEx
            {
                AutoGenerateColumns = true,
                UseAsDynamic = true,
                DataSourceID = eds.ID,
            };

            grid.MasterTableView.DataKeyNames = new[] { "Id" };
            grid.SetMetaTable(table);
            grid.Initialize(eds);

            return grid;
        }

        private static void RegisterRoutes(ObjectContext ctx, RouteCollection routes)
        {
            defaultModel = new MetaModel();
            routes.Clear();

            defaultModel.RegisterContext(() => ctx, new ContextConfiguration { ScaffoldAllTables = true });

            routes.Add(new DynamicDataRoute("{table}/{action}.aspx")
            {
                Constraints = new RouteValueDictionary(new { action = "List|Details|Popup" }),
                Model = defaultModel
            });
        }
    }
}
