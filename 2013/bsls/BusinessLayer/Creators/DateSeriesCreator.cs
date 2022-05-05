using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Jnj.ThirdDimension.BusinessLayer.BarcodeSeries.Properties;
using Jnj.ThirdDimension.Data.BarcodeSeries;

namespace Jnj.ThirdDimension.BusinessLayer.BarcodeSeries.Creators
{
   /// <summary>
   /// Generates date sequences for Series.
   /// </summary>
   class DateSeriesCreator : BaseSeriesCreator
   {

      public DateSeriesCreator(BSDataSet.SeriesRow row, SeriesDefinition series, SeriesDataLayer dl)
         : base(row, series, dl)
      {

      }

      public override List<string> GetValues(int numberOfValues)
      {
         return GetValues(numberOfValues, DateTime.Today);
      }

      public List<string> GetValues(int numberOfValues, DateTime initialValue)
      {
         string barcodeFormat = seriesInfo.GetDateFormatString(initialValue);
         List<DateTime> values = GenerateNewValues(numberOfValues, initialValue);

         return FormatBarcodes(barcodeFormat, values);
      }

      #region Generate values

      /// <summary>
      /// Generates the new values, starting from initial value.
      /// </summary>
      /// <param name="initialValue">The initial value.</param>
      /// <param name="numberOfValues">The number of values.</param>
      /// <returns></returns>
      private List<DateTime> GenerateNewValues(int numberOfValues, DateTime initialValue)
      {
         PartType incField = seriesInfo.IncrementalField;
         DateTime dt = initialValue;

         List<DateTime> values = new List<DateTime>();

         for (int k = 0; k < numberOfValues; k++)
         {
            if (incField == PartType.Day)
            {
               dt = initialValue.AddDays(k);
            }
            else if (incField == PartType.Month)
            {
               dt = initialValue.AddMonths(k);
            }
            else if (incField == PartType.Year)
            {
               dt = initialValue.AddYears(k);
            }

            values.Add(dt);
         }
         return values;
      }

      /// <summary>
      /// Formats the barcodes.
      /// </summary>
      /// <param name="barcodeFormat">The barcode format.</param>
      /// <param name="values">The values.</param>
      /// <returns></returns>
      protected List<string> FormatBarcodes(string barcodeFormat, List<DateTime> values)
      {
         List<string> barcodes = new List<string>();

         values.Sort();
         foreach (DateTime value in values)
         {
            barcodes.Add(value.ToString(barcodeFormat));
         }

         return barcodes;
      }

      #endregion

   }
}
