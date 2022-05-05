using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using Jnj.ThirdDimension.Base;
using Jnj.ThirdDimension.Arms.Model;
using Jnj.ThirdDimension.Data.BarcodeSeries;

namespace Jnj.ThirdDimension.Service.BarcodeSeries
{
    public class InventorySyncService
    {
        static Timer timer = null;
        static InventorySyncService service = null;
        static string seriesConnectionString;
        static string inventoryConnectionString;

        DateTime startTime = DateTime.Now;
        SeriesDataLayer seriesDataLayer;
        InventoryDataLayer inventoryDataLayer;

        private InventorySyncService() { }

        public static InventorySyncService CreateService(string inventoryConnStr, string seriesConnStr, DateTime startTime)
        {
            seriesConnectionString = seriesConnStr;
            inventoryConnectionString = inventoryConnStr;

            return service ?? (service = new InventorySyncService { startTime = startTime });
        }

        public void Start()
        {
            // set schedule
            timer = new Timer(Start, service, 0, (long)TimeSpan.FromHours(24).TotalMilliseconds);

            Logger.ReportAction("Sync schedule created", "schedule time: " + startTime.ToString("dd-MM-yyyy HH:mm"));
        }

        private static void Start(object state)
        {
            Logger.ReportAction("Scheduled synchronization", "started");
            ((InventorySyncService)state).Synchronize();
        }

        /// <summary>
        /// Sync is based on idea, that the instrument can be identified by NAME and by URL,
        /// if one of these fields was changed, another can be updated by the remaining one, 
        /// if both were changed, then this is a new instrument.
        /// </summary>
        private void Synchronize()
        {
            try
            {
                inventoryDataLayer = new InventoryDataLayer(inventoryConnectionString);
                seriesDataLayer = new SeriesDataLayer(seriesConnectionString);

                using (inventoryDataLayer.Connect())
                using (seriesDataLayer.Connect())
                using (seriesDataLayer.BeginTransaction())
                {
                    // first sync the types
                    SynchronizeInstrumentTypes();

                    Logger.ReportAction("Synchronization", "sync instruments");

                    // then get instruments from inventory
                    var inventoryInstrumentsDt = inventoryDataLayer.GetBarcodePrinters();
                    var inventoryConvertedDt = ConvertInventoryInstrumentsToBsls(inventoryInstrumentsDt);

                    // update those that have unchanged name
                    seriesDataLayer.InstrumentDB.UpdateInstrumentsByName(inventoryConvertedDt);

                    // update those that have unchanged url
                    seriesDataLayer.InstrumentDB.UpdateInstrumentsByUrl(inventoryConvertedDt);

                    // load bsls instruments 
                    var bslsInstrumentsDt = seriesDataLayer.InstrumentDB.GetInstrument();

                    // and find missing
                    var bslsDt = new BSDataSet.InstrumentDataTable();
                    inventoryConvertedDt
                        .Where(r => bslsInstrumentsDt.All(b => b.NAME != r.NAME))
                        .Foreach(r => bslsDt.Rows.Add(r));

                    // insert new instruments
                    if (bslsDt.Rows.Count > 0)
                        seriesDataLayer.InstrumentDB.InsertInstruments(bslsDt);

                    //seriesDataLayer.Commit();
                    seriesDataLayer.Rollback();

                    Logger.ReportAction("Scheduled synchronization", "completed");
                }

                seriesDataLayer = null;
                inventoryDataLayer = null;
            }
            catch (Exception ex)
            {
                Logger.ReportError("Sync error: " + ex.Message + "\n" + ex.StackTrace);
                if (ex.InnerException != null)
                    Logger.ReportError("Sync inner error" + ex.InnerException.Message + "\n" + ex.InnerException.StackTrace);
            }

        }

        private void SynchronizeInstrumentTypes()
        {
            Logger.ReportAction("Synchronization", "sync types");
            var inventoryTypesDt = inventoryDataLayer.GetInstrumentTypesForPrinters();
            var bslsTypesDt = seriesDataLayer.InstrumentDB.GetInstrumentTypes();
            var inventoryConvertedDt = ConvertInventoryTypesToBsls(inventoryTypesDt);

            // update
            seriesDataLayer.InstrumentDB.UpdateInstrumentTypes(inventoryConvertedDt);

            // insert new
            var bslsDt = new BSDataSet.InstrumentDataTable();
            inventoryConvertedDt
                .Where(r => bslsTypesDt.All(b => b.CODE != r.CODE))
                .Foreach(r => bslsDt.Rows.Add(r));

            if (bslsDt.Rows.Count > 0)
                seriesDataLayer.InstrumentDB.InsertInstrumentTypes(inventoryConvertedDt);
        }

        private BSDataSet.InstrumentDataTable ConvertInventoryInstrumentsToBsls(InventoryDataSet.INSTRUMENT_VDataTable inventoryInstruments)
        {
            var bslsDt = new BSDataSet.InstrumentDataTable();
            foreach (var row in inventoryInstruments)
            {
                var bRow = bslsDt.NewInstrumentRow();
                bRow.NAME = row.NAME;
                bRow.URL = row.URL;
                bRow.INSTRUMENT_TYPE_ID = row.INSTRUMENT_TYPE_ID;
                bRow.INSTRUMENT_ROLE_ID = (int)SeriesDataLayer.InstrumentRole.BarcodePrinter;
                bRow.HOSTNAME = row.HOSTNAME;
                bRow.PORT = (decimal)row.PORT;
                bRow.ORG_SITE_ID = row.ORG_SITE_ID;

                bslsDt.Rows.Add(bRow);
            }

            return bslsDt;
        }

        private BSDataSet.InstrumentTypeDataTable ConvertInventoryTypesToBsls(InventoryDataSet.INSTRUMENT_TYPEDataTable inventoryTypes)
        {
            var bslsDt = new BSDataSet.InstrumentTypeDataTable();
            foreach (var row in inventoryTypes)
            {
                var bRow = bslsDt.NewInstrumentTypeRow();
                bRow.NAME = row.NAME;
                bRow.CODE = row.CODE;
                bRow.DESCRIPTION = row.DESCRIPTION;

                bslsDt.Rows.Add(bRow);
            }

            return bslsDt;
        }
    }
}
