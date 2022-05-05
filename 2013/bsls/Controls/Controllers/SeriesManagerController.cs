#region Copyright (C) 1994-2009, Johnson & Johnson PRD, LLC.
//---------------------------------------------------------------------------*
//
//    RangeGeneratorControlMediator.cs: Mediator for RangeGeneratorControl.
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
using System.Windows.Forms;
using System.Drawing;
using System.Xml.Serialization;
using System.IO;
using Jnj.ThirdDimension.Util.UsageLog;
using System.Xml;
using System.Data;
using System.Threading;
using Jnj.ThirdDimension.Data.BarcodeSeries;
using Jnj.ThirdDimension.BusinessLayer.BarcodeSeries;
using Jnj.ThirdDimension.Utils.BarcodeSeries;
using Jnj.Windows.Forms;
using Jnj.ThirdDimension.Lims.Core;
using System.Data.Objects;
using Jnj.ThirdDimension.Arms.Model;
using Jnj.ThirdDimension.Lims.Interface;
using System.Linq;
using Jnj.ThirdDimension.Data;
using Jnj.ThirdDimension.Base;
using System.Text.RegularExpressions;
using Group=System.Text.RegularExpressions.Group;
using Jnj.ThirdDimension.Controls.Grid;
using System.Globalization;
using Application=Jnj.ThirdDimension.Arms.Model.Application;
using Jnj.ThirdDimension.Controls.BarcodeSeries.Properties;


namespace Jnj.ThirdDimension.Controls.BarcodeSeries
{

   /// <summary>
   /// Supports default behaviour of the RangeGenerator control,
   /// the purpose of the class is to facilitate reusing of the this control.
   /// To define new rules you need to override neccessary virtual methods.
   /// </summary>
   public class SeriesManagerController : BaseGridController<BSDataSet.ReservationDataTable>
   {

      #region Declarations

      private SeriesManager seriesManager;   // view instance
      private SeriesDefinition range = null;
      private int newID = -1;

      #endregion


      #region Constructors

      private SeriesManagerController ()
      {
      }

      public SeriesManagerController(SeriesManager view, BSDataSet.ReservationDataTable sourceDT, SimpleGrid grid):base (view, sourceDT, grid)
      {
         this.seriesManager = view;

         InitializeEditor();
         InitializeGrid();
      }

      #endregion


      #region Properties
      public SeriesDataLayer DataLayer
      {
         get { return seriesManager.DataLayer; }
      }

      #endregion


      #region Public methods
      /// <summary>
      /// Loads ranges from database.
      /// </summary>
      internal BSDataSet.SeriesDataTable GetSeries()
      {
         return DataLayer.SeriesDB.GetSeries();
      }

      /// <summary>
      /// Loads ranges from database with filter.
      /// </summary>
      internal BSDataSet.SeriesDataTable GetSeries(string filter)
      {
         return DataLayer.SeriesDB.GetSeries(filter);
      }

      /// <summary>
      /// Loads range reservations from database.
      /// </summary>
      /// <param name="labelSerieID"></param>
      /// <returns></returns>
      internal BSDataSet.ReservationDataTable GetRangeReservation(decimal labelSerieID)
      {
         string filter = string.Format("{0} = {1}", DataLayer.DataSet.Reservation.SERIES_IDColumn.ColumnName, labelSerieID);
         return DataLayer.SeriesDB.GetRangeReservation(filter);
      }

      /// <summary>
      /// Creates table with LabelSeries info
      /// </summary>
      /// <param name="rangeDefinition"></param>
      /// <returns></returns>
      internal BSDataSet.SeriesDataTable GetSeriesDataTable(SeriesDefinition rangeDefinition, out bool newRange)
      {
         BSDataSet.SeriesDataTable lsdt = new BSDataSet.SeriesDataTable();
         BSDataSet.SeriesRow row = lsdt.NewSeriesRow();

         row.ID = rangeDefinition.ID;
         row.NAME = rangeDefinition.Name;
         row.RESET_TYPE_ID = rangeDefinition.ResetTypeId;
         row.RANGE_DEFINITION = SeriesDefinition.Serialize<SeriesTemplate>(rangeDefinition.Template);
         row.DB_CONNECTION = SeriesDefinition.Serialize<SeriesConnectionData>(rangeDefinition.Connection);
         row.DB_CHECK_QUERY = rangeDefinition.DBQuery;
         row.DB_SEQUENCE = rangeDefinition.DBSequence;
         SetNullableValueToColumn(row, lsdt.RANGE_START_FROMColumn.ColumnName, rangeDefinition.Start);
         row.LAST_DATE = DateTime.UtcNow;
         row.LAST_PERSON_ID = DataLayer.SecurityContext.User.PersonID;
         row.OWNER_ID = DataLayer.SecurityContext.User.PersonID;

         lsdt.AddSeriesRow(row);

         row.AcceptChanges();
         newRange = SetRowState(row, rangeDefinition.State);

         return lsdt;
      }

      /// <summary>
      /// Creates the label series event DataTable.
      /// </summary>
      /// <param name="sd">The sd.</param>
      /// <returns></returns>
      internal BSDataSet.SeriesEventDataTable GetSeriesEventDataTable(SeriesDefinition sd)
      {
         BSDataSet.SeriesEventDataTable dt = new BSDataSet.SeriesEventDataTable();
         BSDataSet.SeriesEventRow row = dt.NewSeriesEventRow();

         row.EVENT_DATE = DateTime.UtcNow;
         row.EVENT_TYPE_ID = (decimal)((sd.State == SeriesDefinition.RangeState.Insert) 
            ? SeriesEventType.Defined 
            : SeriesEventType.Updated);
         row.ID = -1;
         row.SERIES_ID = sd.ID;
         row.PERSON_ID = DataLayer.SecurityContext.User.PersonID;

         row.INFORMATION = sd.GetChanges();

         // do not add event if it is an update, but nothing was changed
         if (string.IsNullOrEmpty(row.INFORMATION.Trim()) && row.EVENT_TYPE_ID == (decimal)SeriesEventType.Updated)
         {
            return dt;
         }

         dt.Rows.Add(row);
         return dt;
      }

      #region Static methods
      /// <summary>
      /// Creates the label series reservation events.
      /// </summary>
      /// <param name="sd">The sd.</param>
      /// <returns></returns>
      public BSDataSet.SeriesEventDataTable GetSeriesEventDataTableForReservation(BSDataSet.ReservationDataTable rdt)
      {
         BSDataSet.SeriesEventDataTable dt = new BSDataSet.SeriesEventDataTable();
         BSDataSet.SeriesEventRow row;

         foreach (BSDataSet.ReservationRow resRow in rdt.Rows)
         {
            if (resRow.RowState == DataRowState.Modified || resRow.RowState == DataRowState.Added)
            {
               row = dt.NewSeriesEventRow();

               row.EVENT_DATE = DateTime.UtcNow;
               row.EVENT_TYPE_ID = (decimal) SeriesEventType.Reserved;
               row.ID = -1;
               row.SERIES_ID = resRow.SERIES_ID;
               row.PERSON_ID = DataLayer.SecurityContext.User.PersonID;

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

      #endregion

      /// <summary>
      /// Updates SERIES_ID.
      /// </summary>
      /// <param name="sd">The sd.</param>
      /// <param name="id">The id.</param>
      internal void UpdateSeriesId(SeriesDefinition sd, decimal id)
      {
         if (sd.ReservationsDT == null) return;

         sd.ID = id;
         foreach (BSDataSet.ReservationRow row in sd.ReservationsDT.Rows)
         {
            row.SERIES_ID = id;
         }
      }

      /// <summary>
      /// Creates the sequence.
      /// </summary>
      /// <param name="dbOptions">The db options.</param>
      internal decimal CreateSequence(decimal rangeStart,  DBSettingsDialog dbOptions, DbOdpConnection provider)
      {
         decimal result = InstantDbAccess.GetSequenceLastNumber(SeriesDataLayer.SEQ_SCHEMA_NAME, dbOptions.SequenceName, provider);

         DialogResult answer = DialogResult.None;
         if (result > 0)
         {
            answer = MessagesHelper.ShowQuestion(string.Format(Resources.Question_SeqExistsInCurrentSchema_Format, dbOptions.SequenceSchemaName.ToUpper(), SeriesDataLayer.SEQ_SCHEMA_NAME),
                                        WizardHelper.FindParentHeaderText(seriesManager), MessageBoxButtons.YesNo);
            if (answer == DialogResult.Yes)
            {
               dbOptions.SequenceSchemaName = SeriesDataLayer.SEQ_SCHEMA_NAME;
               return result;
            }
         }
         else
         {
            answer = MessagesHelper.ShowQuestion(string.Format(Resources.Question_CreateNewSeq_Format, SeriesDataLayer.SEQ_SCHEMA_NAME),
                                                 WizardHelper.FindParentHeaderText(seriesManager),
                                                 MessageBoxButtons.YesNo);

            if (answer == DialogResult.Yes)
            {
               dbOptions.SequenceSchemaName = SeriesDataLayer.SEQ_SCHEMA_NAME;
               using (AsynchronousWaitDialog.ShowWaitDialog(Resources.Wait_CreatingSeq, false))
               {
                  InstantDbAccess.CreateSequence(dbOptions.DBSequence, rangeStart, provider);
                  result = InstantDbAccess.GetSequenceLastNumber(dbOptions.SequenceSchemaName, dbOptions.SequenceName, provider);
               }
            }
            return result;
         }
         return -1;
      }

      /// <summary>
      /// Sets value or DBNull.Value
      /// </summary>
      /// <param name="row"></param>
      /// <param name="column"></param>
      /// <param name="value"></param>
      private void SetNullableValueToColumn(DataRow row, string column, decimal? value)
      {
         if (value == null)
            row[column] = DBNull.Value;
         else
            row[column] = value;
      }

      /// <summary>
      /// Sets the appropriate row state.
      /// </summary>
      /// <param name="row"></param>
      /// <param name="rangeState"></param>
      private bool SetRowState(BSDataSet.SeriesRow row, SeriesDefinition.RangeState rangeState)
      {
         switch (rangeState)
         {
            case SeriesDefinition.RangeState.Delete:
               row.Delete();
               return false;
            case SeriesDefinition.RangeState.Update:
               row.SetModified();
               return false;
            default:
               row.SetAdded();
               return true;
         }
      }

      #endregion


      #region Initialization & Saving

      /// <summary>
      /// Validates user input.
      /// </summary>
      /// <param name="errorMessage">The error message.</param>
      /// <returns></returns>
      public bool Validate (out string errorMessage)
      {
         errorMessage = string.Empty;

         if (string.IsNullOrEmpty(seriesManager.RangeName))
         {
            errorMessage = Resources.Error_EmptySeriesName;
            return false;
         }
         string filter = string.Format("{0}='{1}'", DataLayer.DataSet.Series.NAMEColumn.ColumnName, seriesManager.RangeName.OracleEscaped());
         using (DataLayer.Connect())
         {
            if (DataLayer.SeriesDB.GetSeries(filter).Rows.Count > 0 && range.State == SeriesDefinition.RangeState.Insert)
            {
               errorMessage = Resources.Error_ExistedSeriesName;
               return false;
            }
         }

         if (range == null)
         {
            GetSeriesDefinition();
         }

         if (!range.HasSequence && !(range.HasDay && range.HasMonth && range.HasYear))
         {
            errorMessage = Resources.Error_IncorrectSeriesTemplate;
            return false;
         }

         if (string.IsNullOrEmpty(seriesManager.DBOptionsDialog.DBQuery))
         {
            errorMessage = Resources.Error_EmptyQuery;
            return false;
         }

         if (seriesManager.DesktopPanel.Controls.Count == 0)
         {
            errorMessage = Resources.Error_EmptySeriesTemplate;
            return false;
         }

         return true;
      }

      /// <summary>
      /// Sets the data source of Status column.
      /// </summary>
      /// <param name="statusSource">The status source.</param>
      public void SetReservationStatusDT(DataTable statusSource, string displayMember, string valueMember)
      {
         seriesManager.SetReservationStatusDataSource(statusSource, displayMember, valueMember);
      }
      
      /// <summary>
      /// Returns reset type.
      /// </summary>
      /// <returns></returns>
      private decimal GetResetType()
      {
         if (seriesManager.Day)
         {
            return (decimal) SeriesResetType.Day;
         }
         if (seriesManager.Month)
         {
            return (decimal) SeriesResetType.Month;
         }
         if (seriesManager.Week)
         {
            return (decimal) SeriesResetType.Week;
         }
         if (seriesManager.Year)
         {
            return (decimal) SeriesResetType.Year;
         }

         return (decimal) SeriesResetType.Never;
      }

      /// <summary>
      /// Sets controls values.
      /// </summary>
      /// <param name="series"></param>
      public void SetSeries(SeriesDefinition series)
      {
         this.range = series;
         LoadRangeDefinitions();
         GridHelper.FitColWidth(grid);
      }

      /// <summary>
      /// Gathers the range info.
      /// </summary>
      /// <param name="range">The range.</param>
      public SeriesDefinition GetSeriesDefinition()
      {
         range.BeginLoadData();

         range.Name = seriesManager.RangeName;
         range.Start = GetRangeStart();
         range.ResetTypeId = GetResetType();

         range.Template.Parts = seriesManager.TemplateEditor.GetTemplate();

         range.Connection.SequenceAccount = seriesManager.DBOptionsDialog.SequenceAccountName;
         range.Connection.SequenceResourceName = seriesManager.DBOptionsDialog.SequenceResourceName;
         range.Connection.TableAccount = seriesManager.DBOptionsDialog.TableAccountName;
         range.Connection.TableResourceName = seriesManager.DBOptionsDialog.TableResourceName;

         range.DBSequence = seriesManager.DBOptionsDialog.DBSequence;
         range.DBQuery = seriesManager.DBOptionsDialog.DBQuery;
         range.ReservationsDT = dataSource;

         range.EndLoadData();

         return range;
      }

      /// <summary>
      /// Gets the range start.
      /// </summary>
      /// <returns></returns>
      private decimal GetRangeStart()
      {
         return (decimal)seriesManager.RangeStart;
      }

      /// <summary>
      /// Opens the AddDBObjectDialog.
      /// </summary>
      internal void OpenDBDialog()
      {
         if (seriesManager.RangeName.IsEmpty())
         {
            MessagesHelper.ShowInformation("Please provide Label Series name first.", WizardHelper.FindParentHeaderText(seriesManager));
            return;
         }

         var dialog = seriesManager.DBOptionsDialog;

         using (AsynchronousWaitDialog.ShowWaitDialog("Loading...", false))
         {

            EnsureResources();
            
            try
            {
               //dialog.SuspendComboBoxUpdate = true;

               dialog.AutoSequenceManagement = true;

               dialog.SeriesName = seriesManager.RangeName;
               dialog.DBQuery = seriesManager.SqlQueryText;
               
               dialog.SequenceResourceName = seriesManager.SequenceResourceText;
               dialog.SequenceAccountName = seriesManager.SequenceAccountText;
               dialog.DBSequence = seriesManager.SequenceNameText;               
               dialog.TableResourceName = seriesManager.TableResourceText;
               dialog.TableAccountName = seriesManager.TableAccountText;               

               dialog.UseValidationQuery =
                  !string.IsNullOrEmpty(dialog.TableAccountName) &&
                  !string.IsNullOrEmpty(dialog.TableResourceName) &&
                  !string.IsNullOrEmpty(dialog.TableSchemaName) &&
                  !string.IsNullOrEmpty(dialog.TableName) &&
                  !string.IsNullOrEmpty(dialog.FieldName);               
            }
            finally
            {
               //dialog.SuspendComboBoxUpdate = false;
            }
         }

         if (dialog.ShowDialog() == DialogResult.OK)
         {
            seriesManager.SqlQueryText = dialog.DBQuery;
            seriesManager.SequenceNameText = dialog.DBSequence;
            seriesManager.SequenceResourceText = dialog.SequenceResourceName;
            seriesManager.SequenceAccountText = dialog.SequenceAccountName;
            seriesManager.TableResourceText = dialog.TableResourceName;
            seriesManager.TableAccountText = dialog.TableAccountName;
         }
      }


      private void EnsureResources()
      {
         
         using (AsynchronousWaitDialog.ShowWaitDialog("Loading...", false))
         {
            if (seriesManager.DBOptionsDialog.TableResources == null ||
                seriesManager.DBOptionsDialog.TableResources.Count == 0)
            {

               seriesManager.DBOptionsDialog.TableResources = ArmsAccessor.Instance.GetResources();
            }

            if (seriesManager.DBOptionsDialog.SequenceResources == null ||
                seriesManager.DBOptionsDialog.SequenceResources.Count == 0)
            {
               ResourceSystem[] rs = new ResourceSystem[seriesManager.DBOptionsDialog.TableResources.Count];
               seriesManager.DBOptionsDialog.TableResources.CopyTo(rs);
               seriesManager.DBOptionsDialog.SequenceResources = new List<ResourceSystem>(rs);
            }
         }
      }


      /// <summary>
      /// Resets this instance.
      /// </summary>
      public override void Reset()
      {
         dataSource.Clear();
         range = new SeriesDefinition().GetInitialized();
         newID = -1;
      }

      /// <summary>
      /// Loads range definition.
      /// </summary>
      /// <param name="p"></param>
      private void LoadRangeDefinitions()
      {
         if (range == null) return;

         EnsureResources();

         seriesManager.RangeName = range.Name;
         seriesManager.RangeStart = (long)(range.Start ?? 1);
         seriesManager.DBOptionsDialog.DBSequence = range.DBSequence;
         seriesManager.DBOptionsDialog.DBQuery = range.DBQuery;

         seriesManager.DBOptionsDialog.TableResourceName = range.Connection.TableResourceName;
         seriesManager.DBOptionsDialog.TableAccountName = range.Connection.TableAccount;
         seriesManager.DBOptionsDialog.TableSchemaName = range.TableSchema;
         seriesManager.DBOptionsDialog.TableName = range.TableName;
         seriesManager.DBOptionsDialog.FieldName = range.TableField;
         seriesManager.DBOptionsDialog.TableDataProviderType = range.TableProviderType;
         seriesManager.DBOptionsDialog.TableConnectionString = range.TableConnectionString;

         seriesManager.DBOptionsDialog.SequenceResourceName = range.Connection.SequenceResourceName;
         seriesManager.DBOptionsDialog.SequenceAccountName = range.Connection.SequenceAccount;
         seriesManager.DBOptionsDialog.SequenceSchemaName = range.SequenceSchema;
         seriesManager.DBOptionsDialog.SequenceName = range.SequenceName;
         seriesManager.DBOptionsDialog.SequenceDataProviderType = range.SequenceProviderType;
         seriesManager.DBOptionsDialog.SequenceConnectionString = range.SequenceConnectionString;
         seriesManager.DBOptionsDialog.AutoSequenceManagement = false;
         seriesManager.DBOptionsDialog.UseValidationQuery = false;

         seriesManager.SequenceNameText = range.DBSequence;
         seriesManager.SqlQueryText = range.DBQuery;
         seriesManager.SequenceAccountText = range.Connection.SequenceAccount;
         seriesManager.SequenceResourceText = range.Connection.SequenceResourceName;
         seriesManager.TableAccountText = range.Connection.TableAccount;
         seriesManager.TableResourceText = range.Connection.TableResourceName;

         decimal resetTypeId = range.ResetTypeId;
         if (resetTypeId > 0)
         {
            if (resetTypeId == (int)SeriesResetType.Day)
               seriesManager.Day = true;
            if (resetTypeId == (int)SeriesResetType.Week)
               seriesManager.Week = true;
            else if (resetTypeId == (int)SeriesResetType.Month)
               seriesManager.Month = true;
            else if (resetTypeId == (int)SeriesResetType.Year)
               seriesManager.Year = true;
         }


         seriesManager.TemplateEditor.LoadTemplate(range.Template.Parts);

         dataSource.Clear();
         ProcessReservations((BSDataSet.ReservationDataTable)range.ReservationsDT);
         dataSource.Merge(range.ReservationsDT);
         grid.Refresh();

         seriesManager.TemplateEditor.ConstructExample();
      }

      private void ProcessReservations(BSDataSet.ReservationDataTable dataTable)
      {
         foreach (DataRowView viewRow in dataTable.DefaultView)
         {
            var row = viewRow.Row as BSDataSet.ReservationRow;

            string user_min_val = "";
            string user_max_val = "";

            foreach (SeriesTemplate.Part part in range.Template.Parts)
            {
               if (part.IsSequence)
               {
                  var min = row.MIN_VALUE.ToString();
                  var minSpacers = min.Length > part.Sequence.Length ? "" : new string('0', part.Sequence.Length - min.Length);
                  var max = row.MAX_VALUE.ToString();
                  var maxSpacers = max.Length > part.Sequence.Length ? "" : new string('0', part.Sequence.Length - max.Length);

                  user_min_val += minSpacers + min;
                  user_max_val += maxSpacers + max;
               }
               else if (part.IsWeek)
               {
                  user_min_val += SeriesDefinition.GetWeekNumber(row.MIN_DATE_TIME, SeriesDefinition.FilterValue2DateFormat(part.Date, PartType.Week));
                  user_max_val += SeriesDefinition.GetWeekNumber(row.MAX_DATE_TIME, SeriesDefinition.FilterValue2DateFormat(part.Date, PartType.Week));
               }
               else if ((part.IsDay || part.IsMonth || part.IsYear))
               {
                  user_min_val += row.MIN_DATE_TIME.ToString(part.Date);
                  user_max_val += row.MAX_DATE_TIME.ToString(part.Date);
               }
               else if (!string.IsNullOrEmpty(part.Text))
               {
                  user_min_val += part.Text;
                  user_max_val += part.Text;
               }
            }

            row.USER_MIN_VALUE = user_min_val;
            row.USER_MAX_VALUE = user_max_val;
         }
      }

      #endregion


      #region Other event handlers

      bool min_Validate(ValidateEventArgs e)
      {
         var row = GetCurrentRow() as BSDataSet.ReservationRow;

         if (row.IsNull(dataSource.MAX_VALUEColumn)) return true;

         if (row.MAX_VALUE > 0 && (decimal)e.Value > row.MAX_VALUE)
         {
            e.ErrorMessage = Resources.Error_MinIsGreater;
            return false;
         }

         if (IsOverlapping((decimal)e.Value))
         {
            e.ErrorMessage = Resources.Error_IntersectingRanges;
            return false;
         }
         
         return true;
      }

      bool max_Validate(ValidateEventArgs e)
      {
         var row = GetCurrentRow() as BSDataSet.ReservationRow;

         if (row.IsNull(dataSource.MIN_VALUEColumn)) return true;

         if (row.MIN_VALUE > 0 && (decimal)e.Value < row.MIN_VALUE)
         {
            e.ErrorMessage = Resources.Error_MaxIsLesser;
            return false;
         }

         if (IsOverlapping((decimal)e.Value))
         {
            e.ErrorMessage = Resources.Error_IntersectingRanges;
            return false;
         }

         return true;
      }

      bool dateMin_Validate(ValidateEventArgs e)
      {
         var row = GetCurrentRow() as BSDataSet.ReservationRow;

         if (row.MAX_DATE_TIME == DateTime.MinValue) return true;

         if ((DateTime)e.Value > row.MAX_DATE_TIME)
         {
            e.ErrorMessage = Resources.Error_StartDateGreater;
            return false;
         }

         return true;
      }

      bool dateMax_Validate(ValidateEventArgs e)
      {
         var row = GetCurrentRow() as BSDataSet.ReservationRow;

         if (row.MIN_DATE_TIME == DateTime.MinValue) return true;

         if ((DateTime)e.Value < row.MIN_DATE_TIME)
         {
            e.ErrorMessage = Resources.Error_EndDateLesser;
            return false;
         }

         return true;
      }

      #endregion

      /// <summary>
      /// Handles the TestSequence event of the Mediator.
      /// </summary>
      internal void TestConnection(DBSettingsDialog dbOptions, TestConnectionEventArgs e)
      {
         TestSequence(dbOptions, e);
         TestTargetTable(dbOptions, e);
      }      

      public void TestTargetTable(DBSettingsDialog dbOptions, TestConnectionEventArgs e)
      {
         // try to connect
         string connStr = dbOptions.TableDecryptedConnectionString;

         using (AsynchronousWaitDialog.ShowWaitDialog(Resources.Wait_Connect, false))
         {
            e.TableServerConnected = InstantDbAccess.TryConnection(connStr, dbOptions.TableDataProviderType);
         }

         if (e.TableServerConnected)
         {
            using (DbConnection provider = InstantDbAccess.Connect(connStr, dbOptions.TableDataProviderType))
            {
               using (AsynchronousWaitDialog.ShowWaitDialog(Resources.Wait_RetrievingData, false))
               {
                  // check DB query
                  string countQuery = SqlHelper.SelectCount(dbOptions.DBQuery);
                  DataTable dt = InstantDbAccess.GetDataTable<DataTable>(countQuery, provider);
                  if (dt != null && dt.Rows.Count > 0)
                  {
                     e.QueryResult = Convert.ToInt64(dt.Rows[0][0]);
                     dt.Dispose();
                  }
               }
            }
         }
      }

      public void TestSequence(DBSettingsDialog dbOptions, TestConnectionEventArgs e)
      {

         // try to connect
         string connStr = dbOptions.SequenceDecryptedConnectionString;

         using (AsynchronousWaitDialog.ShowWaitDialog(Resources.Wait_Connect, false))
         {
            e.SequenceServerConnected = InstantDbAccess.TryConnection(connStr, dbOptions.SequenceDataProviderType);
         }

         if (e.SequenceServerConnected)
         {
            using (DbConnection provider = InstantDbAccess.Connect(connStr, dbOptions.SequenceDataProviderType))
            {
               // check and/or create sequence 
               if (dbOptions.SequenceDataProviderType == DataProviderType.ODP)
               {
                  var prov = provider as DbOdpConnection;
                  e.SequenceCurrentValue = InstantDbAccess.GetSequenceLastNumber(dbOptions.SequenceSchemaName, dbOptions.SequenceName, prov);
                  if (e.SequenceCurrentValue == -1)
                  {
                     e.SequenceCurrentValue = CreateSequence(seriesManager.RangeStart, dbOptions, prov);
                  }
               }
            }
         }
      }

      internal bool IsOverlapping(decimal value)
      {
         var crow = GetCurrentRow() as BSDataSet.ReservationRow;
         foreach (BSDataSet.ReservationRow row in dataSource.Rows)
         {
            if (crow.ID == row.ID) continue;
            
            if (value >= row.MIN_VALUE && value <= row.MAX_VALUE) 
               return true;
         }
         return false;
      }


      #region Base abstract methods implemetation

      public override void Submit()
      {
         throw new NotImplementedException();
      }

      public override void Import()
      {
         throw new NotImplementedException();
      }

      public override void Export()
      {
         throw new NotImplementedException();
      }

      public override void Print()
      {
         throw new NotImplementedException();
      }

      protected override void TrackChanges(DataColumnChangeEventArgs e)
      {
      }

      protected override void InitializeColumns()
      {
         throw new NotImplementedException();
      }

      protected override void HandleAutoChangeEvent(AutoChangeColumnValueEventArgs e)
      {
         throw new NotImplementedException();
      }

      protected override void CreateSubmitValidationRules(IGridDataBoundGridValidator submitValidator)
      {
         throw new NotImplementedException();
      }

      protected override void CreateInputValidationRules(IGridDataBoundGridValidator inputValidator)
      {
         var cache = DataLayer.DataSet.Reservation;
         inputValidator.Rules.Add(new GridValidationRule(cache.DESCRIPTIONColumn.ColumnName, string.Empty));
         inputValidator.Rules.Add(new GridValidationRule(cache.DESCRIPTIONColumn.ColumnName, DBNull.Value));

         GridValidationRule rule = new GridValidationRule(cache.MIN_VALUEColumn.ColumnName);
         rule.Validate += min_Validate;
         inputValidator.Rules.Add(rule);

         rule = new GridValidationRule(cache.MAX_VALUEColumn.ColumnName);
         rule.Validate += max_Validate;
         inputValidator.Rules.Add(rule);

         rule = new GridValidationRule(cache.MIN_DATE_TIMEColumn.ColumnName);
         rule.Validate += dateMin_Validate;
         inputValidator.Rules.Add(rule);

         rule = new GridValidationRule(cache.MAX_DATE_TIMEColumn.ColumnName);
         rule.Validate += dateMax_Validate;
         inputValidator.Rules.Add(rule);
      }

      protected override string GetCurrentViewNameForExport()
      {
         return Resources.TDX_Name;
      }

      protected override void ColumnChanged(DataColumnChangeEventArgs e)
      {
         try
         {
            string error = string.Empty;
            if (!InputValidator.IsValidColumn(e.Column.ColumnName, e.ProposedValue, out error))
            {
               MessagesHelper.ShowWarning(error, Resources.MessageBox_WarnTitle);
               grid.CurrentCell.CancelEdit();
               return;
            }

            BSDataSet.ReservationRow row = e.Row as BSDataSet.ReservationRow;

            if (e.Row.RowState == DataRowState.Detached)
            {
               InitializeRow(row);
            }

            if (e.Column.ColumnName == DataLayer.DataSet.Reservation.USER_MIN_VALUEColumn.ColumnName)
            {
               SetMinValue(e.ProposedValue.ToString(), row);
            }
            else if (e.Column.ColumnName == DataLayer.DataSet.Reservation.USER_MAX_VALUEColumn.ColumnName)
            {
               SetMaxValue(e.ProposedValue.ToString(), row);
            }
            
            GridHelper.FitColWidth(grid);
         }
         catch (Exception ex)
         {
            MessagesHelper.ReportError(ex, true);
         }
      }

      /// <summary>
      /// Sets the max value.
      /// </summary>
      /// <param name="p">The p.</param>
      /// <param name="row">The row.</param>
      private void SetMaxValue(string val, BSDataSet.ReservationRow row)
      {
         string error;

         string regexp = seriesManager.TemplateEditor.GetFilterRegExp();
         Regex r = new Regex(regexp);
         MatchCollection matches = r.Matches(val);

         if (matches.Count == 0)
         {
            MessagesHelper.ShowWarning(
               Resources.Message_IncorrectEdit,
               Resources.MessageBox_IncorrectInputTitle);
            grid.CurrentCell.CancelEdit();
            return;
         }

         Match match = matches[0];
         DateTime dt = GetReservationDateTime(match.Groups);
         if (dt == DateTime.MinValue)
         {
            MessagesHelper.ShowWarning(
               Resources.Message_IncorrectDate,
               Resources.MessageBox_IncorrectInputTitle);
            grid.CurrentCell.CancelEdit();
         }

         if (IsValidSequence(match.Groups))
         {
            row.MAX_VALUE = Convert.ToDecimal(match.Groups["sequence"].Value);
         }
         if (dt != DateTime.MaxValue)
         {
            row.MAX_DATE_TIME = dt;
         }

         if (!InputValidator.IsValidColumn(dataSource.MAX_DATE_TIMEColumn.ColumnName, row.MAX_DATE_TIME, out error) ||
             !InputValidator.IsValidColumn(dataSource.MAX_VALUEColumn.ColumnName, row.MAX_VALUE, out error))
         {
            MessagesHelper.ShowWarning(error, Resources.MessageBox_WarnTitle);
            grid.CurrentCell.CancelEdit();
            return;
         }
      }

      /// <summary>
      /// Sets the min value.
      /// </summary>
      /// <param name="val">The val.</param>
      /// <param name="row">The row.</param>
      private void SetMinValue(string val, BSDataSet.ReservationRow row)
      {
         string error;
         string regexp = seriesManager.TemplateEditor.GetFilterRegExp();
         Regex r = new Regex(regexp);
         MatchCollection matches = r.Matches(val);

         if (matches.Count == 0)
         {
            MessagesHelper.ShowWarning(
               Resources.Message_IncorrectEdit,
               Resources.MessageBox_IncorrectInputTitle);
            grid.CurrentCell.CancelEdit();
            return;
         }

         Match match = matches[0];
         DateTime dt = GetReservationDateTime(match.Groups);
         if (dt == DateTime.MinValue)
         {
            MessagesHelper.ShowWarning(
               Resources.Message_IncorrectDate,
               Resources.MessageBox_IncorrectInputTitle);
            grid.CurrentCell.CancelEdit();
         }

         if (IsValidSequence(match.Groups))
         {
            row.MIN_VALUE = Convert.ToDecimal(match.Groups["sequence"].Value);
         }
         if (dt != DateTime.MaxValue)
         {
            row.MIN_DATE_TIME = dt;
         }
         if (!InputValidator.IsValidColumn(dataSource.MIN_DATE_TIMEColumn.ColumnName, row.MIN_DATE_TIME, out error) ||
             !InputValidator.IsValidColumn(dataSource.MIN_VALUEColumn.ColumnName, row.MIN_VALUE, out error))
         {
            MessagesHelper.ShowWarning(error, Resources.MessageBox_WarnTitle);
            grid.CurrentCell.CancelEdit();
            return;
         }
      }


      private DateTime GetReservationDateTime(GroupCollection groups)
      {
         // means the date is not included
         if (!IsValidDate(groups)) return DateTime.MaxValue;

         DateTime dt = DateTime.MinValue;
         string timeToParse = string.Format("{0}-{1}-{2}",
                                            groups["year"].Value,
                                            groups["month"].Value,
                                            groups["day"].Value);
         string parseFormat = string.Format("{0}-{1}-{2}",
                                            new String('y', groups["year"].Value.Length),
                                            new String('M', groups["month"].Value.Length),
                                            new String('d', groups["day"].Value.Length));
         try
         {
            dt = DateTime.ParseExact(timeToParse, parseFormat, CultureInfo.InvariantCulture);
            return dt;
         }
         catch
         {
            // means the date is incorrect
            return DateTime.MinValue;
         }
      }


      private bool IsValidSequence(GroupCollection groups)
      {
         return !groups["sequence"].Value.IsEmpty();
      }

      private bool IsValidDate(GroupCollection groups)
      {
         return (!(groups["year"].Value.IsEmpty() || groups["month"].Value.IsEmpty() || groups["day"].Value.IsEmpty()));
      }

      private void InitializeRow(BSDataSet.ReservationRow row)
      {
         if (row.IsNull(dataSource.IDColumn))
         {
            row.ID = newID--;
            row.SERIES_ID = (range != null) ? range.ID : newID--;
            row.LAST_DATE = DateTime.UtcNow;
            row.LAST_PERSON_ID = DataLayer.SecurityContext.User.PersonID;
            row.RESERVATION_STATUS_ID = (decimal)ReservationStatus.Active;
            row.RESERVATION_STATUS = ReservationStatus.Active.ToString();
            row.MIN_VALUE = 0;
            row.MAX_VALUE = 0;
            row.MIN_DATE_TIME = DateTime.MinValue;
            row.MAX_DATE_TIME = DateTime.MinValue;

            row.USER_MIN_VALUE = seriesManager.TemplateEditor.CreateTemplateExample();
            row.USER_MAX_VALUE = seriesManager.TemplateEditor.CreateTemplateExample();

            SetMinValue(row.USER_MIN_VALUE, row);
            SetMaxValue(row.USER_MAX_VALUE, row);

            if (row.IsNull(dataSource.OWNER_IDColumn))
            {
               row.OWNER_ID = DataLayer.SecurityContext.User.PersonID;
            }
         }
      }


      protected override void OnClipboardPaste(object sender, Syncfusion.Windows.Forms.Grid.GridCutPasteEventArgs e)
      {
         
      }

      #endregion
   }

   /// <summary>
   /// Event arguments for LoadSeries event.
   /// </summary>
   public class ReservationRowChangedEventArgs : EventArgs
   {
      private DataColumnChangeEventArgs args;

      public SeriesDefinition Series;
      public bool Cancel;
      public DataColumnChangeEventArgs TableArgs { get { return args; } }

      public ReservationRowChangedEventArgs(DataColumnChangeEventArgs args)
      {
         this.args = args;
      }
   }

   /// <summary>
   /// Event arguments for ReservationRowChanged event.
   /// </summary>
   public class LoadSeriesEventArgs : EventArgs
   {
      public string SeriesNamePart;
   }
}
