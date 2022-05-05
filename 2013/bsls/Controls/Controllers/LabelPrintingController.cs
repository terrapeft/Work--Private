#region Copyright (C) 1994-2009, Johnson & Johnson PRD, LLC.
//---------------------------------------------------------------------------*
//
//    LabelPrintingController.cs: Controller for UniversalPrinting control.
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
using System.Linq;
using System.Collections.Generic;
using Jnj.Windows.Forms;
using System.Data;
using Jnj.ThirdDimension.Instruments;
using Jnj.ThirdDimension.Util.UsageLog;
using Wintellect.PowerCollections;
using System.IO;
using Jnj.ThirdDimension.Util;
using Jnj.ThirdDimension.Data;
using Jnj.ThirdDimension.Data.BarcodeSeries;
using Jnj.ThirdDimension.BusinessLayer.BarcodeSeries;
using Jnj.ThirdDimension.Utils.BarcodeSeries;
using Jnj.ThirdDimension.Gt;
using System.Drawing.Imaging;
using System.Text;
using Jnj.ThirdDimension.Mt.Chem;
using System.Drawing;

namespace Jnj.ThirdDimension.Controls.BarcodeSeries
{
   public class LabelPrintingController
   {

      #region Members
      #endregion

      #region Static methods
      /// <summary>
      /// Creates controller
      /// </summary>
      /// <param name="view"></param>
      /// <returns></returns>
      internal static LabelPrintingController CreateController(LabelPrinting view)
      {
         LabelPrintingController c = new LabelPrintingController();
         c.View = view;
         return c;
      }
      #endregion

      #region Accessors
      /// <summary>
      /// View.
      /// </summary>
      public LabelPrinting View { get; set; }
      
      public SeriesDataLayer DataLayer 
      { 
         get
         {
            return View.DataLayer;
         }
      }

      #endregion

      #region Printer methods

      /// <summary>
      /// Loads printers from database.
      /// </summary>
      internal string[] GetPrintersList()
      {
         return GetPrintersList(true);
      }

      /// <summary>
      /// Adds the command row.
      /// </summary>
      /// <param name="printers">The printers.</param>
      /// <param name="name">The name.</param>
      /// <returns></returns>
      internal string [] AddCommandRow(string[] printers, string name)
      {
         return AddCommandRow(printers, name, -1);
      }

      /// <summary>
      /// Adds the command row.
      /// </summary>
      /// <param name="printers">The printers.</param>
      /// <param name="name">The name.</param>
      /// <param name="position">The position.</param>
      /// <returns></returns>
      internal string [] AddCommandRow(string[] printers, string name, int position)
      {
         List<string> list = new List<string>(printers);

         if (position > -1)
         {
            list.Insert(0, name);
         }
         else
         {
            list.Add(name);
         }

         return list.ToArray();
      }

      /// <summary>
      /// Loads printers from database.
      /// </summary>
      internal string[] GetPrintersList(bool forUserSiteOnly)
      {
         PrinterAccessor printerAccessor = new PrinterAccessor(DataLayer);
         string siteName = forUserSiteOnly ? DataLayer.SecurityContext.User.OrgSite : string.Empty;
         return printerAccessor.GetPrintersList(siteName);
      }

      /// <summary>
      /// Initialize access to barcode printer.
      /// </summary>
      internal ICLBarcodePrinter InitializePrinter(PrinterInfo printer)
      {
         ICLBarcodePrinter barcodePrinter = null;
         try
         {
            barcodePrinter =
               (ICLBarcodePrinter)Activator.GetObject(typeof(ICLBarcodePrinter), printer.Url);
            if (barcodePrinter == null)
            {
               throw new ApplicationException(string.Format("Unable to connect to {0}, call support.",
                                                            printer.Name));
            }
            return barcodePrinter;
         }
         catch (Exception ex)
         {
            MessagesHelper.ReportError(ex, true);
            barcodePrinter = null;
         }
         return null;
      }

      /// <summary>
      /// Returns labels with mapped data.
      /// </summary>
      /// <param name="row"></param>
      /// <param name="maps"></param>
      /// <returns></returns>
      internal Pair<string, string>[] GetLabelValues(DataRow row, MapTemplateDialog.MappingsCollection maps)
      {
         var gridCols = GetColumnsForTemplateMapping();
         Pair<string, string> [] pairs = new Pair<string, string>[maps.Count];
         int k = 0;

         foreach (MapTemplateDialog.Mapping map in maps)
         {
            var gridCol = gridCols.Where(i => i.Key == map.SourceName).FirstOrDefault();
            string mappedValue = map.DefaultValue;

            if (string.IsNullOrEmpty(mappedValue))
            {
               if (gridCol.Value == StructureSimpleGridColumn.CellType)
               {
                  if (row[map.SourceName] != DBNull.Value)
                  {
                     var smiles = row[map.SourceName].ToString();
                     if (smiles.Length > 0) mappedValue = GetStructureHexString(smiles);
                  }
               }
               else if (gridCol.Value == PictureSimpleGridColumn.CellType)
               {
                  var pd = row[map.SourceName] as PictureData;
                  if (pd != null) mappedValue = BytesToHexString(pd.Data);
               }
               else
               {
                  mappedValue = string.IsNullOrEmpty(map.SourceName)
                                   ? string.Empty
                                   : row[map.SourceName].ToString();
               }
            }

            Pair<string, string> p = new Pair<string, string>(map.DestinationName, mappedValue);
            pairs[k++] = p;
         }

         return pairs;
      }

      /// <summary>
      /// Converts bytes array to a hex string.
      /// </summary>
      /// <param name="bmpData"></param>
      /// <returns></returns>
      private string BytesToHexString(byte[] bmpData)
      {
         var hexData = new StringBuilder();
         foreach (byte b in bmpData)
         {
            hexData.Append(b.ToString("x2"));
         }
         return hexData.ToString();
      }

      /// <summary>
      /// Removes transparent background (if it's the case) to avoid a black box on printer.
      /// </summary>
      /// <param name="src"></param>
      private Bitmap RemoveTransparency(Bitmap src)
      {
         Bitmap target = new Bitmap(src.Size.Width, src.Size.Height);
         Graphics g = Graphics.FromImage(target);
         g.Clear(Color.White);
         g.DrawImage(src, 0, 0, target.Width, target.Height);
         return target;
      }

      /// <summary>
      /// Uses MoleculeSketcher to obtain a molecule image and converts it to bytes array and the array to a hex string.
      /// </summary>
      /// <param name="smiles"></param>
      /// <returns></returns>
      private string GetStructureHexString(string smiles)
      {
         Jnj.ThirdDimension.Gt.MoleculeSketcher mk = new Jnj.ThirdDimension.Gt.MoleculeSketcher();
         mk.LineWidth = 2;
         mk.Smiles = smiles;

         var bmp = mk.CreateBitmap(292, 182, AutoScalingMode.StretchToWindow);
         byte[] bmpData = null;
         using (MemoryStream ms = new MemoryStream())
         {
            bmp.Save(ms, ImageFormat.Png);
            ms.Seek(0, 0);
            bmpData = ms.ToArray();
         }
         return BytesToHexString(bmpData);
      }

      #endregion

      #region Data methods and properties

      /// <summary>
      /// Saves data from grid to specified file
      /// </summary>
      /// <param name="fileName"></param>
      internal void SaveDataToFile(string fileName)
      {
         DataTable dt = ExportHelper.ExtractVisibleColumnsFromCurrentTable(View.Grid, View.DataSourceTable);
         FileStream fileStream = new FileStream(fileName, FileMode.Create, FileAccess.Write);
         StreamWriter streamWriter = new StreamWriter(fileStream);
         CsvUtility.Save(streamWriter, dt, ',');
         streamWriter.Close();
      }

      /// <summary>
      /// Returns right side columns for mapping.
      /// </summary>
      /// <returns></returns>
      public string[] GetColumnNamesForTemplateMapping()
      {
         List<string> columns = new List<string>();
         foreach (SimpleGridBoundColumn column in View.Grid.Binder.InternalColumns)
         {
            columns.Add(column.HeaderText);
         }

         return columns.ToArray();
      }

      /// <summary>
      /// Returns right side columns for mapping.
      /// </summary>
      /// <returns></returns>
      public List<KeyValuePair<string, string>> GetColumnsForTemplateMapping()
      {
         var columns = new List<KeyValuePair<string, string>>();
         foreach (SimpleGridBoundColumn column in View.Grid.Binder.InternalColumns)
         {
            columns.Add(new KeyValuePair<string, string>(column.HeaderText, column.StyleInfo.CellType));
         }

         return columns;
      }

      /// <summary>
      /// Generates the series values.
      /// </summary>
      /// <param name="row">The row.</param>
      /// <param name="numberOfValues">The number of values.</param>
      /// <param name="rawValues">The raw values.</param>
      /// <returns></returns>
      internal List<string> GenerateSeriesValues(BSDataSet.SeriesRow row, int numberOfValues)
      {
         SeriesGenerator generator = new SeriesGenerator(DataLayer, row);
         generator.LoadRange();
         return generator.GenerateUniqueBarcodes(numberOfValues);
      }

      #endregion
   }
}
