#region Copyright (C) 1994-2009, Johnson & Johnson PRD, LLC.
//---------------------------------------------------------------------------*
//
//    SeriesDataLayer.cs: Encapsulates all Series operations in the database. 
//
//---
//
//    Copyright (C) 1994-2009, Johnson & Johnson PRD, LLC.
//    All Rights Reserved.
//
//    Vitaly Chupaev, 11/2009
//
//---------------------------------------------------------------------------*/
#endregion

using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using Jnj.ThirdDimension.Util.UsageLog;
using Oracle.DataAccess.Types;
using Oracle.DataAccess.Client;
using System.Linq;

namespace Jnj.ThirdDimension.Data.BarcodeSeries
{
   public partial class SeriesDataLayer
   {

      /// <summary>
      /// Helper class to encapsulate all Instrument operation in the database. 
      /// </summary>
      public class Instrument
      {

         #region Private members

         private SeriesDataLayer dl;
         private const string InstrumentSql = "InstrumentSql";

         #endregion


         #region Constructors

         private Instrument()
         {
            // Prevents anyone from creating a Instrument instance without the data layer.
         }

         public Instrument(SeriesDataLayer dl)
            : this()
         {
            this.dl = dl;
         }

         #endregion


         #region DB access methods

         /// <summary>
         /// Returns records for Instrument containers that match the given filter.
         /// </summary>
         /// <param name="filter">The filtering criteria to use for the query.</param>
         /// <returns>A table with records found.</returns>
         public BSDataSet.InstrumentDataTable GetInstrument(string filter)
         {
            return dl.Get<BSDataSet.InstrumentDataTable>(dl[InstrumentSql], filter);
         }

         /// <summary>
         /// Returns records for Instrument containers.
         /// </summary>
         /// <returns>A table with records found.</returns>
         public BSDataSet.InstrumentDataTable GetInstrument()
         {
            return dl.Get<BSDataSet.InstrumentDataTable>(dl[InstrumentSql]);
         }

         /// <summary>
         /// Returns records for Instrument containers.
         /// </summary>
         /// <returns>A table with records found.</returns>
         public BSDataSet.InstrumentTypeDataTable GetInstrumentTypes()
         {
            return dl.Get<BSDataSet.InstrumentTypeDataTable>(dl["InstrumentTypesSql"]);
         }


         /// <summary>
         /// Inserts label serie in a database.
         /// </summary>
         /// <param name="pdt"></param>
         public void InsertInstruments(BSDataSet.InstrumentDataTable lsdt)
         {
            //define columns for label serie insert
            string[] columns = {
                                  dsCache.Instrument.NAMEColumn.ColumnName,
                                  dsCache.Instrument.URLColumn.ColumnName,
                                  dsCache.Instrument.INSTRUMENT_TYPE_IDColumn.ColumnName,
                                  dsCache.Instrument.INSTRUMENT_ROLE_IDColumn.ColumnName,
                                  dsCache.Instrument.HOSTNAMEColumn.ColumnName,
                                  dsCache.Instrument.PORTColumn.ColumnName,
                                  dsCache.Instrument.ORG_SITE_IDColumn.ColumnName
                               };

            //define column type for label serie insert
            OracleDbType[] types = {
                                      OracleDbType.Varchar2,
                                      OracleDbType.Varchar2,
                                      OracleDbType.Decimal,
                                      OracleDbType.Decimal,
                                      OracleDbType.Varchar2,
                                      OracleDbType.Decimal,
                                      OracleDbType.Decimal
                                   };

            dl.provider.ExecuteNonQuery(dl["insertInstrumentSql"], columns, types, lsdt);
         }

         /// <summary>
         /// Updates the name of the instruments by.
         /// </summary>
         /// <param name="lsdt">The LSDT.</param>
         public void UpdateInstrumentsByName(BSDataSet.InstrumentDataTable lsdt)
         {

            //define columns for label series update
            string[] columns = {
                                  dsCache.Instrument.URLColumn.ColumnName,
                                  dsCache.Instrument.INSTRUMENT_TYPE_IDColumn.ColumnName,
                                  dsCache.Instrument.INSTRUMENT_ROLE_IDColumn.ColumnName,
                                  dsCache.Instrument.HOSTNAMEColumn.ColumnName,
                                  dsCache.Instrument.PORTColumn.ColumnName,
                                  dsCache.Instrument.ORG_SITE_IDColumn.ColumnName,
                                  dsCache.Instrument.NAMEColumn.ColumnName
                               };

            //define column type for label serie insert
            OracleDbType[] types = {
                                      OracleDbType.Varchar2,
                                      OracleDbType.Decimal,
                                      OracleDbType.Decimal,
                                      OracleDbType.Varchar2,
                                      OracleDbType.Decimal,
                                      OracleDbType.Decimal,
                                      OracleDbType.Varchar2
                                   };


            dl.provider.ExecuteNonQuery(dl["updateInstrumentByNameSql"], columns, types, lsdt);
         }

         /// <summary>
         /// Updates the name of the instruments by.
         /// </summary>
         /// <param name="lsdt">The LSDT.</param>
         public void UpdateInstrumentsByUrl(BSDataSet.InstrumentDataTable lsdt)
         {

            //define columns for label series update
            string[] columns = {
                                  dsCache.Instrument.NAMEColumn.ColumnName,
                                  dsCache.Instrument.INSTRUMENT_TYPE_IDColumn.ColumnName,
                                  dsCache.Instrument.INSTRUMENT_ROLE_IDColumn.ColumnName,
                                  dsCache.Instrument.HOSTNAMEColumn.ColumnName,
                                  dsCache.Instrument.PORTColumn.ColumnName,
                                  dsCache.Instrument.ORG_SITE_IDColumn.ColumnName,
                                  dsCache.Instrument.URLColumn.ColumnName
                               };

            //define column type for label serie insert
            OracleDbType[] types = {
                                      OracleDbType.Varchar2,
                                      OracleDbType.Decimal,
                                      OracleDbType.Decimal,
                                      OracleDbType.Varchar2,
                                      OracleDbType.Decimal,
                                      OracleDbType.Decimal,
                                      OracleDbType.Varchar2
                                   };


            dl.provider.ExecuteNonQuery(dl["updateInstrumentByUrlSql"], columns, types, lsdt);
         }

         /// <summary>
         /// Inserts label serie in a database.
         /// </summary>
         /// <param name="pdt"></param>
         public void InsertInstrumentTypes(BSDataSet.InstrumentTypeDataTable lsdt)
         {
            //define columns for label serie insert
            string[] columns = {
                                  dsCache.InstrumentType.CODEColumn.ColumnName,
                                  dsCache.InstrumentType.NAMEColumn.ColumnName,
                                  dsCache.InstrumentType.DESCRIPTIONColumn.ColumnName
                               };

            //define column type for label serie insert
            OracleDbType[] types = {
                                      OracleDbType.Varchar2,
                                      OracleDbType.Varchar2,
                                      OracleDbType.Varchar2
                                   };

            dl.provider.ExecuteNonQuery(dl["insertInstrumentTypeSql"], columns, types, lsdt);
         }

         /// <summary>
         /// Updates the name of the instruments by.
         /// </summary>
         /// <param name="lsdt">The LSDT.</param>
         public void UpdateInstrumentTypes(BSDataSet.InstrumentTypeDataTable lsdt)
         {

            //define columns for label series update
            string[] columns = {
                                  dsCache.InstrumentType.NAMEColumn.ColumnName,
                                  dsCache.InstrumentType.DESCRIPTIONColumn.ColumnName,
                                  dsCache.InstrumentType.CODEColumn.ColumnName
                               };

            //define column type for label serie insert
            OracleDbType[] types = {
                                      OracleDbType.Varchar2,
                                      OracleDbType.Varchar2,
                                      OracleDbType.Varchar2
                                   };


            dl.provider.ExecuteNonQuery(dl["updateInstrumentTypeSql"], columns, types, lsdt);
         }
         #endregion

      }
      /// <summary>
      /// This are the different instrument roles that must match the values in the database.
      /// </summary>
      public enum InstrumentRole
      {
         Unknown = 0,
         Scale = 1,
         BarcodeReader = 2,
         BarcodePrinter = 3,
         StorageUnit = 4,
         LiquidHandler = 5
      }
   }
}
