#region Copyright (C) 1994-2009, Johnson & Johnson PRD, LLC.
//---------------------------------------------------------------------------*
//
//    SeriesDefinition.cs: Entity class for Label Series.
//
//---
//
//    Copyright (C) 1994-2008, Johnson & Johnson PRD, LLC.
//    All Rights Reserved.
//
//    Vitaly Chupaev, 11/2008
//
//---------------------------------------------------------------------------*/
#endregion

using System;
using System.Collections.Generic;
using System.Text;
using System.Xml;
using System.Xml.Serialization;
using System.IO;
using System.Data;
using Jnj.ThirdDimension.Utils.BarcodeSeries;
using Jnj.ThirdDimension.Data.BarcodeSeries;
using System.Globalization;
using Jnj.ThirdDimension.Data;
using Jnj.ThirdDimension.Arms.Model;
using Jnj.ThirdDimension.Lims.Interface;
using System.Reflection;

namespace Jnj.ThirdDimension.BusinessLayer.BarcodeSeries
{
   /// <summary>
   /// Entity class for Label Series.
   /// </summary>
   public class SeriesDefinition
   {

      #region Private fields

      private decimal id = -1;
      private string name;
      private decimal? start;
      private decimal resetTypeId;
      private string dbQuery = "";
      private string dbSequence = "";
      private bool initialization = false;

      private const string format = "<{0}>{1}</{0}>";   // Format for xml, with changes
      private const int MAX_LENGTH = 4000;
      private const string CUT_TAG_OPEN = "<CUT>";
      private const string CUT_TAG_CLOSE = "</CUT>";

      #endregion

      #region Constructor
      
      public SeriesDefinition()
      {
      }

      public SeriesDefinition(DataTable reservationSrc)
      {
         GetInitialized();
         ReservationsDT = reservationSrc;
      }

      #endregion

      #region Non-serializable properties & public methods

      public SeriesDefinition GetInitialized()
      {
         conn = new SeriesConnectionData();
         Template = new SeriesTemplate();

         return this;
      }

      /// <summary>
      /// Indicates if current instance was initialized with values.
      /// </summary>
      public bool HasValues
      {
         get { return !string.IsNullOrEmpty(name); }
      }

      /// <summary>
      /// Label Serie ID
      /// </summary>
      public decimal ID
      {
         get { return id; }
         set
         {
            if (!initialization && !changes.ContainsKey("ID") && id != value)
            {
               changes.Add("ID", id.ToString());
            }
            id = value;
         }
      }

      /// <summary>
      /// Name.
      /// </summary>
      public string Name
      {
         get { return name; }
         set
         {
            if (!initialization && !changes.ContainsKey("NAME") && name != value)
            {
               changes.Add("NAME", name);
            }
            name = value;
         }
      }

      /// <summary>
      /// Start sequence from.
      /// </summary>
      public decimal? Start
      {
         get { return start; }
         set
         {
            if (!initialization && !changes.ContainsKey("RANGE_START_FROM") && start != value)
            {
               changes.Add("RANGE_START_FROM", start.ToString());
            }
            start = value;
         }
      }


      /// <summary>
      /// Id for reset type (Year, Month or Day).
      /// </summary>
      public decimal ResetTypeId
      {
         get { return resetTypeId; }
         set
         {
            if (!initialization && !changes.ContainsKey("RESET_TYPE_ID") && resetTypeId != value)
            {
               changes.Add("RESET_TYPE_ID", resetTypeId.ToString());
            }
            resetTypeId = value;
         }
      }

      /// <summary>
      /// Keeps status of the object, which determines a database operation.
      /// </summary>
      public RangeState State
      {
         get;
         set;
      }

      public string DBQuery
      {
         get { return dbQuery; }
         set
         {
            if (!initialization && !changes.ContainsKey("DB_CHECK_QUERY") && dbQuery != value)
            {
               changes.Add("DB_CHECK_QUERY", dbQuery);
            }
            dbQuery = value;
         }
      }


      /// <summary>
      /// Connection string for sequence.
      /// </summary>
      public string SequenceConnectionString
      {
         get; set;
      }

      /// <summary>
      /// Provider type for sequence.
      /// </summary>
      public DataProviderType SequenceProviderType
      {
         get; set;
      }

      /// <summary>
      /// Connection string for table.
      /// </summary>
      public string TableConnectionString
      {
         get; set;
      }

      /// <summary>
      /// Provider type for table.
      /// </summary>
      public DataProviderType TableProviderType
      {
         get; set;
      }

      /// <summary>
      /// Connection string for sequence.
      /// </summary>
      public string TabConnectionDecrypted
      {
         get { return ConnectionStringHelper.DecryptedConnectionString(TableConnectionString); }
      }

      /// <summary>
      /// Sequence name with schema.
      /// </summary>
      public string DBSequence
      {
         get { return dbSequence; }
         set
         {
            if (!initialization && !changes.ContainsKey("DB_SEQUENCE") && dbSequence != value)
            {
               changes.Add("DB_SEQUENCE", dbSequence);
            }
            dbSequence = value;
         }
      }

      /// <summary>
      /// Sequence name.
      /// </summary>
      public string SequenceName
      {
         get { return dbSequence.Split('.')[1]; }
      }

      /// <summary>
      /// Schema name.
      /// </summary>
      public string SequenceSchema
      {
         get { return dbSequence.Split('.')[0]; }
      }

      /// <summary>
      /// Schema name.
      /// </summary>
      public string TableSchema
      {
         get { return SqlHelper.GetSchema(dbQuery); }
      }

      /// <summary>
      /// Schema name.
      /// </summary>
      public string TableName
      {
         get { return SqlHelper.GetTable(dbQuery); }
      }

      /// <summary>
      /// Schema name.
      /// </summary>
      public string TableField
      {
         get { return SqlHelper.GetField(dbQuery); }
      }

      /// <summary>
      /// Schema name.
      /// </summary>
      public string TableFilter
      {
         get { return SqlHelper.GetFilter(dbQuery); }
      }

      /// <summary>
      /// Gets or sets the reservations DataTable.
      /// </summary>
      /// <value>The reservations DT.</value>
      public DataTable ReservationsDT {get; set;}


      /// <summary>
      /// Returns type of incremental field.
      /// </summary>
      public PartType IncrementalField
      {
         get
         {
            // order does matter
            if (HasSequence) return PartType.Sequence;
            if (HasDay) return PartType.Day;
            if (HasWeek) return PartType.Week;
            if (HasMonth) return PartType.Month;
            if (HasYear) return PartType.Year;

            return PartType.None;
         }
      }

      #region Methods

      /// <summary>
      /// Prevents from adding current values to change history.
      /// </summary>
      public void BeginLoadData()
      {
         initialization = true;
      }

      /// <summary>
      /// Restores a mode of changes tracking.
      /// </summary>
      public void EndLoadData()
      {
         initialization = false;
      }

      /// <summary>
      /// Creates the barcode format.
      /// </summary>
      /// <returns></returns>
      public string GetSequenceFormatString()
      {
         return GetSequenceFormatString(DateTime.Today);
      }

      /// <summary>
      /// Creates the barcode format, using specific date.
      /// </summary>
      /// <returns></returns>
      public string GetSequenceFormatString(DateTime date)
      {
         StringBuilder sb = new StringBuilder();
         PartType incField = IncrementalField;
         string val = "";

         foreach (SeriesTemplate.Part part in Template.Parts)
         {
            PartType currentPartType = part.GetValue(out val);
            if (currentPartType == incField)
            {
               if (part.IsSequence)
               {
                  val = "{0:" + new String('0', part.Sequence.Length) + "}";
               }
               else
               {
                  val = "{0}";
               }
               sb.Append(val);
               continue;
            }

            if (part.IsDay || part.IsMonth || part.IsYear)
            {
               val = date.ToString(SeriesDefinition.FilterValue2DateFormat(part.Date, currentPartType));
            }
            else if (part.IsWeek)
            {
               val = GetWeekNumber(date, SeriesDefinition.FilterValue2DateFormat(part.Date, currentPartType));
            }
            else
            {
               val = part.Text ?? string.Empty;
            }

            sb.Append(val);
         }

         return sb.ToString();
      }

      /// <summary>
      /// Creates the barcode format.
      /// </summary>
      /// <param name="type">The type of increment field.</param>
      /// <returns></returns>
      public string GetDateFormatString()
      {
         return GetDateFormatString(DateTime.Today);
      }


      /// <summary>
      /// Creates the barcode format for specific date.
      /// </summary>
      /// <param name="type">The type of increment field.</param>
      /// <returns></returns>
      public string GetDateFormatString(DateTime date)
      {
         StringBuilder sb = new StringBuilder();
         string val = "";

         foreach (SeriesTemplate.Part part in Template.Parts)
         {
            PartType currentPartType = part.GetValue(out val);

            if (part.IsDay || part.IsMonth || part.IsYear)
            {
               val = SeriesDefinition.FilterValue2DateFormat(part.Date, currentPartType);
            }
            else if (part.IsWeek)
            {
               // treat week number as text currently
               val = GetWeekNumber(date, SeriesDefinition.FilterValue2DateFormat(part.Date, currentPartType));
            }
            else
            {
               if (!string.IsNullOrEmpty(part.Text))
               {
                  StringBuilder escapedChars = new StringBuilder();
                  List<char> chars = new List<char>(part.Text.ToCharArray());
                  chars.ForEach(x => escapedChars.AppendFormat("\\{0}", x));
                  val = escapedChars.ToString();
               }
            }

            sb.Append(val);
         }

         return sb.ToString();
      }

      /// <summary>
      /// Returns formatted values for specified reservations
      /// </summary>
      /// <returns></returns>
      public List<string> GetValues(BSDataSet.ReservationRow reservationRow)
      {
         List<string> values = new List<string>();

         if (reservationRow.SERIES_ID != ID)
         {
            return values;
         }

         for (decimal k = reservationRow.MIN_VALUE; k <= reservationRow.MAX_VALUE; k++)
         {
            values.Add(string.Format(GetSequenceFormatString(), k));
         }

         return values;
      }

      #endregion

      #endregion

      #region Helper methods

      /// <summary>
      /// Returns the week number; week starts with Monday; 
      /// the first/last week of the year is determined by the biggest part (four days).
      /// </summary>
      /// <param name="dateTime"></param>
      /// <returns></returns>
      public static string GetWeekNumber(DateTime dateTime, string format)
      {
         return CultureInfo.CurrentCulture.Calendar.GetWeekOfYear(
            dateTime,
            CalendarWeekRule.FirstFourDayWeek,
            DayOfWeek.Monday).ToString(format);
      }

      /// <summary>
      /// Returns the week number; week starts with Monday; 
      /// the first/last week of the year is determined by the biggest part (four days).
      /// </summary>
      /// <param name="dateTime"></param>
      /// <returns></returns>
      public static decimal GetWeekNumber(DateTime dateTime)
      {
         return CultureInfo.CurrentCulture.Calendar.GetWeekOfYear(dateTime, CalendarWeekRule.FirstFourDayWeek, DayOfWeek.Monday);
      }

      /// <summary>
      /// Converts combobox label to valid date format.
      /// </summary>
      /// <param name="userFormat"></param>
      /// <param name="comboType"></param>
      /// <returns></returns>
      public static string FilterValue2DateFormat(string userFormat, PartType type)
      {
         if (type == PartType.Year)
         {
            return userFormat.ToLower();
         }

         if (type == PartType.Month)
         {
            // month goes in upper case
            return (userFormat.ToUpper() == "NAME") ? "MMMM" : userFormat.ToUpper();
         }

         if (type == PartType.Sequence || type == PartType.Week)
         {
            return new string('0', userFormat.Length);
         }

         if (type == PartType.Day)
         {
            switch (userFormat.ToUpper())
            {
               case "NAME":
                  return "dddd";
               case "D":
                  return "%d";
               default:
                  return userFormat.ToLower();
            }
         }

         return userFormat;
      }

      /// <summary>
      /// Converts combobox label to valid date format.
      /// </summary>
      /// <param name="userFormat"></param>
      /// <param name="comboType"></param>
      /// <returns></returns>
      public static string FilterDateFormat2Value(string dateFormat)
      {
         switch (dateFormat)
         {
            case "MMMM":
            case "dddd":
               return "NAME";
            case "%d":
               return "D";
            default:
               return dateFormat;
         }
      }

      #endregion

      #region public properties
      /// <summary>
      /// Checks if Series contains sequence field.
      /// </summary>
      public bool HasSequence
      {
         get
         {
            if (Template.Parts == null) return false;

            foreach (SeriesTemplate.Part part in Template.Parts)
            {
               if (part.IsSequence) return true;
            }

            return false;
         }
      }

      public bool HasTestQuery
      {
         get
         {
            return !string.IsNullOrEmpty(TableSchema) && !string.IsNullOrEmpty(TableName) && !string.IsNullOrEmpty(TableField);
         }
      }

      /// <summary>
      /// Checks if Series contains day field.
      /// </summary>
      public bool HasWeek
      {
         get
         {
            if (Template.Parts == null) return false;

            foreach (SeriesTemplate.Part part in Template.Parts)
            {
               if (part.IsWeek) return true;
            }

            return false;
         }
      }

      /// <summary>
      /// Checks if Series contains day field.
      /// </summary>
      public bool HasDay
      {
         get
         {
            if (Template.Parts == null) return false;

            foreach (SeriesTemplate.Part part in Template.Parts)
            {
               if (part.IsDay) return true;
            }

            return false;
         }
      }


      /// <summary>
      /// Checks if Series contains month field.
      /// </summary>
      public bool HasMonth
      {
         get
         {
            if (Template.Parts == null) return false;

            foreach (SeriesTemplate.Part part in Template.Parts)
            {
               if (part.IsMonth) return true;
            }

            return false;
         }
      }

      /// <summary>
      /// Checks if Series contains year field.
      /// </summary>
      public bool HasYear
      {
         get
         {
            if (Template.Parts == null) return false;

            foreach (SeriesTemplate.Part part in Template.Parts)
            {
               if (part.IsYear) return true;
            }

            return false;
         }
      }
      #endregion

      #region Serialization

      /// <summary>
      /// Deserializes the class.
      /// </summary>
      /// <param name="rangeDefinition"></param>
      /// <returns>Instance of RangeDefinition</returns>
      public static T Deserialize<T>(string xml) where T : ITinySerializable
      {
         if (string.IsNullOrEmpty(xml)) return default(T);

         var sr = new TinyXmlSerializer();
         return sr.Deserialize<T>(xml);
      }

      /// <summary>
      /// Serializes the class.
      /// </summary>
      /// <typeparam name="T"></typeparam>
      /// <param name="instance">The instance.</param>
      /// <returns>Serialized string.</returns>
      public static string Serialize<T>(T instance) where T: ITinySerializable
      {
         var sr = new TinyXmlSerializer();
         return sr.Serialize(instance);
      }

      #endregion

      #region DB entities

      public SeriesTemplate Template { get; set; }

      private SeriesConnectionData conn;
      public SeriesConnectionData Connection 
      { 
         get { return conn; }
      }

      public void SetConnection(SeriesConnectionData connectionData)
      {
         SetConnection(connectionData, true);
      }

      public void SetConnection(SeriesConnectionData connectionData, bool loadData)
      {
         conn = connectionData;

         if (loadData)
         {
            ResourceSystem rs = TryGetResourceSystem(conn.SequenceResourceName);
            SequenceProviderType = TryGetResourceSystemType(rs);
            SequenceConnectionString = TryGetConnection(conn.SequenceResourceName, conn.SequenceAccount);

            rs = TryGetResourceSystem(conn.TableResourceName);
            TableProviderType = TryGetResourceSystemType(rs);
            TableConnectionString = TryGetConnection(conn.TableResourceName, conn.TableAccount);
         }

      }

      private DataProviderType TryGetResourceSystemType(ResourceSystem rs)
      {
         return rs.ResourceSystemType != null
            ? (DataProviderType)Enum.Parse(typeof(DataProviderType), rs.ResourceSystemType.Name)
            : DataProviderType.ODBC;
      }

      private ResourceSystem TryGetResourceSystem(string rn)
      {
         try
         {
            return ArmsAccessor.Instance.Service.GetResourceSystem(conn.SequenceResourceName);
         }
         catch (Exception ex)
         {
            return new ResourceSystem();// { Name = rn};
         }
      }

      private string TryGetConnection(string sequenceResourceName, string sequenceAccount)
      {
         try
         {
            return ArmsAccessor.Instance.Service.GetConnectionString(ProviderType.Odp, sequenceResourceName, sequenceAccount);
         }
         catch (Exception ex)
         {
            return "";
         }
      }

      #endregion

      #region Enums

      public enum RangeState
      {
         Insert,
         Update,
         Delete
      }


      #endregion

      #region Track history

      private Dictionary<string, string> changes = new Dictionary<string, string>();

      /// <summary>
      /// Returns xml with original values of properties.
      /// </summary>
      /// <returns></returns>
      public string GetChanges()
      {
         return GetChanges(MAX_LENGTH);
      }

      /// <summary>
      /// Returns xml with original values of properties.
      /// </summary>
      /// <param name="maxLength"></param>
      /// <returns></returns>
      public string GetChanges(int maxLength)
      {
         if (changes.Count == 0)
         {
            return string.Empty;
         }

         StringBuilder sb = new StringBuilder(maxLength);

         foreach (KeyValuePair<string, string> pair in changes)
         {
            sb.AppendFormat(format, pair.Key, pair.Value);
         }

         return EnsureInfoLength(sb.ToString());
      }

      /// <summary>
      /// Ensures that length of string not exceeds the maximum length (4000 bytes).
      /// </summary>
      /// <param name="info"></param>
      /// <returns></returns>
      public string EnsureInfoLength(string info)
      {
         if (info.Length > MAX_LENGTH)
         {
            info = CUT_TAG_OPEN + info.Substring(0, MAX_LENGTH - (CUT_TAG_CLOSE.Length * 2 - 1)) + CUT_TAG_CLOSE;
         }
         return info;
      }

      #endregion

   }
}
