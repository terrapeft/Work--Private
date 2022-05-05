using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using Jnj.ThirdDimension.Data;
using Jnj.ThirdDimension.Base;
using Jnj.ThirdDimension.Mt.Util;
using System.Globalization;
using System.Collections;
using Jnj.ThirdDimension.Data.BarcodeSeries;
using Jnj.ThirdDimension.Utils.BarcodeSeries;
using Jnj.ThirdDimension.BusinessLayer.BarcodeSeries.Properties;

namespace Jnj.ThirdDimension.BusinessLayer.BarcodeSeries.Creators
{
   public class BaseSeriesCreator : ISeriesCreator
   {
      #region Private declarations

      protected SeriesDefinition seriesInfo;
      protected BSDataSet.SeriesRow seriesRow;
      protected DbConnection provider;
      protected SeriesDataLayer dataLayer;

      #endregion


      #region Constructor

      protected BaseSeriesCreator(BSDataSet.SeriesRow row, SeriesDefinition series, SeriesDataLayer dl)
      {
         seriesRow = row;
         seriesInfo = series;
         dataLayer = dl;
      }

      #endregion

      #region Virtual methods

      /// <summary>
      /// Generates new values and makes reservation for those values.
      /// </summary>
      /// <param name="numberOfValues"></param>
      /// <param name="rawValues"></param>
      /// <returns></returns>
      public virtual List<string> GetValues(int numberOfValues)
      {
         throw new Exception("This method have to be implemented in descendant class.");
      }

      #endregion

   }

   /// <summary>
   /// Represents error of barcode generation. 
   /// </summary>
   public class InvalidSeriesFormatException : Exception
   {
      public InvalidSeriesFormatException(string message)
         : base(message)
      {
      }
   }

}
