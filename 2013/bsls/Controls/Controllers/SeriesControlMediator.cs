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

namespace Jnj.ThirdDimension.Controls.BarcodeSeries
{

   /// <summary>
   /// Supports default behaviour of the RangeGenerator control,
   /// the purpose of the class is to facilitate reusing of the this control.
   /// To define new rules you need to override neccessary virtual methods.
   /// </summary>
   public class SeriesControlMediator
   {

      #region Declarations
      protected SeriesControl rangeControl;   // View
      protected int MARGIN = 3;   // Margin for controls within the desktop panel.
      protected int TEMPLATE_WIDTH = 100;   // Width of controls in the desktop panel.
      protected const string SEQUENCE_FORMAT = "SEQUENCE";
      protected const string WEEK_FORMAT = "Week number (W##)";
      private SeriesDefinition range = null;
      private DataTable reservationDT = null;
      
      // masks of predefined values
      protected List<string> dateValues = new List<string>(
         new string[]
            {
               "yyyy",
               "yy",
               "MMMM",
               "MMM",
               "MM",
               "Week number (W##)",
               "dddd",
               "ddd",
               "dd"
            });

      #endregion

      #region Constructor
      public SeriesControlMediator(SeriesControl rangeControl)
      {
         this.rangeControl = rangeControl;
         this.rangeControl.Mediator = this;
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

         if (string.IsNullOrEmpty(rangeControl.RangeName))
         {
            errorMessage = "Series Name cannot be empty";
            return false;
         }
         if (string.IsNullOrEmpty(rangeControl.DBOptionsDialog.DBQuery))
         {
            errorMessage = "DB Query cannot be empty";
            return false;
         }
         if (rangeControl.DesktopPanel.Controls.Count == 0)
         {
            errorMessage = "Label Series format should be specified.";
            return false;
         }

         return true;
      }

      /// <summary>
      /// Sets the data source of Status column.
      /// </summary>
      /// <param name="statusSource">The status source.</param>
      public void SetReservationStatusDT(DataTable statusSource)
      {
         rangeControl.SetReservationStatusDataSource(statusSource);
      }
      
      /// <summary>
      /// Sets nulls to defaults, when the nulls are restricted.
      /// </summary>
      /// <param name="newRow">The new row.</param>
      private void SetNullsToDefaults(DataRow newRow)
      {
         foreach (DataColumn col in newRow.Table.Columns)
         {
            if (!col.AllowDBNull && newRow.IsNull(col))
            {
               if (col.DataType == typeof(DateTime))
               {
                  newRow[col] = DateTime.UtcNow;
                  continue;
               }
               if (col.DataType == typeof(decimal))
               {
                  newRow[col] = 0m;
                  continue;
               }

               newRow[col] = string.Empty;
            }
         }
      }

      /// <summary>
      /// Returns reset type.
      /// </summary>
      /// <returns></returns>
      private decimal GetResetType()
      {
         if (rangeControl.Day)
         {
            return (decimal) SeriesResetType.Day;
         }
         if (rangeControl.Month)
         {
            return (decimal) SeriesResetType.Month;
         }
         if (rangeControl.Week)
         {
            return (decimal) SeriesResetType.Week;
         }
         if (rangeControl.Year)
         {
            return (decimal) SeriesResetType.Year;
         }

         return (decimal) SeriesResetType.Never;
      }


      /// <summary>
      /// Shows dialog with database parameters.
      /// </summary>
      public void ShowAddDBDialog()
      {
         rangeControl.DBOptionsDialog.ShowDialog();
      }

      /// <summary>
      /// Sets controls values.
      /// </summary>
      /// <param name="series"></param>
      public void SetSeries(SeriesDefinition series)
      {
         this.range = series;
         LoadRangeDefinitions();
      }

      /// <summary>
      /// Gathers the range info.
      /// </summary>
      /// <param name="range">The range.</param>
      public SeriesDefinition GetSeries()
      {
         range.Name = rangeControl.RangeName;
         range.Start = GetRangeStart();
         range.ResetTypeId = GetResetType();

         range.DBConnection = rangeControl.DBOptionsDialog.EncryptedConnectionString;
         range.DBSequence = rangeControl.DBOptionsDialog.DBSequence;
         range.DBQueryRaw = rangeControl.DBOptionsDialog.DBQueryRaw;

         List<SeriesDefinition.Part> parts = new List<SeriesDefinition.Part>();

         foreach (Control ctl in rangeControl.DesktopPanel.Controls)
         {
            SeriesDefinition.Part part = new SeriesDefinition.Part();
            
            if (IsSequencePart(ctl))
            {
               part.Sequence = SEQUENCE_FORMAT;
            }
            else if (IsDatePart(ctl))
            {
               part.Date = GetFilterPattern(ctl);
            }
            else
            {
               part.Text = GetFilterPattern(ctl);
            }

            parts.Add(part);
         }
         
         range.Parts = parts.ToArray();
         return range;
      }

      /// <summary>
      /// Gets the range start.
      /// </summary>
      /// <returns></returns>
      private decimal GetRangeStart()
      {
         return (decimal)rangeControl.RangeStart;
      }

      /// <summary>
      /// Checks if the control contains date definition
      /// </summary>
      /// <param name="ctl"></param>
      /// <returns></returns>
      public bool IsDatePart(Control ctl)
      {
         return (ctl is ComboBox) && ((ComboBox)ctl).SelectedItem != null && dateValues.Contains(((ComboBox)ctl).SelectedItem.ToString());
      }

      /// <summary>
      /// Checks if the control contains sequence definition
      /// </summary>
      /// <param name="ctl"></param>
      /// <returns></returns>
      public bool IsSequencePart(Control ctl)
      {
         return (ctl is ComboBox) && ((ComboBox)ctl).SelectedItem != null && ((ComboBox)ctl).SelectedItem.ToString() == SEQUENCE_FORMAT;
      }

      /// <summary>
      /// Initializes view.
      /// </summary>
      public void InitializeView(DataTable reservationDT)
      {
         this.reservationDT = reservationDT;
         Reset();
         LoadRangeDefinitions();
      }


      /// <summary>
      /// Finds the series containing the specified name.
      /// </summary>
      /// <param name="namePart">The namePart.</param>
      public void FindSeries(string namePart)
      {
         if (LoadSeries != null)
         {
            LoadSeriesEventArgs args = new LoadSeriesEventArgs();
            args.SeriesNamePart = namePart;
            LoadSeries(this, args);
         }
      }

      /// <summary>
      /// Opens the AddDBObjectDialog.
      /// </summary>
      internal void OpenDBDialog()
      {
         rangeControl.DBOptionsDialog.ShowDialog();
         
         rangeControl.SqlQueryText = rangeControl.DBOptionsDialog.DBQuery;
         rangeControl.SequenceNameText = rangeControl.DBOptionsDialog.DBSequence;
         rangeControl.ConnectionStringText = rangeControl.DBOptionsDialog.EncryptedConnectionString;
      }


      /// <summary>
      /// Resets this instance.
      /// </summary>
      public void Reset()
      {
         rangeControl.EditMode = false;
         rangeControl.DBOptionsDialog.Reset();
         rangeControl.DesktopPanel.Controls.Clear();
         rangeControl.Day = false;
         rangeControl.Month = false;
         rangeControl.Year = false;
         rangeControl.Never = true;
         rangeControl.ExampleLabel.Text = string.Empty;
         rangeControl.RangeName = string.Empty;
         rangeControl.RangeStart = 1;
         rangeControl.ClearDataSource();
         rangeControl.SequenceNameText = string.Empty;
         rangeControl.SqlQueryText = string.Empty;
         rangeControl.ConnectionStringText = string.Empty;
         range = new SeriesDefinition(reservationDT.Clone());
      }

      internal void RefreshTemplateBuilder()
      {
         rangeControl.DesktopPanel.Controls.Clear();
         rangeControl.ExampleLabel.Text = string.Empty;
      }

      public void OnTestConnection(object sender, TestConnectionEventArgs e)
      {
         if (TestConnection != null)
         {
            TestConnection(sender, e);
         }
      }

      /// <summary>
      /// Loads range definition.
      /// </summary>
      /// <param name="p"></param>
      private void LoadRangeDefinitions()
      {
         if (range == null) return;

         rangeControl.RangeName = range.Name;
         rangeControl.RangeStart = (long)(range.Start ?? 1);
         rangeControl.DBOptionsDialog.DBQueryRaw = range.DBQuery;
         rangeControl.DBOptionsDialog.EncryptedConnectionString = range.DBConnection;
         rangeControl.DBOptionsDialog.DBSequence = range.DBSequence;

         rangeControl.ConnectionStringText = range.DBConnection;
         rangeControl.SequenceNameText = range.DBSequence;
         rangeControl.SqlQueryText = range.DBQuery;

         range.ReservationsDT.ColumnChanged -= ReservationsDT_ColumnChanged;
         range.ReservationsDT.ColumnChanged += ReservationsDT_ColumnChanged;
         
         rangeControl.ReservationDataSource = range.ReservationsDT;

         decimal resetTypeId = range.ResetTypeId;
         if (resetTypeId > 0)
         {
            if (resetTypeId == (int)SeriesResetType.Day)
               rangeControl.Day = true;
            if (resetTypeId == (int)SeriesResetType.Week)
               rangeControl.Week = true;
            else if (resetTypeId == (int)SeriesResetType.Month)
               rangeControl.Month = true;
            else if (resetTypeId == (int)SeriesResetType.Year)
               rangeControl.Year = true;
         }

         rangeControl.DesktopPanel.Controls.Clear();

         if (range.Parts != null)
         {
            foreach (SeriesDefinition.Part part in range.Parts)
            {
               if (part.Text != null)
               {
                  AddTemplateTextBox(part.Text);
                  continue;
               }
               if (part.Date != null)
               {
                  AddTemplateComboBox(part.Date, GetFilterType(part.Date));
                  continue;
               }
               if (part.Sequence != null)
               {
                  AddTemplateComboBox(part.Sequence, FilterType.Sequence);
                  continue;
               }
            }
         }

         ConstructExample();
      }

      private FilterType GetFilterType(string dateFormat)
      {
         switch (dateFormat)
         {
            case "yyyy":
            case "yy":
               return FilterType.Year;
            
            case "MMMM":
            case "MMM":
            case "MM":
               return FilterType.Month;

            case "dddd":
            case "ddd":
            case "dd":
               return FilterType.Day;

            case "WW":
            case "W":
               return FilterType.Week;
         }

         return FilterType.None;
      }

      /// <summary>
      /// Handles the ColumnChanged event of the ReservationsDT table.
      /// </summary>
      /// <param name="sender">The source of the event.</param>
      /// <param name="e">The <see cref="System.Data.DataColumnChangeEventArgs"/> instance containing the event data.</param>
      void ReservationsDT_ColumnChanged(object sender, DataColumnChangeEventArgs e)
      {
         if (e.Row.RowState != DataRowState.Detached) return;

         range.ReservationsDT.ColumnChanged -= ReservationsDT_ColumnChanged;
         try
         {
            if (ReservationRowChanged != null)
            {

               ReservationRowChangedEventArgs args = new ReservationRowChangedEventArgs(e);
               args.Series = range;

               ReservationRowChanged(sender, args);

               if (args.Cancel)
               {
                  e.Row.RejectChanges();
               }
            }
         }
         finally
         {
            range.ReservationsDT.ColumnChanged += ReservationsDT_ColumnChanged;
         }
      }

      /// <summary>
      /// Resturns values templates which are not in use.
      /// </summary>
      /// <returns></returns>
      private object[] GetAvailableValues(FilterType key)
      {
         List<string> vals = new List<string>();
         switch (key)
         {
            case FilterType.Sequence:
               vals.Add("#");
               break;
            case FilterType.Year:
               vals.AddRange(new[] {"YYYY", "YY"});
               break;
            case FilterType.Month:
               vals.AddRange(new[] { "NAME", "MMM", "MM" });
               break;
            case FilterType.Week:
               vals.AddRange(new[] { "WW", "W" });
               break;
            case FilterType.Day:
               vals.AddRange(new[] { "NAME", "DDD", "DD", "D" });
               break;
         }
         /*
         List<string> vals = new List<string>();
         vals.Add(SEQUENCE_FORMAT);
         vals.AddRange(dateValues);

         string value = string.Empty;

         foreach (Control ctl in rangeControl.DesktopPanel.Controls)
         {
            if (!(ctl is ComboBox)) continue;

            value = GetFilterPattern(ctl);
            if (string.IsNullOrEmpty(value)) continue;

            for (int k = vals.Count - 1; k > -1; k--)
            {
               if (vals[k].StartsWith(value.Substring(0, 1), true, Thread.CurrentThread.CurrentCulture))
               {
                  vals.RemoveAt(k);
               }
            }
         }
         */
         return vals.ToArray();
      }


      /// <summary>
      /// Locks combos.
      /// </summary>
      /// <param name="currentValue"></param>
      /// <returns></returns>
      private void LockCombos()
      {
         foreach (Control ctl in rangeControl.DesktopPanel.Controls)
         {
            if (!(ctl is ComboBox)) continue;

            ctl.Enabled = false;
         }
      }
      #endregion

      #region Range manipulation methods

      /// <summary>
      /// Creates template textbox.
      /// </summary>
      /// <returns></returns>
      public void AddTemplateTextBox()
      {
         rangeControl.DesktopPanel.Controls.Add(CreateFilterTextBox());
      }

      /// <summary>
      /// Creates template textbox.
      /// </summary>
      /// <param name="text">Initial value.</param>
      internal void AddTemplateTextBox(string text)
      {
         rangeControl.DesktopPanel.Controls.Add(CreateFilterTextBox(text));
      }

      /// <summary>
      /// Creates template combobox.
      /// </summary>
      /// <returns></returns>
      internal void AddTemplateComboBox(FilterType key)
      {
         //LockCombos();
         rangeControl.DesktopPanel.Controls.Add(CreateFilterCombo(key));
      }

      /// <summary>
      /// Creates template combobox.
      /// </summary>
      /// <param name="selectedItem">Initial value.</param>
      internal void AddTemplateComboBox(object selectedItem, FilterType key)
      {
         //LockCombos();
         rangeControl.DesktopPanel.Controls.Add(CreateFilterCombo(selectedItem, key));
      }

      /*
      /// <summary>
      /// Removes the last control in working area.
      /// </summary>
      internal void RemoveLastControl()
      {
         int count = rangeControl.DesktopPanel.Controls.Count;
         
         if (count > 0)
         {
            RemoveControlAt(rangeControl.DesktopPanel.Controls.Count - 1);
            count--;
         }

         if (count > 0)
         {
            for (int k = count-1; k > -1; k--)
            {
               if (rangeControl.DesktopPanel.Controls[k] is ComboBox)
               {
                  rangeControl.DesktopPanel.Controls[k].Enabled = true;
                  break;
               }
            }
         }

         ConstructExample();
      }

      /// <summary>
      /// Removes control by index.
      /// </summary>
      /// <param name="ctlIndex"></param>
      internal void RemoveControlAt(int ctlIndex)
      {
         if (ctlIndex > -1 && ctlIndex < rangeControl.DesktopPanel.Controls.Count)
         {
            rangeControl.DesktopPanel.Controls.RemoveAt(ctlIndex);
         }
      }
      */

      internal void RemoveControl(Control control)
      {
         rangeControl.DesktopPanel.Controls.Remove(control);

         UpdateControlsPosition();
         ConstructExample();
      }

      /// <summary>
      /// Clears selection of the example label.
      /// </summary>
      internal void ClearExampleSelection()
      {
         rangeControl.ExampleLabel.DeselectAll();
      }


      internal void AddControl(object data)
      {
         var key = (FilterType)data;

         if (key == FilterType.Text)
         {
            AddTemplateTextBox();
         }
         else
         {
            AddTemplateComboBox(key);
         }
         
         ConstructExample();
      }


      #endregion

      #region Private methods

      /// <summary>
      /// Reaaranges controls on desktop panel.
      /// </summary>
      private void UpdateControlsPosition()
      {
         var ctls = new Control[rangeControl.DesktopPanel.Controls.Count];
         rangeControl.DesktopPanel.Controls.CopyTo(ctls, 0);
         rangeControl.DesktopPanel.Controls.Clear();

         foreach (Control ctl in ctls)
         {
            ctl.Location = GetFilterPosition(ctl.Width);
            rangeControl.DesktopPanel.Controls.Add(ctl);
         }
      }

      /// <summary>
      /// Reaaranges controls on desktop panel.
      /// </summary>
      internal void InsertControlAtPosition(FilterType type, int x, int y)
      {
         Control insCtl = GetControl(type);

         var ctls = new Control[rangeControl.DesktopPanel.Controls.Count];
         rangeControl.DesktopPanel.Controls.CopyTo(ctls, 0);
         rangeControl.DesktopPanel.Controls.Clear();

         int lastCtlXBound = 0;
         int lastCtlYBound = 0;
         bool added = false;

         foreach (Control ctl in ctls)
         {
            if (!added)
            {
               Point location = GetFilterPosition(ctl.Width);
               if (IsAbscissaMatch(x, location.X + ctl.Width, lastCtlXBound) && 
                  IsOrdinateMatch(y, location.Y + ctl.Height, lastCtlYBound))
               {
                  insCtl.Location = location;
                  rangeControl.DesktopPanel.Controls.Add(insCtl);
                  added = true;
               }
            }

            Point location2 = GetFilterPosition(ctl.Width);
            ctl.Location = location2;
            rangeControl.DesktopPanel.Controls.Add(ctl);
            lastCtlXBound = location2.X;
            lastCtlYBound = location2.Y;
         }

         if (! added)
         {
            AddControl(type);
            return;
         }

         ConstructExample();
      }

      private Control GetControl(FilterType type)
      {
         return (type == FilterType.Text) ? CreateFilterTextBox() : CreateFilterCombo(type);
      }

      private bool IsOrdinateMatch(int dropY, int newY, int lastY)
      {
         return (dropY > lastY && dropY < newY);
      }

      private bool IsAbscissaMatch(int dropX, int newX, int lastX)
      {
         if (newX < lastX)
         {
            lastX = 0;
         }
         return (dropX > lastX && dropX < newX);
      }

      /// <summary>
      /// Creates template textbox.
      /// </summary>
      /// <returns></returns>
      private Control CreateFilterTextBox(string text)
      {
         TextBox txt = new TextBox();
         txt.Width = TEMPLATE_WIDTH;
         txt.Location = GetFilterPosition(txt.Width);
         txt.BorderStyle = BorderStyle.FixedSingle;
         txt.Text = text;
         txt.Tag = FilterType.Text;
         txt.TextChanged += Filter_TextChanged;
         txt.Enter += Filter_Enter;
         txt.MouseDown += TextFilter_MouseDown; 
         return txt;
      }

      /// <summary>
      /// Creates the filter TextBox.
      /// </summary>
      /// <returns></returns>
      private Control CreateFilterTextBox()
      {
         return CreateFilterTextBox(string.Empty);
      }

      /// <summary>
      /// Creates template combobox.
      /// </summary>
      /// <returns></returns>
      private Control CreateFilterCombo(object selectedItem, FilterType key)
      {
         ComboBox combo = new ComboBox();
         combo.Items.AddRange(GetAvailableValues(key));
         combo.Width = TEMPLATE_WIDTH;
         combo.Location = GetFilterPosition(combo.Width);
         if (selectedItem == null)
         {
            combo.SelectedIndex = 0;
         }
         else
         {
            combo.SelectedItem = selectedItem;
         }
         combo.SelectedIndexChanged += Filter_SelectedIndexChanged;
         combo.Enter += Filter_Enter;
         combo.MouseDown += ComboFilter_MouseDown;
         combo.Tag = key;
         return combo;
      }

      /// <summary>
      /// Creates the filter combo.
      /// </summary>
      /// <returns></returns>
      private Control CreateFilterCombo(FilterType key)
      {
         return CreateFilterCombo(null, key);
      }

      /// <summary>
      /// Calculates position for control on desktopPanel.
      /// </summary>
      /// <param name="controlWidth"></param>
      /// <returns></returns>
      private Point GetFilterPosition(int controlWidth)
      {
         Point p = new Point();

         // add first element
         if (rangeControl.DesktopPanel.Controls.Count == 0)
         {
            p.X = 3;
            p.Y = 3;
            return p;
         }

         // add another one element
         Control ctl = rangeControl.DesktopPanel.Controls[rangeControl.DesktopPanel.Controls.Count - 1];
         p = ctl.Location;
         p.Offset(ctl.Width + MARGIN, 0);

         // if out of panel, move to next row
         if (p.X + controlWidth + MARGIN > rangeControl.DesktopPanel.Width)
         {
            p = new Point(MARGIN, ctl.Location.Y + ctl.Height + MARGIN);
         }

         return p;
      }
    
      /// <summary>
      /// Provides default logic to form an example of resulting range template.
      /// </summary>
      private void ConstructExample()
      {
         rangeControl.ExampleLabel.Text = string.Empty;
         string ctlValue = string.Empty;
         int selStart = 0;
         int selLength = 0;
         foreach (Control ctl in rangeControl.DesktopPanel.Controls)
         {
            ctlValue = GetFilterValue(ctl);
            rangeControl.ExampleLabel.Text += ctlValue;
            if (ctl.Focused)
            {
               selStart = rangeControl.ExampleLabel.Text.Length - ctlValue.Length;
               selLength = ctlValue.Length;
            }
         }

         rangeControl.ExampleLabel.SelectionStart = selStart;
         rangeControl.ExampleLabel.SelectionLength = selLength;
         rangeControl.ExampleLabel.SelectionColor = Color.Red;
      }

      /// <summary>
      /// Returns pattern.
      /// </summary>
      /// <param name="ctl"></param>
      /// <returns></returns>
      private string GetFilterPattern(Control ctl)
      {
         if (ctl is TextBox)
         {
            return ctl.Text;
         }

         if (ctl is ComboBox)
         {
            var combo = ctl as ComboBox;
            var comboType = (FilterType)ctl.Tag;

            if (combo.SelectedItem == null)
            {
               return string.Empty;
            }

            if (comboType == FilterType.Sequence)
            {
               return SEQUENCE_FORMAT;
            }
            if (comboType == FilterType.Week)
            {
               return combo.SelectedItem.ToString();
            }
            
            // different parts of date goes here
            return FilterValue2DateFormat(combo.SelectedItem.ToString(), comboType);
         }

         return string.Empty;
      }

      /// <summary>
      /// Provides default logic to get values from template controls.
      /// </summary>
      /// <param name="ctl"></param>
      /// <returns></returns>
      private string GetFilterValue(Control ctl)
      {
         if (ctl is TextBox)
         {
            return ctl.Text;
         }

         if (ctl is ComboBox)
         {
            ComboBox combo = ctl as ComboBox;
            FilterType comboType = (FilterType) combo.Tag;

            if (combo.SelectedItem == null)
            {
               return string.Empty;
            }

            switch (comboType)
            {
               case FilterType.Sequence:
                  return rangeControl.RangeStart.ToString();
               case FilterType.Week:
                  return SeriesGenerator.GetWeekNumber(DateTime.Today, FilterValue2DateFormat(combo.SelectedItem.ToString(), comboType));
               default:
                  return DateTime.Now.ToString(FilterValue2DateFormat(combo.SelectedItem.ToString(), comboType));
            }
         }

         return string.Empty;
      }


      /// <summary>
      /// Converts combobox label to valid date format.
      /// </summary>
      /// <param name="userFormat"></param>
      /// <param name="comboType"></param>
      /// <returns></returns>
      private string FilterValue2DateFormat(string userFormat, FilterType comboType)
      {
         if (comboType == FilterType.Year)
         {
            return userFormat.ToLower();
         }

         if (comboType == FilterType.Month)
         {
            // month goes in upper case
            return (userFormat.ToUpper() == "NAME") ? "MMMM" : userFormat.ToUpper();
         }

         if (comboType == FilterType.Week)
         {
            return (userFormat.Length == 2) ? "00" : "0";
         }

         if (comboType == FilterType.Day)
         {
            return (userFormat.ToUpper() == "NAME") ? "dddd" : userFormat.ToLower();
         }

         return string.Empty;
      }

      #endregion

      #region Event handlers

      /// <summary>
      /// Handles the Enter event of the Filter control.
      /// </summary>
      /// <param name="sender">The source of the event.</param>
      /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
      private void Filter_Enter(object sender, EventArgs e)
      {
         // when enters by Tab the focus is not yet set
         ((Control)sender).Focus();

         ConstructExample();
      }

      void TextFilter_MouseDown(object sender, MouseEventArgs e)
      {
         if (e.Button == MouseButtons.Left)
         {
            ((Control) sender).DoDragDrop(sender, DragDropEffects.Copy);
         }
      }

      void ComboFilter_MouseDown(object sender, MouseEventArgs e)
      {
         var combo = sender as ComboBox;
         
         if (e.Button == MouseButtons.Left && !combo.DroppedDown)
         {
            combo.DoDragDrop(sender, DragDropEffects.Copy);
         }
      }

      /// <summary>
      /// Handles the SelectedIndexChanged event of the Filter control.
      /// </summary>
      /// <param name="sender">The source of the event.</param>
      /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
      private void Filter_SelectedIndexChanged(object sender, EventArgs e)
      {
         ConstructExample();
      }

      /// <summary>
      /// Handles the TextChanged event of the Filter control.
      /// </summary>
      /// <param name="sender">The source of the event.</param>
      /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
      private void Filter_TextChanged(object sender, EventArgs e)
      {
         ConstructExample();
      }

      #endregion

      #region Events

      /// <summary>
      /// Occurs on connection test request.
      /// </summary>
      public event EventHandler<ReservationRowChangedEventArgs> ReservationRowChanged;

      /// <summary>
      /// Occurs on connection test request.
      /// </summary>
      public event EventHandler<TestConnectionEventArgs> TestConnection;

      /// <summary>
      /// Notifies when Range info is ready to be saved.
      /// </summary>
      public event EventHandler<LoadSeriesEventArgs> LoadSeries;

      #endregion

      #region Enums
      
      internal enum FilterType
      {
         None,
         Text,
         Year,
         Month,
         Week,
         Day,
         Sequence
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
