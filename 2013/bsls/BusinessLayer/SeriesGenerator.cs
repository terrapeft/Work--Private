#region Copyright (C) 1994-2009, Johnson & Johnson PRD, LLC.
//---------------------------------------------------------------------------*
//
//    SeriesGenerator.cs: Contains reusable methods for Label Series.
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
using Jnj.ThirdDimension.Data;
using Jnj.ThirdDimension.Base;
using Jnj.ThirdDimension.Mt.Util;
using System.Globalization;
using System.Collections;
using Jnj.ThirdDimension.Data.BarcodeSeries;
using Jnj.ThirdDimension.Utils.BarcodeSeries;
using Jnj.ThirdDimension.BusinessLayer.BarcodeSeries.Properties;
using Jnj.ThirdDimension.BusinessLayer.BarcodeSeries.Creators;

namespace Jnj.ThirdDimension.BusinessLayer.BarcodeSeries
{

   public interface ISeriesGenerator
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

      /// <summary>
      /// Generates new values and makes reservation for those values.
      /// </summary>
      /// <param name="numberOfValues"></param>
      /// <param name="rawValues"></param>
      /// <returns></returns>
      List<string> GenerateUniqueBarcodes(int numberOfValues);


   }

   /// <summary>
   /// Generates series of barcodes.
   /// </summary>
   public class SeriesGenerator : ISeriesGenerator
   {

      #region Private declarations

      private SeriesDefinition seriesInfo;
      private BSDataSet.SeriesRow seriesRow;

      private static string fromCol = string.Empty;

      #endregion


      #region Properties

      private SeriesDataLayer DataLayer { get; set; }

      #endregion


      #region Constructor

      /// <summary>
      /// For internal use, when authorization has been already done.
      /// </summary>
      public SeriesGenerator(SeriesDataLayer dl, string seriesName)
      {
         DataLayer = dl;

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

      /// <summary>
      /// Initializes a new instance of the <see cref="SeriesGenerator"/> class.
      /// </summary>
      /// <param name="dl">The data layer instance.</param>
      /// <param name="row">The row containing Series information.</param>
      public SeriesGenerator(SeriesDataLayer dl, BSDataSet.SeriesRow row)
      {
         DataLayer = dl;
         seriesRow = row;
      }

      #endregion


      #region Public methods

      /// <summary>
      /// Generates new values and makes reservation for those values.
      /// </summary>
      /// <param name="numberOfValues"></param>
      /// <param name="rawValues"></param>
      /// <returns></returns>
      public List<string> GenerateUniqueBarcodes(int numberOfValues)
      {
         ISeriesCreator creator = null;

         if (seriesRow != null && seriesInfo == null)
         {
            Connect();
            LoadRange();
         }

         if (seriesInfo.HasSequence)
         {
            creator = new SequenceSeriesCreator(seriesRow, seriesInfo, DataLayer);
         }
         else if (seriesInfo.HasYear || seriesInfo.HasMonth || seriesInfo.HasDay)
         {
            creator = new DateSeriesCreator(seriesRow, seriesInfo, DataLayer);
         }

         return creator.GetValues(numberOfValues);
      }

      /// <summary>
      /// Loads Series parameters from a data row to the object.
      /// </summary>
      /// <param name="row">The row.</param>
      /// <returns></returns>
      public SeriesDefinition LoadRange()
      {
         return LoadRange(null, true);
      }

      /// <summary>
      /// Loads Series parameters from a data row to the object.
      /// </summary>
      /// <param name="loadData">Specifies if load connection data from ARMS or not.</param>
      /// <returns></returns>
      public SeriesDefinition LoadRange(bool loadData)
      {
         return LoadRange(null, loadData);
      }

      /// <summary>
      /// Loads the range.
      /// </summary>
      /// <param name="reservations">The reservations.</param>
      /// <returns></returns>
      public SeriesDefinition LoadRange(BSDataSet.ReservationDataTable reservations)
      {
         return LoadRange(reservations, true);
      }

      /// <summary>
      /// Loads Series parameters from a data row to the object.
      /// </summary>
      /// <param name="reservations">The reservations.</param>
      /// <param name="loadData">Specifies if load connection data from ARMS or not.</param>
      /// <returns></returns>
      public SeriesDefinition LoadRange(BSDataSet.ReservationDataTable reservations, bool loadData)
      {
         if (seriesRow == null)
         {
            return new SeriesDefinition();
         }

         seriesInfo = new SeriesDefinition();
         seriesInfo.State = SeriesDefinition.RangeState.Update;
         
         seriesInfo.BeginLoadData();

         seriesInfo.Template = SeriesDefinition.Deserialize<SeriesTemplate>(seriesRow.RANGE_DEFINITION);
         seriesInfo.SetConnection(SeriesDefinition.Deserialize<SeriesConnectionData>(seriesRow.DB_CONNECTION), loadData);

         seriesInfo.Name = seriesRow.NAME;
         seriesInfo.ID = seriesRow.ID;
         seriesInfo.ResetTypeId = seriesRow.RESET_TYPE_ID;
         seriesInfo.Start = seriesRow.RANGE_START_FROM;

         LoadNullableValueFromColumn(seriesRow, RangeStartFromColumnName, seriesInfo.Start);

         seriesInfo.DBQuery = seriesRow.DB_CHECK_QUERY;
         seriesInfo.DBSequence = seriesRow.DB_SEQUENCE;
         seriesInfo.ReservationsDT = reservations;

         seriesInfo.EndLoadData();
         return seriesInfo;
      }

      #endregion


      #region Stuff

      /// <summary>
      /// Used in test to eliminate dependency.
      /// </summary>
      private string RangeStartFromColumnName
      {
         get
         {
            if (fromCol.IsEmpty())
            {
               fromCol = DataLayer.DataSet.Series.RANGE_START_FROMColumn.ColumnName;
            }
            return fromCol;
         }
         set
         {
            fromCol = value;
         }
      }

      /// <summary>
      /// Sets null or existing value.
      /// </summary>
      /// <param name="row"></param>
      /// <param name="column"></param>
      /// <param name="setTo"></param>
      private static void LoadNullableValueFromColumn(BSDataSet.SeriesRow row, string column, decimal? setTo)
      {
         setTo = row.IsNull(column) ? (decimal?)null : (decimal)row[column];
      }

      #endregion


      #region ISeriesGenerator Members

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
