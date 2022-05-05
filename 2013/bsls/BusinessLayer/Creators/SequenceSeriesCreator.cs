using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Jnj.ThirdDimension.Data.BarcodeSeries;
using Jnj.ThirdDimension.BusinessLayer.BarcodeSeries.Properties;
using Jnj.ThirdDimension.Data;
using Jnj.ThirdDimension.Utils.BarcodeSeries;
using System.Data;
using Jnj.ThirdDimension.Base;

namespace Jnj.ThirdDimension.BusinessLayer.BarcodeSeries.Creators
{
   class SequenceSeriesCreator : BaseSeriesCreator
   {

      KeyValuePair<decimal, BSDataSet.ReservationDataTable> reservations = new KeyValuePair<decimal,BSDataSet.ReservationDataTable>();

      public SequenceSeriesCreator(BSDataSet.SeriesRow row, SeriesDefinition series, SeriesDataLayer dl)
         : base(row, series, dl)
      {

      }

      public override List<string> GetValues(int numberOfValues)
      {
         if (!seriesInfo.HasSequence)
         {
            throw new InvalidSeriesFormatException(Resources.InvalidSeriesFormat);
         }

         using (dataLayer.Connect())
         using (provider = InstantDbAccess.Connect(seriesInfo.SequenceConnectionString, seriesInfo.SequenceProviderType))
         {
            try
            {
               string barcodeFormat = seriesInfo.GetSequenceFormatString();
               List<decimal> values = SuggestValues(numberOfValues);

               FindAndResolveConflicts(barcodeFormat, ref values);

               return FormatBarcodes(barcodeFormat, values);
            }
            catch (Exception ex)
            {
               throw ex;
            }
         }

      }


      #region Generate values

      /// <summary>
      /// Finds and resolves conflicts.
      /// </summary>
      /// <param name="usedBarcodes">The used barcodes.</param>
      /// <param name="barcodeFormat">The barcode format.</param>
      /// <param name="values">The values.</param>
      /// <param name="conflicts">The conflicts.</param>
      /// <param name="lastGeneratedValue">The last generated value.</param>
      /// <returns></returns>
      private void FindAndResolveConflicts(string barcodeFormat, ref List<decimal> values)
      {
         bool recheck = false;

         // check if barcodes exist with generated values
         CheckAgainstExistedBarcodesAndResolveConflicts(barcodeFormat, ref values, out recheck);

         // check if reserved ranges contain generated values
         CheckAgainstReservationsAndResolveConflicts(barcodeFormat, ref values, out recheck);

         // it may need several iterations
         while (recheck)
         {
            CheckAgainstExistedBarcodesAndResolveConflicts(barcodeFormat, ref values, out recheck);
            CheckAgainstReservationsAndResolveConflicts(barcodeFormat, ref values, out recheck);
         }
      }

      /// <summary>
      /// Checks generated values against the existed barcodes.
      /// </summary>
      /// <param name="usedBarcodes">The used barcodes.</param>
      /// <param name="barcodeFormat">The barcode format.</param>
      /// <param name="values">The values.</param>
      /// <returns></returns>
      private void CheckAgainstExistedBarcodesAndResolveConflicts(string barcodeFormat, ref List<decimal> values, out bool recheck)
      {
         if (values == null || values.Count == 0 || !seriesInfo.HasTestQuery)
         {
            recheck = false;
            return;
         }

         List<decimal> verifiedBarcodes = new List<decimal>();
         List<decimal> newBarcodes = new List<decimal>();
         newBarcodes.AddRange(values);

         string barcodeField = SqlHelper.GetField(seriesInfo.DBQuery);
         recheck = true;

         while (values.Count > verifiedBarcodes.Count)
         {
            int howMany = VerifyBarcodes(barcodeField, verifiedBarcodes, newBarcodes);

            // generate values
            if (howMany > 0)
            {
               List<decimal> vals = SuggestValues(howMany);
               newBarcodes.AddRange(vals);
            }
         }

         values = verifiedBarcodes;
      }

      private int VerifyBarcodes(string barcodeField, List<decimal> verifiedBarcodes, List<decimal> newBarcodes)
      {
         // find existed barcodes within generated values
         string filter = Sql.MakeInList(newBarcodes, barcodeField, 500);
         DataTable dt = InstantDbAccess.GetDataTable<DataTable>(SqlHelper.Join(seriesInfo.DBQuery, filter), provider);

         int k = 0;
         // remove them
         foreach (DataRow row in dt.Rows)
         {
            newBarcodes.Remove((decimal)row[0]);
            k++;
         }

         verifiedBarcodes.AddRange(newBarcodes);
         newBarcodes.Clear();
         return k;
      }


      /// <summary>
      /// Checks generated values against the reserved ranges.
      /// </summary>
      /// <param name="barcodeFormat">The barcode format.</param>
      /// <param name="initialValue">The initial value.</param>
      /// <param name="numberOfValues">The number of values.</param>
      /// <param name="values">The values.</param>
      /// <param name="conflicts">The conflicts.</param>
      private void CheckAgainstReservationsAndResolveConflicts(string barcodeFormat, ref List<decimal> values, out bool recheck)
      {
         BSDataSet.ReservationDataTable intersectingReservationsDT = GetIntersectingReservations(values);
         List<decimal> conflicts = new List<decimal>();

         // check each barcode incremental value against intersecting ranges
         foreach (BSDataSet.ReservationRow rRow in intersectingReservationsDT.Rows)
         {
            FindIntersections(values, rRow.MIN_VALUE, rRow.MAX_VALUE, conflicts);
         }

         recheck = false;

         // find another values
         if (conflicts.Count > 0)
         {
            ResolveConflicts(ref values, conflicts, intersectingReservationsDT);
            UpdateSequenceValue((int)values.Max());
            recheck = true;
         }
      }

      /// <summary>
      /// Returns reserved ranges intersecting with generated values.
      /// </summary>
      /// <param name="initialValue"></param>
      /// <param name="numberOfValues"></param>
      /// <returns></returns>
      private BSDataSet.ReservationDataTable GetIntersectingReservations_old(List<decimal> values)
      {
         StringBuilder filter = new StringBuilder();

         // series filter
         filter.AppendFormat("{0} = {1}", dataLayer.DataSet.Reservation.SERIES_IDColumn, seriesInfo.ID);

         // date filter
         string date = string.Format("TO_DATE('{0}-{1}-{2}', 'DD-MM-YYYY')", DateTime.UtcNow.Day, DateTime.UtcNow.Month, DateTime.UtcNow.Year);
         filter.AppendFormat(" AND ({0} >= {1} AND {0} <= {2})", date, dataLayer.DataSet.Reservation.MIN_DATE_TIMEColumn, dataLayer.DataSet.Reservation.MAX_DATE_TIMEColumn);

         if (values.Count > 0)
         {
            filter.Append(" AND ");
         }

         filter.Append("(");
         foreach (decimal value in values)
         {
            filter.AppendFormat("({0} BETWEEN {1} AND {2}) OR ", value, dataLayer.DataSet.Reservation.MIN_VALUEColumn,
                              dataLayer.DataSet.Reservation.MAX_VALUEColumn);
         }
         filter = filter.Remove(filter.Length - 3, 3);
         filter.Append(")");

         return dataLayer.SeriesDB.GetRangeReservation(filter.ToString());
      }

      /// <summary>
      /// Returns reserved ranges intersecting with generated values.
      /// </summary>
      /// <param name="initialValue"></param>
      /// <param name="numberOfValues"></param>
      /// <returns></returns>
      private BSDataSet.ReservationDataTable GetIntersectingReservations(List<decimal> values)
      {
         StringBuilder filter = new StringBuilder();

         // series filter
         filter.AppendFormat("{0} = {1} AND {2} = {3}", 
            dataLayer.DataSet.Reservation.SERIES_IDColumn, 
            seriesInfo.ID, 
            dataLayer.DataSet.Reservation.RESERVATION_STATUS_IDColumn, 
            (int)ReservationStatus.Active);

         if (reservations.Key != seriesInfo.ID)
         {
            reservations = new KeyValuePair<decimal, BSDataSet.ReservationDataTable>(
               seriesInfo.ID,
               dataLayer.SeriesDB.GetRangeReservation(filter.ToString()));
         }
         var intersecReservations = new BSDataSet.ReservationDataTable();

         foreach (var val in values) 
         {
            var addedReservations = intersecReservations.Select(r => r.ID).ToList();

            var filteredReservations = reservations.Value
               // skip already added reservations
               .Where(r => !addedReservations.Contains(r.ID))
               // date not specified or Today is within the range
               .Where(r => (r.MIN_DATE_TIME == DateTime.MinValue && r.MAX_DATE_TIME == DateTime.MinValue)
                        || (DateTime.Today.Date >= r.MIN_DATE_TIME.Date && DateTime.Today.Date <= r.MAX_DATE_TIME.Date))
               // Value is out of ALL reserved ranges
               .Where(r => val >= r.MIN_VALUE && val <= r.MAX_VALUE);

            filteredReservations.Foreach(r => intersecReservations.ImportRow(r));
         }

         return intersecReservations;
      }

      /// <summary>
      /// Gets the free ranges in intersections.
      /// </summary>
      /// <returns></returns>
      private void ResolveConflicts(ref List<decimal> values, List<decimal> conflicts, BSDataSet.ReservationDataTable intersectingReservationsDT)
      {
         DataView view = intersectingReservationsDT.DefaultView;
         view.Sort = dataLayer.DataSet.Reservation.MIN_VALUEColumn.ColumnName;

         // utilize free ranges between reserved ranges
         for (int r = 1; r < view.Count; r++)
         {
            BSDataSet.ReservationRow currentRow = view[r].Row as BSDataSet.ReservationRow;
            BSDataSet.ReservationRow prevRow = view[r - 1].Row as BSDataSet.ReservationRow;

            decimal delta = currentRow.MIN_VALUE - prevRow.MAX_VALUE;

            if (delta > 1)
            {
               while (delta-- > 1 && conflicts.Count > 0)
               {
                  int i = values.IndexOf(conflicts[0]);
                  decimal val = ++prevRow.MAX_VALUE;

                  if (!values.Contains(val))
                  {
                     values[i] = val;
                     conflicts.RemoveAt(0);
                  }
               }
            }
         }

         // use values greater then all reserved values in found reservations
         if (conflicts.Count > 0)
         {
            view.Sort = dataLayer.DataSet.Reservation.MAX_VALUEColumn.ColumnName;
            BSDataSet.ReservationRow lastRow = view[view.Count - 1].Row as BSDataSet.ReservationRow;
            while (conflicts.Count > 0)
            {
               int i = values.IndexOf(conflicts[0]);
               decimal val = ++lastRow.MAX_VALUE;

               if (!values.Contains(val))
               {
                  values[i] = val;
                  conflicts.RemoveAt(0);
               }
            }
         }
      }

      /// <summary>
      /// Checks for intersections.
      /// </summary>
      /// <param name="valueStart">The value start.</param>
      /// <param name="valueEnd">The value end.</param>
      /// <param name="rangeStart">The range start.</param>
      /// <param name="rangeEnd">The range end.</param>
      /// <returns></returns>
      private List<decimal> FindIntersections(List<decimal> values, decimal rangeStart, decimal rangeEnd, List<decimal> intersections)
      {
         for (int k = 0; k < values.Count; k++)
         {
            decimal value = values[k];
            if (value >= rangeStart && value <= rangeEnd)
            {
               if (!intersections.Contains(value))
               {
                  intersections.Add(value);
               }
            }
         }
         return intersections;
      }

      /// <summary>
      /// Suggests a set of values for new barcodes.
      /// </summary>
      /// <param name="incField"></param>
      /// <returns></returns>
      private List<decimal> SuggestValues(int howMany)
      {
         return new List<decimal>(InstantDbAccess.GetSequenceValues(howMany, seriesInfo.DBSequence, (DbOdpConnection)provider));
      }

      /// <summary>
      /// Sets the sequence to return next time the value right after the current greatest one.
      /// </summary>
      /// <param name="greatestGeneratedValue">The greatest generated value.</param>
      private void UpdateSequenceValue(int greatestGeneratedValue)
      {
         var lastVal = InstantDbAccess.GetSequenceLastNumber(seriesInfo.SequenceSchema, seriesInfo.SequenceName, (DbOdpConnection)provider);
         if (greatestGeneratedValue >= lastVal)
         {
            var get = greatestGeneratedValue - (int)lastVal + 1;
            InstantDbAccess.GetSequenceValues(get, seriesInfo.DBSequence, (DbOdpConnection)provider);
         }
      }

      /// <summary>
      /// Formats the barcodes.
      /// </summary>
      /// <param name="barcodeFormat">The barcode format.</param>
      /// <param name="values">The values.</param>
      /// <returns></returns>
      protected List<string> FormatBarcodes(string barcodeFormat, List<decimal> values)
      {
         List<string> barcodes = new List<string>();

         values.Sort();
         foreach (decimal value in values)
         {
            barcodes.Add(string.Format(barcodeFormat, value));
         }

         return barcodes;
      }

      #endregion


      #region Insert reservations

      /// <summary>
      /// Inserts the reservations.
      /// </summary>
      /// <param name="barcodes">The barcodes.</param>
      /// <param name="seriesRow">The label series row.</param>
      private void InsertReservations(List<decimal> barcodes, BSDataSet.SeriesRow seriesRow)
      {
         BSDataSet.ReservationDataTable resDT = new BSDataSet.ReservationDataTable();

         decimal startInterval = barcodes[0];
         decimal endInterval = startInterval;

         if (barcodes.Count == 1)
         {
            resDT.Rows.Add(CreateReservationRow(startInterval, endInterval, resDT, seriesRow));
         }
         else
         {
            for (int k = 1; k < barcodes.Count; k++)
            {
               if (endInterval + 1 != barcodes[k])
               {
                  resDT.Rows.Add(CreateReservationRow(startInterval, endInterval, resDT, seriesRow));
                  startInterval = barcodes[k];
                  endInterval = startInterval;
               }
               else if (barcodes.Count == k + 1)
               {
                  resDT.Rows.Add(CreateReservationRow(startInterval, barcodes[k], resDT, seriesRow));
               }

               endInterval = barcodes[k];
            }
         }

         // commit reservations
         dataLayer.SeriesDB.Commit(resDT);

         // create reservations events
         BSDataSet.SeriesEventDataTable resEvents = GetSeriesEventDataTableForReservation(resDT);

         // commit reservation events
         dataLayer.SeriesDB.Commit(resEvents);
      }

      /// <summary>
      /// Creates the label series reservation events.
      /// </summary>
      /// <param name="sd">The sd.</param>
      /// <returns></returns>
      private BSDataSet.SeriesEventDataTable GetSeriesEventDataTableForReservation(BSDataSet.ReservationDataTable rdt)
      {
         BSDataSet.SeriesEventDataTable dt = new BSDataSet.SeriesEventDataTable();
         BSDataSet.SeriesEventRow row;

         foreach (BSDataSet.ReservationRow resRow in rdt.Rows)
         {
            if (resRow.RowState == DataRowState.Modified || resRow.RowState == DataRowState.Added)
            {
               row = dt.NewSeriesEventRow();

               row.EVENT_DATE = DateTime.UtcNow;
               row.EVENT_TYPE_ID = (decimal)SeriesEventType.Reserved;
               row.ID = -1;
               row.SERIES_ID = resRow.SERIES_ID;
               row.PERSON_ID = dataLayer.SecurityContext.User.PersonID;

               if (resRow.RowState == DataRowState.Modified)
               {
                  row.EVENT_TYPE_ID = (decimal)SeriesEventType.Updated;
                  row.INFORMATION = string.Format("<ID>{0}</ID><Min>{1}</Min><Max>{2}</Max>",
                                                  resRow.ID, resRow[rdt.MIN_VALUEColumn, DataRowVersion.Original], resRow[rdt.MAX_VALUEColumn, DataRowVersion.Original]);
               }

               dt.Rows.Add(row);
            }
         }
         return dt;
      }

      /// <summary>
      /// Creates the range reservation row.
      /// </summary>
      /// <param name="min">The min.</param>
      /// <param name="max">The max.</param>
      /// <param name="resDT">The res DT.</param>
      /// <param name="SeriesRow">The label series row.</param>
      /// <returns></returns>
      private BSDataSet.ReservationRow CreateReservationRow(decimal min, decimal max, BSDataSet.ReservationDataTable resDT, BSDataSet.SeriesRow SeriesRow)
      {
         BSDataSet.ReservationRow newRes = resDT.NewReservationRow();
         newRes.MIN_VALUE = min;
         newRes.MAX_VALUE = max;
         newRes.MIN_DATE_TIME = DateTime.MinValue;
         newRes.MAX_DATE_TIME = DateTime.MinValue;
         newRes.LAST_DATE = DateTime.UtcNow;
         newRes.LAST_PERSON_ID = dataLayer.SecurityContext.User.PersonID;
         newRes.OWNER_ID = SeriesRow.OWNER_ID;
         newRes.SERIES_ID = SeriesRow.ID;
         newRes.RESERVATION_STATUS_ID = (decimal)ReservationStatus.Active;
         newRes.ID = -1;
         newRes.DESCRIPTION = "Reservation of generated values.";

         return newRes;
      }

      #endregion

   }
}
