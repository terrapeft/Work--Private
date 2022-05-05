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
      /// Encapsulates all Series operations in the database. 
      /// </summary>
      public class Series
      {
         private const string SeriesSql = "SeriesSql";
         private const string InsertSeriesSql = "InsertSeriesSql";
         private const string DeleteReservationSql = "DeleteReservationSql";
         private const string UpdateSeriesSql = "UpdateSeriesSql";
         private const string SeriesSeq = "SeriesSeq";
         private const string SeriesEventsSeq = "SeriesEventsSeq";
         private const string RangeReservationSql = "RangeReservationSql";
         private const string InsertRangeReservationSql = "InsertRangeReservationSql";
         private const string UpdateRangeReservationSql = "UpdateRangeReservationSql";
         private const string RangeReservationStatusSql = "RangeReservationStatusSql";
         private const string InsertEventsSql = "InsertEventsSql";

         private SeriesDataLayer dl;

         private Series()
         {
            // Prevents anyone from creating a Series instance without the data layer.
         }

         public Series(SeriesDataLayer dl)
            : this()
         {
            this.dl = dl;
         }

         /// <summary>
         /// Returns records for label series that match the given filter.
         /// </summary>
         /// <param name="filter">The filtering criteria to use for the query.</param>
         /// <returns>A table with records found.</returns>
         public BSDataSet.SeriesDataTable GetSeries(string filter)
         {
            if (string.IsNullOrEmpty(filter))
            {
               return GetSeries();
            }

            return dl.Get<BSDataSet.SeriesDataTable>(dl[SeriesSql], filter);
         }


         /// <summary>
         /// Returns records for label series that match the given filter.
         /// </summary>
         /// <param name="filter">The filtering criteria to use for the query.</param>
         /// <returns>A table with records found.</returns>
         public BSDataSet.ReservationDataTable GetRangeReservation(string filter)
         {
            return GetRangeReservation(filter, false);
         }

         /// <summary>
         /// Returns records for label series that match the given filter.
         /// </summary>
         /// <param name="filter">The filtering criteria to use for the query.</param>
         /// <returns>A table with records found.</returns>
         public BSDataSet.ReservationDataTable GetRangeReservation(string filter, bool active)
         {
            string f = filter;
            
            if (active)
            {
               string statusColName = dl.DataSet.Reservation.RESERVATION_STATUS_IDColumn.ColumnName;
               f = string.Format("{0} and {1} = {2}", f, statusColName, (int)ReservationStatus.Active);
            }
            return dl.Get<BSDataSet.ReservationDataTable>(dl[RangeReservationSql], f);
         }

         /// <summary>
         /// Returns records for label series.
         /// </summary>
         /// <param name="filter">The filtering criteria to use for the query.</param>
         /// <returns>A table with records found.</returns>
         public BSDataSet.SeriesDataTable GetSeries()
         {
            return dl.Get<BSDataSet.SeriesDataTable>(dl[SeriesSql]);
         }

         #region dictionary tables
         /// <summary>
         /// Returns the Solvent table.
         /// </summary>
         public BSDataSet.ReservationStatusDataTable RangeReservationStatusDT
         {
            get
            {
               try
               {
                  BSDataSet.ReservationStatusDataTable rsdt = dl.DataSet.ReservationStatus;
                  if (rsdt.Count <= 0)
                  {
                     dl.provider.Fill(dl[RangeReservationStatusSql], rsdt);
                  }

                  return rsdt;
               }
               catch (Exception ex)
               {
                  Reporter.ReportError(ex, false);
                  throw;
               }
            }
         }
         #endregion

         #region Commit methods

         /// <summary>
         /// Saves the changes to the database. The row state is used to indicate if it is an update, delete, or add.
         /// </summary>
         /// <param name="pdt"></param>
         public void Commit(BSDataSet.SeriesDataTable lsdt)
         {
            if (lsdt == null || lsdt.Rows.Count == 0) return;

            // select container sequence value to insert into container
            dl.SetSequenceValues(lsdt, lsdt.IDColumn.Ordinal, dl[SeriesSeq]);

            //get changes from data table
            BSDataSet.SeriesDataTable atbl = (BSDataSet.SeriesDataTable) lsdt.GetChanges(DataRowState.Added);
            BSDataSet.SeriesDataTable mtbl = (BSDataSet.SeriesDataTable) lsdt.GetChanges(DataRowState.Modified);
             
            if (mtbl != null) /// check if any rows has been modified
            {
               UpdateSeries(mtbl);
            }
            if (atbl != null) /// check if any rows has been added
            {
               InsertSeries(atbl);
            }
         }

         /// <summary>
         /// Saves the changes to the database. The row state is used to indicate if it is an update, delete, or add.
         /// </summary>
         /// <param name="rdt">The RDT.</param>
         public void Commit(BSDataSet.ReservationDataTable rdt)
         {
            if (rdt == null || rdt.Rows.Count == 0) return;

            // select container sequence value to insert into container
            dl.SetSequenceValues(rdt, rdt.IDColumn.Ordinal, dl[SeriesSeq]);

            //get changes from data table
            BSDataSet.ReservationDataTable atbl = (BSDataSet.ReservationDataTable)rdt.GetChanges(DataRowState.Added);
            BSDataSet.ReservationDataTable mtbl = (BSDataSet.ReservationDataTable)rdt.GetChanges(DataRowState.Modified);
            BSDataSet.ReservationDataTable dtbl = (BSDataSet.ReservationDataTable)rdt.GetChanges(DataRowState.Deleted);

            if (mtbl != null) // check if any rows has been modified
            {
               UpdateReservation(mtbl);
            }
            if (atbl != null) // check if any rows has been added
            {
               InsertRangeReservation(atbl);
            }
            if (dtbl != null) // check if any rows has been added
            {
               DeleteRangeReservation(dtbl);
            }

         }

         /// <summary>
         /// 
         /// </summary>
         /// <param name="events"></param>
         public void Commit(BSDataSet.SeriesEventDataTable events)
         {
            if (events == null || events.Rows.Count == 0) return;

            // select container sequence value to insert into container
            dl.SetSequenceValues(events, events.IDColumn.Ordinal, dl[SeriesEventsSeq]);

            //get changes from data table
            BSDataSet.SeriesEventDataTable atbl = (BSDataSet.SeriesEventDataTable)events.GetChanges(DataRowState.Added);

            if (atbl != null) // check if any rows has been added
            {
               InsertEvents(atbl);
            }
         }


         #endregion

         #region Private methods
         /// <summary>
         /// Inserts label serie in a database.
         /// </summary>
         /// <param name="pdt"></param>
         private void InsertSeries(BSDataSet.SeriesDataTable lsdt)
         {
            //define columns for label serie insert
            string[] columns = {
                                  dsCache.Series.IDColumn.ColumnName,
                                  dsCache.Series.NAMEColumn.ColumnName,
                                  dsCache.Series.DESCRIPTIONColumn.ColumnName,
                                  dsCache.Series.RESET_TYPE_IDColumn.ColumnName,
                                  dsCache.Series.DB_CONNECTIONColumn.ColumnName,
                                  dsCache.Series.DB_SEQUENCEColumn.ColumnName,
                                  dsCache.Series.RANGE_DEFINITIONColumn.ColumnName,
                                  dsCache.Series.RANGE_START_FROMColumn.ColumnName,
                                  dsCache.Series.DB_CHECK_QUERYColumn.ColumnName,
                                  dsCache.Series.LAST_DATEColumn.ColumnName,
                                  dsCache.Series.LAST_PERSON_IDColumn.ColumnName,
                                  dsCache.Series.OWNER_IDColumn.ColumnName
                               };

            //define column type for label serie insert
            OracleDbType[] types = {
                                      OracleDbType.Decimal,
                                      OracleDbType.Varchar2,
                                      OracleDbType.Varchar2,
                                      OracleDbType.Decimal,
                                      OracleDbType.Varchar2,
                                      OracleDbType.Varchar2,
                                      OracleDbType.Varchar2,
                                      OracleDbType.Decimal,
                                      OracleDbType.Varchar2,
                                      OracleDbType.Date,
                                      OracleDbType.Decimal,
                                      OracleDbType.Decimal
                                   };

            dl.provider.ExecuteNonQuery(dl[InsertSeriesSql], columns, types, lsdt);
         }

         /// <summary>
         /// Deletes
         /// </summary>
         /// <param name="rdt"></param>
         private void DeleteRangeReservation(BSDataSet.ReservationDataTable rdt)
         {
            string[] columns = { rdt.IDColumn.ColumnName };
            OracleDbType[] types = { OracleDbType.Decimal };

            DataTable deletedRowsDataTable = rdt.Copy();
            deletedRowsDataTable.RejectChanges();
            dl.provider.ExecuteNonQuery(dl[DeleteReservationSql], columns, types, deletedRowsDataTable);
         }

         /// <summary>
         /// Inserts reservations into database.
         /// </summary>
         /// <param name="rdt"></param>
         private void InsertRangeReservation(BSDataSet.ReservationDataTable rdt)
         {
            //define columns for range reservation update
            string[] columns = {
                                  dsCache.Reservation.IDColumn.ColumnName,
                                  dsCache.Reservation.OWNER_IDColumn.ColumnName,
                                  dsCache.Reservation.MIN_VALUEColumn.ColumnName,
                                  dsCache.Reservation.MAX_VALUEColumn.ColumnName,
                                  dsCache.Reservation.MIN_DATE_TIMEColumn.ColumnName,
                                  dsCache.Reservation.MAX_DATE_TIMEColumn.ColumnName,
                                  dsCache.Reservation.RESERVATION_STATUS_IDColumn.ColumnName,
                                  dsCache.Reservation.LAST_DATEColumn.ColumnName,
                                  dsCache.Reservation.LAST_PERSON_IDColumn.ColumnName,
                                  dsCache.Reservation.SERIES_IDColumn.ColumnName,
                                  dsCache.Reservation.DESCRIPTIONColumn.ColumnName
                               };

            //define column type for range reservation update
            OracleDbType[] types = {
                                      OracleDbType.Decimal,
                                      OracleDbType.Decimal,
                                      OracleDbType.Decimal,
                                      OracleDbType.Decimal,
                                      OracleDbType.Date,
                                      OracleDbType.Date,
                                      OracleDbType.Decimal,
                                      OracleDbType.Date,
                                      OracleDbType.Decimal,
                                      OracleDbType.Decimal,
                                      OracleDbType.Varchar2
                                   };

            dl.provider.ExecuteNonQuery(dl[InsertRangeReservationSql], columns, types, rdt);
         }

         /// <summary>
         /// Inserts the label series events into database.
         /// </summary>
         /// <param name="eventsDT">The events DT.</param>
         private void InsertEvents(BSDataSet.SeriesEventDataTable eventsDT)
         {
            //define columns for range reservation update
            string[] columns = {
                                  eventsDT.IDColumn.ColumnName,
                                  eventsDT.INFORMATIONColumn.ColumnName,
                                  eventsDT.EVENT_DATEColumn.ColumnName,
                                  eventsDT.PERSON_IDColumn.ColumnName,
                                  eventsDT.SERIES_IDColumn.ColumnName,
                                  eventsDT.EVENT_TYPE_IDColumn.ColumnName
                               };

            //define column type for range reservation update
            OracleDbType[] types = {
                                      OracleDbType.Decimal,
                                      OracleDbType.Varchar2,
                                      OracleDbType.Date,
                                      OracleDbType.Decimal,
                                      OracleDbType.Decimal,
                                      OracleDbType.Decimal
                                   };

            dl.provider.ExecuteNonQuery(dl[InsertEventsSql], columns, types, eventsDT);
         }

         /// <summary>
         /// Updates label series in a database.
         /// </summary>
         /// <param name="pdt"></param>
         private void UpdateSeries(BSDataSet.SeriesDataTable lsdt)
         {

            //define columns for label series update
            string[] columns = {
                                  dsCache.Series.NAMEColumn.ColumnName,
                                  dsCache.Series.DESCRIPTIONColumn.ColumnName,
                                  dsCache.Series.RESET_TYPE_IDColumn.ColumnName,
                                  dsCache.Series.DB_CONNECTIONColumn.ColumnName,
                                  dsCache.Series.DB_SEQUENCEColumn.ColumnName,
                                  dsCache.Series.RANGE_DEFINITIONColumn.ColumnName,
                                  dsCache.Series.RANGE_START_FROMColumn.ColumnName,
                                  dsCache.Series.DB_CHECK_QUERYColumn.ColumnName,
                                  dsCache.Series.LAST_DATEColumn.ColumnName,
                                  dsCache.Series.LAST_PERSON_IDColumn.ColumnName,
                                  dsCache.Series.OWNER_IDColumn.ColumnName,
                                  dsCache.Series.IDColumn.ColumnName
                               };

            //define column type for label series update
            OracleDbType[] types = {
                                      OracleDbType.Varchar2,
                                      OracleDbType.Varchar2,
                                      OracleDbType.Decimal,
                                      OracleDbType.Varchar2,
                                      OracleDbType.Varchar2,
                                      OracleDbType.Varchar2,
                                      OracleDbType.Decimal,
                                      OracleDbType.Varchar2,
                                      OracleDbType.Date,
                                      OracleDbType.Decimal,
                                      OracleDbType.Decimal,
                                      OracleDbType.Decimal
                                   };

            dl.provider.ExecuteNonQuery(dl[UpdateSeriesSql], columns, types, lsdt);
         }

         /// <summary>
         /// Updates range reservation data.
         /// </summary>
         /// <param name="rdt"></param>
         private void UpdateReservation(BSDataSet.ReservationDataTable rdt)
         {
            //define columns for range reservation update
            string[] columns = {
                                  dsCache.Reservation.OWNER_IDColumn.ColumnName,
                                  dsCache.Reservation.MIN_VALUEColumn.ColumnName,
                                  dsCache.Reservation.MAX_VALUEColumn.ColumnName,
                                  dsCache.Reservation.MIN_DATE_TIMEColumn.ColumnName,
                                  dsCache.Reservation.MAX_DATE_TIMEColumn.ColumnName,
                                  dsCache.Reservation.RESERVATION_STATUS_IDColumn.ColumnName,
                                  dsCache.Reservation.LAST_DATEColumn.ColumnName,
                                  dsCache.Reservation.LAST_PERSON_IDColumn.ColumnName,
                                  dsCache.Reservation.SERIES_IDColumn.ColumnName,
                                  dsCache.Reservation.DESCRIPTIONColumn.ColumnName,
                                  dsCache.Reservation.IDColumn.ColumnName
                               };

            //define column type for range reservation update
            OracleDbType[] types = {
                                      OracleDbType.Decimal,
                                      OracleDbType.Decimal,
                                      OracleDbType.Decimal,
                                      OracleDbType.Date,
                                      OracleDbType.Date,
                                      OracleDbType.Decimal,
                                      OracleDbType.Date,
                                      OracleDbType.Decimal,
                                      OracleDbType.Decimal,
                                      OracleDbType.Varchar2,
                                      OracleDbType.Decimal
                                   };

            dl.provider.ExecuteNonQuery(dl[UpdateRangeReservationSql], columns, types, rdt);
         }

         #endregion

      }
   }

   #region Enums

   public enum ReservationStatus
   {
      Active = 0,
      UsedUp= 1
   }

   public enum SeriesResetType
   {
      Never = 0,
      Year = 1,
      Month = 2,
      Day = 3,
      Week = 4
   }

   public enum SeriesEventType
   {
      Unknown = 0,
      Printed = 1,
      Defined = 2,
      Reserved = 3,
      Updated = 4
   }

   public enum PartType
   {
      None,
      Year,
      Month,
      Week,
      Day,
      Sequence,
      Text
   }
   #endregion
}
