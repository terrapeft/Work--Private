#region Copyright (C) 1994-2010, Johnson & Johnson PRD, LLC.
//---------------------------------------------------------------------------*
//
//    SeriesAccessor.cs: Provides common operations with Label Series and Reservations.
//
//---
//
//    Copyright (C) 1994-2009, Johnson & Johnson PRD, LLC.
//    All Rights Reserved.
//
//    Vitaly Chupaev, 04/2010
//
//---------------------------------------------------------------------------*/
#endregion

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections;
using Jnj.ThirdDimension.Data.BarcodeSeries;
using Jnj.ThirdDimension.Base;
using Jnj.ThirdDimension.Data;
using Jnj.ThirdDimension.Utils.BarcodeSeries;
using System.Data;

namespace Jnj.ThirdDimension.BusinessLayer.BarcodeSeries
{
   public interface ISeriesAccessor
   {
      /// <summary>
      /// Connects to databases.
      /// </summary>
      /// <returns></returns>
      DataLayerConnection Connect();

      /// <summary>
      /// Disconnects from database.
      /// </summary>
      void Disconnect();

      string ConnectionInfo { get; set; }

      /// <summary>
      /// Determines whether the specified barcode is within reserved values of supplied reservations.
      /// </summary>
      /// <param name="barcode">The barcode.</param>
      /// <param name="reservations">The reservations collection.</param>
      bool IsBarcodeReserved(decimal barcode, ICollection<decimal> reservationIds, out decimal reservationId);

      /// <summary>
      /// Loads range reservations from database.
      /// </summary>
      /// <param name="labelSerieID"></param>
      /// <returns></returns>
      BSDataSet.ReservationDataTable GetReservation(decimal labelSeriesID);

      /// <summary>
      /// Returns a dictionary with a set of minimum and maximum values of supplied reservations.
      /// </summary>
      /// <param name="barcode">The barcode.</param>
      /// <param name="reservations">The reservations collection.</param>
      List<KeyValuePair<decimal, decimal>> GetReservationBounds(ICollection<decimal> reservationIds);


      /// <summary>
      /// Returns list of all series names registered in the system.
      /// </summary>
      /// <returns></returns>
      BSDataSet.SeriesDataTable GetSeriesNames();
   }

   /// <summary>
   /// Provides common operations with Label Series and Reservations.
   /// </summary>
   public class SeriesAccessor : ISeriesAccessor
   {

      #region Private declarations

      private static string lastSeriesFilter = string.Empty;
      private static string lastReservFilter = string.Empty;
      private static BSDataSet.SeriesDataTable seriesCache;
      private static BSDataSet.ReservationDataTable reservationsCache;
      private BSDataSet.SeriesRow seriesRow;

      #endregion


      #region Properties

      private SeriesDataLayer DataLayer { get; set; }

      #endregion

      
      #region Constructors

      /// <summary>
      /// Initializes a new instance of the <see cref="SeriesAccessor"/> class.
      /// </summary>
      /// <param name="dl">The SeriesDataLayer.</param>
      public SeriesAccessor(SeriesDataLayer dl)
      {
         ConnectionInfo = dl.SecurityContext.ConnectionString;
         DataLayer = dl;
      }

      /// <summary>
      /// Initializes a new instance of the <see cref="SeriesAccessor"/> class.
      /// </summary>
      /// <param name="dl">The SeriesDataLayer.</param>
      public SeriesAccessor(SeriesDataLayer dl, string seriesName) : this (dl)
      {
         if (!seriesName.IsEmpty())
         {
            string name = DataLayer.DataSet.Series.NAMEColumn.ColumnName;
            BSDataSet.SeriesDataTable rdt = DataLayer.SeriesDB.GetSeries(string.Format("{0} = '{1}'", name, seriesName));
            if (rdt.Rows.Count == 1)
            {
               seriesRow = (BSDataSet.SeriesRow)rdt.Rows[0];
            }
         }
      }

      #endregion


      /// <summary>
      /// Returns list of all series names registered in the system.
      /// </summary>
      /// <returns></returns>
      public BSDataSet.SeriesDataTable GetSeriesNames()
      {
         var seriesDT = DataLayer.SeriesDB.GetSeries();
         SeriesAccessor.AddTemplateColumn(seriesDT);
         return seriesDT;
      }

      /// <summary>
      /// Determines whether the specified barcode is within reserved values of supplied reservations.
      /// </summary>
      /// <param name="barcode">The barcode.</param>
      /// <param name="reservations">The reservations collection.</param>
      public bool IsBarcodeReserved(decimal barcode, ICollection<decimal> reservationIds, out decimal reservationId)
      {
         reservationId = 0;
         if (reservationIds.Count == 0) return false;

         string idColName = DataLayer.DataSet.Reservation.IDColumn.ColumnName;
         string minColName = DataLayer.DataSet.Reservation.MIN_VALUEColumn.ColumnName;
         string maxColName = DataLayer.DataSet.Reservation.MAX_VALUEColumn.ColumnName;
         string statusColName = DataLayer.DataSet.Reservation.RESERVATION_STATUS_IDColumn.ColumnName;

         string filter = Sql.MakeInList((ICollection) reservationIds, idColName);
         filter = string.Format("{0} and ({1} >= {2} and {1} <= {3})", filter, barcode, minColName, maxColName);
         filter = string.Format("{0} and {1} = {2}", filter, statusColName, (int) ReservationStatus.Active);

         using (DataLayer.Connect())
         {
            var reservations = ReservationsCache(filter);

            foreach (BSDataSet.SeriesRow row in GetSeriesForReservations(reservations).Rows)
            {
               foreach (BSDataSet.ReservationRow resRow in reservations.Rows)
               {
                  SeriesGenerator generator = new SeriesGenerator(DataLayer, seriesRow);
                  if (generator.LoadRange(false).GetValues(resRow).Contains(barcode.ToString()))
                  {
                     reservationId = resRow.ID;
                     return true;
                  }
               }
            }
         }
         return false;
      }


      /// <summary>
      /// Loads range reservations from database.
      /// </summary>
      /// <param name="labelSerieID"></param>
      /// <returns></returns>
      public BSDataSet.ReservationDataTable GetReservation(decimal labelSerieID)
      {
         using (DataLayer.Connect())
         {
            string name = "LABEL";
            string filter = string.Format("{0} = {1}", DataLayer.DataSet.Reservation.SERIES_IDColumn.ColumnName, labelSerieID);
            BSDataSet.ReservationDataTable dt = DataLayer.SeriesDB.GetRangeReservation(filter, true);
            dt.Columns.Add(name);

            foreach (BSDataSet.ReservationRow row in dt.Rows)
            {
               row[name] = string.Format("From {0} to {1}", row.MIN_VALUE, row.MAX_VALUE);
            }
            return dt;
         }
      }

      /// <summary>
      /// Returns a dictionary with a set of minimum and maximum values of supplied reservations.
      /// </summary>
      /// <param name="barcode">The barcode.</param>
      /// <param name="reservations">The reservations collection.</param>
      public List<KeyValuePair<decimal, decimal>> GetReservationBounds(ICollection<decimal> reservationIds)
      {
         List<KeyValuePair<decimal, decimal>> dict = new List<KeyValuePair<decimal, decimal>>();

         if (reservationIds.Count == 0) return dict;

         using (DataLayer.Connect())
         {
            string idColName = DataLayer.DataSet.Reservation.IDColumn.ColumnName;
            string statusColName = DataLayer.DataSet.Reservation.RESERVATION_STATUS_IDColumn.ColumnName;

            string filter = Sql.MakeInList((ICollection)reservationIds, idColName);
            filter = string.Format("{0} and {1} = {2}", filter, statusColName, (int)ReservationStatus.Active);

            var reservations = ReservationsCache(filter);

            foreach (BSDataSet.ReservationRow resRow in reservations.Rows)
            {
               dict.Add(new KeyValuePair<decimal, decimal>(resRow.MIN_VALUE, resRow.MAX_VALUE));
            }
         }
         return dict;
      }


      #region Stuff

      /// <summary>
      /// Returns label series for intersecting ranges.
      /// </summary>
      /// <param name="dt"></param>
      /// <returns></returns>
      private BSDataSet.SeriesDataTable GetSeriesForReservations(BSDataSet.ReservationDataTable dt)
      {
         if (dt.Rows.Count == 0) return new BSDataSet.SeriesDataTable();

         List<decimal> ls = new List<decimal>();

         foreach (BSDataSet.ReservationRow row in dt.Rows)
         {
            ls.Add(row.SERIES_ID);
         }

         string lsFilter = Sql.MakeInList(ls, DataLayer.DataSet.Series.IDColumn.ColumnName);
         return SeriesCache(lsFilter);
      }

      private BSDataSet.ReservationDataTable ReservationsCache(string filter)
      {
         if (string.IsNullOrEmpty(lastReservFilter) || filter != lastReservFilter)
         {
            lastReservFilter = filter;
            reservationsCache = DataLayer.SeriesDB.GetRangeReservation(filter);
         }
         return reservationsCache;
      }

      private BSDataSet.SeriesDataTable SeriesCache(string filter)
      {
         if (string.IsNullOrEmpty(lastSeriesFilter) || filter != lastSeriesFilter)
         {
            lastSeriesFilter = filter;
            seriesCache = DataLayer.SeriesDB.GetSeries(filter);
         }
         return seriesCache;
      }

      #endregion

      #region Static methods

      /// <summary>
      /// Adds the column __TEMPLATE with series template e.g. 'ABCD-yyyy-mm-#'.
      /// </summary>
      /// <param name="series">The series.</param>
      public static void AddTemplateColumn(BSDataSet.SeriesDataTable series)
      {
         DataColumn col = series.Columns.Add("__TEMPLATE", typeof(string));

         foreach (BSDataSet.SeriesRow row in series.Rows)
         {
            SeriesTemplate s = SeriesDefinition.Deserialize<SeriesTemplate>(row.RANGE_DEFINITION);
            row[col] = s.GetTemplate();
         }
      }

      #endregion

      #region ISeriesAccessor Members

      public string ConnectionInfo
      {
         get;
         set;
      }
      public DataLayerConnection Connect()
      {
         if (DataLayer != null)
         {
            return DataLayer.Connect();
         }
         return null;
      }

      public void Disconnect()
      {
         if (DataLayer != null)
         {
            DataLayer.Disconnect();
         }
      }

      #endregion
   }
}
