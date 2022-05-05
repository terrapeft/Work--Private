#region Copyright (C) 1994-2009, Johnson & Johnson PRD, LLC.
//---------------------------------------------------------------------------*
//
//    SeriesTemplateEditor.cs: Class to create Label Series templates.
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
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using Jnj.ThirdDimension.Data.BarcodeSeries;
using Jnj.ThirdDimension.BusinessLayer.BarcodeSeries;
using Jnj.ThirdDimension.Utils.BarcodeSeries;

namespace Jnj.ThirdDimension.Controls.BarcodeSeries
{
   /// <summary>
   /// Class to create Label Series templates.
   /// </summary>
   public partial class SeriesTemplateEditor : UserControl
   {
      #region Declarations

      protected int MARGIN = 3;   // Margin for controls within the desktop panel.
      protected int TEMPLATE_WIDTH = 100;   // Width of controls in the desktop panel.

      private bool editMode;

      #endregion


      public SeriesTemplateEditor()
      {
         InitializeComponent();

         textDragLabel.Tag = new DragData(textDragLabel, PartType.Text);
         seriesDragLabel.Tag = new DragData(seriesDragLabel, PartType.Sequence);
         yearDragLabel.Tag = new DragData(yearDragLabel, PartType.Year);
         monthDragLabel.Tag = new DragData(monthDragLabel, PartType.Month);
         weekDragLabel.Tag = new DragData(weekDragLabel, PartType.Week);
         dayDragLabel.Tag = new DragData(dayDragLabel, PartType.Day);

         RangeStart = 1;
      }


      #region Public properties

      public int RangeStart { get; set; }

      /// <summary>
      /// Locks some controls in edit mode.
      /// </summary>
      public bool EditMode
      {
         get { return editMode; }
         set
         {
            editMode = value;

            desktopPanel.Enabled = !value;
            refreshButton.Enabled = !value;
            toolPanel.Enabled = !value;
         }
      }

      /// <summary>
      /// Accessor for main working area for filter creation.
      /// </summary>
      public Panel DesktopPanel { get { return desktopPanel; } }

      /// <summary>
      /// Accessor for label displaying a barcode example.
      /// </summary>
      public RichTextBox ExampleLabel { get { return exampleRichTextBox; } }

      #endregion


      #region Public methods

      /// <summary>
      /// Resturns values templates which are not in use.
      /// </summary>
      /// <returns></returns>
      public object[] GetAvailableValues(PartType key)
      {
         List<string> vals = new List<string>();
         switch (key)
         {
            //case PartType.Sequence:
            //   vals.Add("#");
            //   break;
            case PartType.Year:
               vals.AddRange(new[] { "YYYY", "YY" });
               break;
            case PartType.Month:
               vals.AddRange(new[] { "NAME", "MMM", "MM" });
               break;
            case PartType.Week:
               vals.AddRange(new[] { "WW", "W" });
               break;
            case PartType.Day:
               vals.AddRange(new[] { "NAME", "DDD", "DD", "D" });
               break;
         }
         return vals.ToArray();
      }

      public string GetFilterValue(Control ctl)
      {
         return GetFilterValue(ctl, DateTime.Now, -1);
      }

      /// <summary>
      /// Provides default logic to get values from template controls.
      /// </summary>
      /// <param name="ctl">Control.</param>
      /// <param name="dt">Datetime info.</param>
      /// <param name="seqValue">To use real value, specify negative value as a parameter.</param>
      /// <returns></returns>
      public string GetFilterValue(Control ctl, DateTime dt, int seqValue)
      {
         var type = ((DragData)ctl.Tag).PartType;
         var combo = ctl as ComboBox;

         string value = string.Empty;
         if (combo != null)
         {
            value = (combo.SelectedItem ?? combo.Items[0]).ToString();
         }

         switch (type)
         {
            case PartType.Text:
               return ctl.Text;

            case PartType.Sequence:
               return seqValue < 0 ? RangeStart.ToString(SeriesDefinition.FilterValue2DateFormat(ctl.Text, type)) : "0";

            case PartType.Week:
               return SeriesDefinition.GetWeekNumber(DateTime.Today,
                                                     SeriesDefinition.FilterValue2DateFormat(value, type));
            default:
               return dt.ToString(SeriesDefinition.FilterValue2DateFormat(value, type));
         }
      }

      /// <summary>
      /// Returns pattern.
      /// </summary>
      /// <param name="ctl"></param>
      /// <returns></returns>
      public string GetFilterPattern(Control ctl)
      {
         var type = ((DragData)ctl.Tag).PartType;
         var combo = ctl as ComboBox;
         string value = string.Empty;
         if (combo != null)
         {
            value = (combo.SelectedItem ?? combo.Items[0]).ToString();
         }

         switch (type)
         {
            case PartType.Text:
               return ctl.Text;

            case PartType.Sequence:
               return ctl.Text;

            case PartType.Week:
               return value;

            default:
               return SeriesDefinition.FilterValue2DateFormat(value, type);
         }
      }

      /// <summary>
      /// Provides default logic to form an example of resulting range template.
      /// </summary>
      public string GetFilterRegExp()
      {
         StringBuilder regExp = new StringBuilder("^");
         string ctlValue = string.Empty;
         string ctlPattern = string.Empty;
         int k = 0;

         foreach (Control ctl in desktopPanel.Controls)
         {
            PartType type = ((DragData)ctl.Tag).PartType;
            ctlValue = GetFilterValue(ctl);
            ctlPattern = GetFilterPattern(ctl);
            switch (type)
            {
               case PartType.Text:
                  // any text
                  regExp.AppendFormat("(?<text{0}>{1})", k, ctlValue);

                  break;

               case PartType.Year:
                  // yyyy, yy
                  regExp.AppendFormat(@"(?<year>\d{{{0}}})", ctlPattern.Length);
                  break;

               case PartType.Month:
                  if (ctlPattern.Length == 2)
                  {
                     // 1, 02 ...
                     regExp.Append(@"(?<month>\d{1,2})");
                  }
                  else if (ctlPattern.Length == 3)
                  {
                     // Mar, Apr ...
                     regExp.Append(@"(?<month>\w{3})");
                  }
                  else
                  {
                     // March, April ...
                     regExp.Append(@"(?<month>\w{3,9})");
                  }
                  break;

               case PartType.Day:
                  if (ctlPattern.Length == 2)
                  {
                     // 1, 02 ...
                     regExp.Append(@"(?<day>\d{1,2})");
                  }
                  else if (ctlPattern.Length == 3)
                  {
                     // Mon, Tue ...
                     regExp.Append(@"(?<day>\w{3})");
                  }
                  else
                  {
                     // Monday, Tuesday ...
                     regExp.Append(@"(?<day>\w{3,9})");
                  }
                  break;

               case PartType.Week:
                  // 1, 02 ...
                  regExp.AppendFormat(@"(?<week>\d{{{0}}})", ctlPattern.Length);
                  break;

               case PartType.Sequence:
                  // 1, 02 ...
                  regExp.Append(@"(?<sequence>\d+)");
                  break;
            }

            k++;
         }
         regExp.Append("$");
         return regExp.ToString();
      }

      /// <summary>
      /// Fills the instance of SeriesTemplate with template parts.
      /// </summary>
      /// <returns></returns>
      public SeriesTemplate.Part[] GetTemplate()
      {
         List<SeriesTemplate.Part> parts = new List<SeriesTemplate.Part>();
         
         foreach (Control ctl in desktopPanel.Controls)
         {
            SeriesTemplate.Part part = new SeriesTemplate.Part();

            if (IsSequencePart(ctl))
            {
               part.Sequence = GetFilterPattern(ctl);
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

         return parts.ToArray();
      }


      /// <summary>
      /// Create controls in the working area according to supplied parts.
      /// </summary>
      /// <param name="parts">The parts.</param>
      public void LoadTemplate(SeriesTemplate.Part[] parts)
      {
         desktopPanel.Controls.Clear();
         if (parts != null)
         {
            foreach (SeriesTemplate.Part part in parts)
            {
               if (part.Text != null)
               {
                  AddTemplateTextBox(part.Text, PartType.Text);
                  continue;
               }
               if (part.Date != null)
               {
                  AddTemplateComboBox(SeriesDefinition.FilterDateFormat2Value(part.Date), GetPartType(part.Date));
                  continue;
               }
               if (part.Sequence != null)
               {
                  AddTemplateTextBox(part.Sequence, PartType.Sequence);
                  continue;
               }
            }
         }
      }

      /// <summary>
      /// Provides default logic to form an example of resulting range template.
      /// </summary>
      public void ConstructExample()
      {
         exampleRichTextBox.Text = string.Empty;
         string ctlValue = string.Empty;
         int selStart = 0;
         int selLength = 0;
         foreach (Control ctl in desktopPanel.Controls)
         {
            ctlValue = GetFilterValue(ctl);
            exampleRichTextBox.Text += ctlValue;
            if (ctl.Focused)
            {
               selStart = exampleRichTextBox.Text.Length - ctlValue.Length;
               selLength = ctlValue.Length;
            }
         }

         exampleRichTextBox.SelectionStart = selStart;
         exampleRichTextBox.SelectionLength = selLength;
         exampleRichTextBox.SelectionColor = Color.Red;
      }

      public string CreateTemplateExample()
      {
         string result = string.Empty;
         foreach (Control ctl in DesktopPanel.Controls)
         {
            result += GetFilterValue(ctl, DateTime.Today, -1);
         }
         return result;
      }

      #endregion


      #region Private methods

      /// <summary>
      /// Creates template textbox.
      /// </summary>
      /// <returns></returns>
      private Control AddTemplateTextBox(PartType key)
      {
         var ctl = CreateFilterTextBox(key);
         desktopPanel.Controls.Add(ctl);
         return ctl;
      }

      /// <summary>
      /// Creates template textbox.
      /// </summary>
      /// <param name="text">Initial value.</param>
      private Control AddTemplateTextBox(string text, PartType key)
      {
         var ctl = CreateFilterTextBox(text, key);
         desktopPanel.Controls.Add(ctl);
         return ctl;
      }

      /// <summary>
      /// Creates template combobox.
      /// </summary>
      /// <returns></returns>
      private Control AddTemplateComboBox(PartType key)
      {
         var ctl = CreateFilterCombo(key);
         desktopPanel.Controls.Add(ctl);
         return ctl;
      }

      /// <summary>
      /// Creates template combobox.
      /// </summary>
      /// <param name="selectedItem">Initial value.</param>
      private Control AddTemplateComboBox(object selectedItem, PartType key)
      {
         var ctl = CreateFilterCombo(selectedItem, key);
         desktopPanel.Controls.Add(ctl);
         return ctl;
      }

      private void RemoveControl(Control control)
      {
         desktopPanel.Controls.Remove(control);

         UpdateControlsPosition();
         ConstructExample();
      }

      /// <summary>
      /// Clears selection of the example label.
      /// </summary>
      private void ClearExampleSelection()
      {
         exampleRichTextBox.DeselectAll();
      }


      private void AddControl(DragData dragData)
      {
         var key = dragData.PartType;
         Control ctl;

         if (key == PartType.Text || key == PartType.Sequence)
         {
            ctl = AddTemplateTextBox(key);
         }
         else
         {
            ctl = AddTemplateComboBox(key);
         }

         ((DragData) ctl.Tag).Parked = true;

         ConstructExample();
      }

      /// <summary>
      /// Reaaranges controls on desktop panel.
      /// </summary>
      private void UpdateControlsPosition()
      {
         var ctls = new Control[desktopPanel.Controls.Count];
         desktopPanel.Controls.CopyTo(ctls, 0);
         desktopPanel.Controls.Clear();

         foreach (Control ctl in ctls)
         {
            ctl.Location = GetFilterPosition(ctl.Width);
            desktopPanel.Controls.Add(ctl);
         }
      }

      /// <summary>
      /// Reaaranges controls on desktop panel.
      /// </summary>
      private void InsertControl(DragData dragData, int x, int y)
      {
         List<Control> calculatedPositions = SetNewTemplateOrder(dragData, x, y);
         
         if (OrderChanged(desktopPanel.Controls, calculatedPositions))
         {
            ApplyNewPositions(calculatedPositions);
         }

         ConstructExample();
      }

      /// <summary>
      /// Fills the working area with controls in the calculated collection.
      /// </summary>
      /// <param name="calculatedPositions">The calculated positions.</param>
      private void ApplyNewPositions(List<Control> calculatedPositions)
      {
         desktopPanel.Controls.Clear();
         
         foreach (Control ctl in calculatedPositions)
         {
            Point location = GetFilterPosition(ctl.Width);
            ctl.Location = location;

            ((DragData)ctl.Tag).Parked = true;
            desktopPanel.Controls.Add(ctl);
         }
      }

      /// <summary>
      /// Determines if order of the controls was changed in the calculated collection.
      /// </summary>
      /// <param name="controlCollection">The control collection.</param>
      /// <param name="calculatedPositions">The calculated positions.</param>
      /// <returns></returns>
      private bool OrderChanged(ControlCollection controlCollection, List<Control> calculatedPositions)
      {
         if (controlCollection.Count != calculatedPositions.Count)
            return true;

         for (int k = 0; k < controlCollection.Count; k++)
         {
            Control control1 = controlCollection[k];
            Control control2 = calculatedPositions[k];
            if (control1.Name != control2.Name)
            {
               return true;
            }
         }

         return false;
      }

      /// <summary>
      /// Sorts controls taken into account the last drag-n-drop operation.
      /// </summary>
      /// <param name="dragData">The drag data.</param>
      /// <param name="x">The x.</param>
      /// <param name="y">The y.</param>
      /// <returns></returns>
      private List<Control> SetNewTemplateOrder(DragData dragData, int x, int y)
      {
         List<Control> list = new List<Control>();
         Control insCtl = (dragData.Parked) ? dragData.Control : GetControl(dragData.PartType);
         bool added = false;

         if (desktopPanel.Controls.Count == 0)
         {
            added = true;
            list.Add(insCtl);
            return list;
         }

         for (int k = 0; k < desktopPanel.Controls.Count; k++ )
         {
            Control ctl = desktopPanel.Controls[k];

            if (!added)
            {
               // add the control that was:

               HitTestResult result = ControlHitTest(ctl, x, y);

               if (result == HitTestResult.BullsEye || result == HitTestResult.PreviousLine)
               {
                  // dropped on the other control or on the free right area
                  list.Add(insCtl);
                  added = true;
               }
               else if (k == desktopPanel.Controls.Count - 1)
               {
                  if (result == HitTestResult.OnTheRight || result == HitTestResult.NextLine)
                  {
                     // dropped below all controls
                     if (ctl != insCtl)
                     {
                        list.Add(ctl);
                     }
                     list.Add(insCtl);
                     added = true;
                     break;
                  }
               }
            }

            if (ctl != insCtl)
            {
               // add static controls
               list.Add(ctl);
            }
         }

         return list;
      }

      /// <summary>
      /// Creates a new control of specified type.
      /// </summary>
      /// <param name="type">The type.</param>
      /// <returns></returns>
      private Control GetControl(PartType type)
      {
         return (type == PartType.Text || type == PartType.Sequence) ? CreateFilterTextBox(type) : CreateFilterCombo(type);
      }

      /// <summary>
      /// Creates template textbox.
      /// </summary>
      /// <returns></returns>
      private Control CreateFilterTextBox(string text, PartType key)
      {
         TextBox txt;
         if (key == PartType.Sequence)
         {
            txt = new SequenceFormatTextBox();
         }
         else
         {
            txt = new TextBox();
         }

         txt.Text = text;
         txt.Width = GetControlWidth(txt);
         txt.Location = GetFilterPosition(txt.Width);
         txt.BorderStyle = BorderStyle.FixedSingle;
         txt.Tag = new DragData(txt, key);
         txt.TextChanged += Filter_TextChanged;
         txt.Enter += Filter_Enter;
         txt.SizeChanged += Filter_SizeChanged;
         txt.MouseDown += TextFilter_MouseDown;
         txt.Name = Guid.NewGuid().ToString();
         //txt.MouseMove += txt_MouseMove;
         return txt;
      }

      private int GetControlWidth(Control ctl)
      {
         Graphics g = Graphics.FromHwnd(IntPtr.Zero);
         int size = g.MeasureString(ctl.Text + "_", ctl.Font).ToSize().Width;
         return size < 25 ? 25 : size;
      }

      /// <summary>
      /// Creates the filter TextBox.
      /// </summary>
      /// <returns></returns>
      private Control CreateFilterTextBox(PartType key)
      {
         return CreateFilterTextBox(string.Empty, key);
      }

      /// <summary>
      /// Creates template combobox.
      /// </summary>
      /// <returns></returns>
      private Control CreateFilterCombo(object selectedItem, PartType key)
      {
         ComboBox combo = new ComboBox();
         
         // requires this style to enable dragging
         combo.DropDownStyle = ComboBoxStyle.DropDown;
         combo.AutoCompleteMode = AutoCompleteMode.Suggest;
         combo.Items.AddRange(GetAvailableValues(key));
         combo.Width = TEMPLATE_WIDTH;
         combo.Location = GetFilterPosition(combo.Width);
         if (selectedItem == null)
         {
            combo.SelectedIndex = 0;
         }
         else
         {
            combo.SelectedItem = selectedItem.ToString().ToUpper();
         }
         combo.SelectedIndexChanged += Filter_SelectedIndexChanged;
         combo.Enter += Filter_Enter;
         combo.MouseDown += ComboFilter_MouseDown;
         //combo.MouseMove += combo_MouseMove;
         combo.Tag = new DragData(combo, key);
         combo.Name = Guid.NewGuid().ToString();
         return combo;
      }

      /// <summary>
      /// Creates the filter combo.
      /// </summary>
      /// <returns></returns>
      private Control CreateFilterCombo(PartType key)
      {
         return CreateFilterCombo(null, key);
      }

      /// <summary>
      /// Tests how the specified point relates to the specified control.
      /// </summary>
      /// <param name="ctl"></param>
      /// <param name="x"></param>
      /// <param name="y"></param>
      /// <returns></returns>
      private HitTestResult ControlHitTest(Control ctl, int x, int y)
      {
         if (y > (ctl.Location.Y + ctl.Height)) return HitTestResult.NextLine;
         if (y < (ctl.Location.Y - MARGIN)) return HitTestResult.PreviousLine;
         if (x < (ctl.Location.X - MARGIN)) return HitTestResult.OnTheLeft;
         if (x > ctl.Location.X + ctl.Width) return HitTestResult.OnTheRight;
         
         return HitTestResult.BullsEye;
      }


      private enum HitTestResult
      {
         OnTheLeft,
         OnTheRight,
         NextLine,
         PreviousLine,
         BullsEye
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
         if (desktopPanel.Controls.Count == 0)
         {
            p.X = MARGIN;
            p.Y = MARGIN;
            return p;
         }

         // add another one element
         Control ctl = desktopPanel.Controls[desktopPanel.Controls.Count - 1];
         p = ctl.Location;
         p.Offset(ctl.Width + MARGIN, 0);

         // if out of panel, move to next row
         if (p.X + controlWidth + MARGIN > desktopPanel.Width)
         {
            p = new Point(MARGIN, ctl.Location.Y + ctl.Height + MARGIN);
         }

         return p;
      }

      private void RefreshTemplateBuilder()
      {
         desktopPanel.Controls.Clear();
         exampleRichTextBox.Text = string.Empty;
      }

      /// <summary>
      /// Checks if the control contains date definition
      /// </summary>
      /// <param name="ctl"></param>
      /// <returns></returns>
      private bool IsDatePart(Control ctl)
      {
         DragData dd = ctl.Tag as DragData;
         if (dd == null) return false;

         return (
                   (dd.PartType == PartType.Day) ||
                   (dd.PartType == PartType.Week) ||
                   (dd.PartType == PartType.Month) ||
                   (dd.PartType == PartType.Year)
                );
      }

      /// <summary>
      /// Checks if the control contains sequence definition
      /// </summary>
      /// <param name="ctl"></param>
      /// <returns></returns>
      private bool IsSequencePart(Control ctl)
      {
         DragData dd = ctl.Tag as DragData;
         if (dd == null) return false;

         return (dd.PartType == PartType.Sequence);
      }

      private PartType GetPartType(string dateFormat)
      {
         switch (dateFormat)
         {
            case "yyyy":
            case "yy":
               return PartType.Year;

            case "MMMM":
            case "MMM":
            case "MM":
               return PartType.Month;

            case "dddd":
            case "ddd":
            case "dd":
               return PartType.Day;

            case "WW":
            case "W":
               return PartType.Week;
         }

         return PartType.None;
      }

      #endregion


      #region Drag And Drop

      private void desktopPanel_DragEnter(object sender, DragEventArgs e)
      {
         try
         {
            if (e.Data.GetDataPresent(typeof (DragData)))
            {
               e.Effect = DragDropEffects.Copy;
            }
         }
         catch(Exception ex)
         {
            MessagesHelper.ReportError(ex, true);
         }
      }

      private void desktopPanel_DragDrop(object sender, DragEventArgs e)
      {
         try
         {
            if (e.Data.GetDataPresent(typeof (DragData)))
            {
               Point local = desktopPanel.PointToClient(new Point(e.X, e.Y));
               var dd = (DragData) e.Data.GetData(typeof (DragData));
               InsertControl(dd, local.X, local.Y);
               
            }
         }
         catch (Exception ex)
         {
            MessagesHelper.ReportError(ex, true);
         }
      }

      private void dragLabel_DoubleClick(object sender, EventArgs e)
      {
         try
         {
            var dd = (DragData)((Control)sender).Tag;
            AddControl(dd);
         }
         catch (Exception ex)
         {
            MessagesHelper.ReportError(ex, true);
         }
      }

      private void desktopOuterPanel_DragDrop(object sender, DragEventArgs e)
      {
         try
         {
            desktopOuterPanel.BackColor = SystemColors.Control;
            basketImage.Visible = false;

            if (e.Data.GetDataPresent(typeof (DragData)))
            {
               var dd = (DragData) e.Data.GetData(typeof (DragData));
               RemoveControl(dd.Control);
            }
         }
         catch (Exception ex)
         {
            MessagesHelper.ReportError(ex, true);
         }
      }

      private void desktopOuterPanel_DragEnter(object sender, DragEventArgs e)
      {
         try
         {
            basketImage.Visible = true;
            desktopOuterPanel.BackColor = SystemColors.ControlLight;

            if (e.Data.GetDataPresent(typeof (DragData)))
            {
               e.Effect = DragDropEffects.Copy;
            }
            else
            {
               e.Effect = DragDropEffects.None;
            }
         }
         catch (Exception ex)
         {
            MessagesHelper.ReportError(ex, true);
         }
      }

      private void desktopOuterPanel_DragLeave(object sender, EventArgs e)
      {
         basketImage.Visible = false;
         desktopOuterPanel.BackColor = SystemColors.Control;
      }

      #endregion


      #region UI events handling

      private void refreshButton_Click(object sender, EventArgs e)
      {
         try
         {
            RefreshTemplateBuilder();
         }
         catch (Exception ex)
         {
            MessagesHelper.ReportError(ex, true);
         }
      }

      private void exampleRichTextBox_Enter(object sender, EventArgs e)
      {
         try
         {
            ClearExampleSelection();
         }
         catch (Exception ex)
         {
            MessagesHelper.ReportError(ex, true);
         }
      }

      /// <summary>
      /// Handles the Enter event of the Filter control.
      /// </summary>
      /// <param name="sender">The source of the event.</param>
      /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
      private void Filter_Enter(object sender, EventArgs e)
      {
         try
         {
            // when enters by Tab the focus is not yet set
            SetFocus((Control) sender);

            ConstructExample();
         }
         catch (Exception ex)
         {
            MessagesHelper.ReportError(ex, true);
         }
      }

      private void SetFocus(Control control)
      {
         control.Enter -= Filter_Enter;
         control.Focus();
         control.Enter += Filter_Enter;
      }

      void txt_MouseMove(object sender, MouseEventArgs e)
      {
         if (e.Button == MouseButtons.Left)
         {
            TextFilter_MouseDown(sender, e);
         }
      }

      void TextFilter_MouseDown(object sender, MouseEventArgs e)
      {
         try
         {
            if (e.Button == MouseButtons.Left)
            {
               Control ctl = (Control) sender;
               ctl.DoDragDrop(ctl.Tag, DragDropEffects.Copy);
            }
         }
         catch (Exception ex)
         {
            MessagesHelper.ReportError(ex, true);
         }
      }

      void combo_MouseMove(object sender, MouseEventArgs e)
      {
         if (e.Button == MouseButtons.Left)
         {
            ComboFilter_MouseDown(sender, e);
         }
      }

      void ComboFilter_MouseDown(object sender, MouseEventArgs e)
      {
         try
         {
            var combo = sender as ComboBox;

            if (e.Button == MouseButtons.Left && !combo.DroppedDown)
            {
               combo.DoDragDrop(combo.Tag, DragDropEffects.Copy);
            }
         }
         catch (Exception ex)
         {
            MessagesHelper.ReportError(ex, true);
         }
      }

      /// <summary>
      /// Handles the SelectedIndexChanged event of the Filter control.
      /// </summary>
      /// <param name="sender">The source of the event.</param>
      /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
      private void Filter_SelectedIndexChanged(object sender, EventArgs e)
      {
         try
         {
            ConstructExample();
         }
         catch (Exception ex)
         {
            MessagesHelper.ReportError(ex, true);
         }
      }

      /// <summary>
      /// Handles the TextChanged event of the Filter control.
      /// </summary>
      /// <param name="sender">The source of the event.</param>
      /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
      private void Filter_TextChanged(object sender, EventArgs e)
      {
         try
         {
            if (sender is TextBox)
            {
               Control txt = sender as TextBox;
               txt.Width = GetControlWidth(txt);
               SetFocus(txt);
            }
            ConstructExample();
         }
         catch (Exception ex)
         {
            MessagesHelper.ReportError(ex, true);
         }
      }

      void Filter_SizeChanged(object sender, EventArgs e)
      {
         try
         {
            UpdateControlsPosition();
         }
         catch (Exception ex)
         {
            MessagesHelper.ReportError(ex, true);
         }
      }

      #endregion

   }

   /// <summary>
   /// Contains information about dragging control.
   /// </summary>
   internal class DragData
   {
      public DragData(Control ctl, PartType type)
      {
         this.Control = ctl;
         this.PartType = type;
      }

      public DragData(Control ctl, PartType type, bool parked)
      {
         this.Control = ctl;
         this.PartType = type;
      }

      /// <summary>
      /// Contains the control which owns the DragData instance.
      /// </summary>
      public Control Control { get; set; }

      /// <summary>
      /// Type of the control.
      /// </summary>
      public PartType PartType { get; set; }

      /// <summary>
      /// True if the control is already on the panel, and false if is newly created.
      /// </summary>
      public bool Parked { get; set; }
   }
}
