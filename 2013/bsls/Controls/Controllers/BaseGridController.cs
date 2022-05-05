#region Copyright (C) 1994-2009, Johnson & Johnson PRD, LLC.
//---------------------------------------------------------------------------*
//
//    BaseGridController.cs: Base controller for all controllers.
//
//---
//
//    Copyright (C) 1994-2009, Johnson & Johnson PRD, LLC.
//    All Rights Reserved.
//
//    Vitaly Chupaev, 12/2009
//
//---------------------------------------------------------------------------*/
#endregion
using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using Jnj.Windows.Forms;
using Syncfusion.Windows.Forms.Grid;
using System.Windows.Forms;
using System.Drawing;
using Jnj.ThirdDimension.Base;
using System.ComponentModel;
using Syncfusion.Windows.Forms.Tools;
using Jnj.ThirdDimension.Data.BarcodeSeries;

namespace Jnj.ThirdDimension.Controls.BarcodeSeries
{
   /// <summary>
   /// Colelction of controllers, to perform common operations.
   /// </summary>
   public class Controllers
   {
      private static List<IController> controllers = new List<IController>();
      
      /// <summary>
      /// Adds controller to collection.
      /// </summary>
      /// <param name="controller"></param>
      internal static void AddController(IController controller)
      {
         controllers.Add(controller);
      }

      /// <summary>
      /// Calls Reset method of each controller.
      /// </summary>
      public static void Reset()
      {
         foreach (IController controller in controllers)
         {
            controller.Reset();
         }
      }
   }

   /// <summary>
   /// Base abstract class for COATS controllers. Contains some base functionality.
   /// </summary>
   /// <typeparam name="T"></typeparam>
   public abstract class BaseGridController<T> : IController where T : DataTable
   {
      private IGridDataBoundGridValidator inputValidator;   // user input validator
      private IGridDataBoundGridValidator submitValidator;   // submission validator

      protected bool trackChangesOnly = false;   // tells no to proccess user input, but do changes tracking only
      protected T dataSource;   // source data table
      protected SimpleGrid grid;   // grid
      protected GridRecordNavigationControl navigator;   // grid navigational control
      //protected CLDataSet.PersonRightsRow user;   // current user
      protected SeriesDataLayer dataLayer;   // data layer instance
      protected IWizardControlView view;   // UserControl, which uses this controller

      /// <summary>
      /// Initializes a new instance of the <see cref="BaseGridController&lt;T&gt;"/> class.
      /// </summary>
      /// <param name="view"></param>
      /// <param name="sourceDT"></param>
      /// <param name="navigator"></param>
      /// <param name="dataLayer"></param>
      /// <param name="user"></param>
      public BaseGridController(IWizardControlView view, T sourceDT, GridRecordNavigationControl navigator)
         : this(view, sourceDT, (SimpleGrid)navigator.GridControl)
      {
         this.navigator = navigator;
         navigator.CurrentRecordChanged += OnCurrentRecordChanged;
      }

      /// <summary>
      /// Initializes a new instance of the <see cref="BaseGridController&lt;T&gt;"/> class.
      /// </summary>
      /// <param name="view"></param>
      /// <param name="sourceDT"></param>
      /// <param name="grid"></param>
      /// <param name="dataLayer"></param>
      /// <param name="user"></param>
      public BaseGridController(IWizardControlView view, T sourceDT, SimpleGrid grid)
      {
         this.dataSource = sourceDT;
         this.grid = grid;
         this.view = view;
         dataLayer = view.DataLayer;
         Controllers.AddController(this);
      }

      protected BaseGridController()
      {
         
      }

      protected virtual void InitializeEditor()
      {
         WireDTCells();

         grid.DataSource = dataSource;
      }

     
      /// <summary>
      /// Validates against default values
      /// </summary>
      public IGridDataBoundGridValidator SubmitValidator
      {
         get
         {
            if (submitValidator == null)
            {
               submitValidator = GridDataBoundGridValidator.CreateGridDataBoundGridValidator();
               CreateSubmitValidationRules(submitValidator);
            }
            return submitValidator;
         }
      }

      /// <summary>
      /// Validates against default values
      /// </summary>
      public IGridDataBoundGridValidator InputValidator
      {
         get
         {
            if (inputValidator == null)
            {
               inputValidator = GridDataBoundGridValidator.CreateGridDataBoundGridValidator();
               CreateInputValidationRules(inputValidator);
            }
            return inputValidator;
         }
      }

      #region Abstract methods

      // stands for toolbar buttons on the wizard
      public abstract void Submit();
      public abstract void Reset();
      public abstract void Import();
      public abstract void Export();
      public abstract void Print();

      // protected methods for internall use
      protected abstract void TrackChanges(DataColumnChangeEventArgs e);
      protected abstract void InitializeColumns();
      protected abstract void HandleAutoChangeEvent(AutoChangeColumnValueEventArgs e);
      protected abstract void CreateSubmitValidationRules(IGridDataBoundGridValidator submitValidator);
      protected abstract void CreateInputValidationRules(IGridDataBoundGridValidator inputValidator);
      protected abstract string GetCurrentViewNameForExport();
      protected abstract void ColumnChanged(DataColumnChangeEventArgs e);
      protected abstract void OnClipboardPaste(object sender, GridCutPasteEventArgs e);

      #endregion

      #region Private methods

      private bool working = false;

      /// <summary>
      /// Enables ColumnChanged event of source table.
      /// </summary>
      /// <param name="p"></param>
      protected void WireDTCells()
      {
         working = false;
         dataSource.ColumnChanged -= OnColumnChanged;
         dataSource.ColumnChanged += OnColumnChanged;
      }

      /// <summary>
      /// Disables ColumnChanged event of source table.
      /// </summary>
      /// <param name="p"></param>
      protected void UnwireDTCells()
      {
         working = true;
         dataSource.ColumnChanged -= OnColumnChanged;
      }

      /// <summary>
      /// Marks cells which do not pass validation with red
      /// </summary>
      /// <param name="e"></param>
      private void MarkInvalidCells(GridQueryCellInfoEventArgs e)
      {
         Color errorColor = Color.FromArgb(255, 170, 170);

         InvalidCell cell = null;

         if (e.Style.BackColor == errorColor)
         {
            e.Style.BackColor = Color.White;
            e.Style.CellTipText = string.Empty;
         }

         if (inputValidator.InvalidCells.Count > -1)
         {
            cell = inputValidator.InvalidCells[e.RowIndex, e.ColIndex];
         }
         if (cell == null && SubmitValidator.InvalidCells.Count > 0)
         {
            cell = SubmitValidator.InvalidCells[e.RowIndex, e.ColIndex];
         }

         if (cell != null)
         {
            e.Style.BackColor = Color.FromArgb(255, 170, 170);
            e.Style.CellTipText = cell.Text;
         }
      }

      #endregion

      #region Virtual methods, protected methods, common UI event handlers

      /// <summary>
      /// Returns arguments for exporting visible grid data to 3DX table
      /// </summary>
      /// <returns></returns>
      protected BaseWizardControl.TdxExportEventArgs GetExportArguments()
      {
         BaseWizardControl.TdxExportEventArgs args = new BaseWizardControl.TdxExportEventArgs
         {
            GridColumns = grid.Binder.InternalColumns,
            SourceTable = dataSource,
            TdxViewName = GetCurrentViewNameForExport()
         };

         return args;
      }

      /// <summary>
      /// Checks if the row is filled by its index. If index in a set of existed rows, the row considered as filled
      /// </summary>
      /// <param name="rowIndex"></param>
      /// <returns></returns>
      private bool IsCurrentRowFilled(int rowIndex)
      {
         return dataSource.Rows.Count >= rowIndex;
      }

      protected virtual void OnCurrentRecordChanged(object sender, Syncfusion.Windows.Forms.CurrentRecordEventArgs e)
      {
         if (navigator != null)
         {
            if (navigator.CurrentRecord > navigator.MaxRecord)
            {
               navigator.MaxLabel = "*";
            }
            else
            {
               navigator.Label = (navigator.GridControl.Model.RowCount > 999) ? "Rec." : "Record";
               navigator.MaxLabel = "of " + (navigator.GridControl.Model.RowCount - ((navigator.AllowAddNew) ? 1 : 0));
            }
         }
      }

      /// <summary>
      /// Handles the column event.
      /// </summary>
      /// <param name="sender">The sender.</param>
      /// <param name="e">The <see cref="System.Data.DataColumnChangeEventArgs"/> instance containing the event data.</param>
      protected void OnColumnChanged(object sender, DataColumnChangeEventArgs e)
      {
         if (working || !IsEditing(e)) return;

         UnwireDTCells();

         if (!trackChangesOnly)
         {
            grid.SuspendLayout();
            grid.BeginUpdate();

            using (dataLayer.Connect())
            {
               ColumnChanged(e);
            }

            grid.EndUpdate();
            grid.ResumeLayout();
            grid.Refresh();
         }

         TrackChanges(e);

         WireDTCells();
      }


      protected virtual void OnCurrentCellValidating(object sender, System.ComponentModel.CancelEventArgs e)
      {}

      protected virtual void OnQueryCellInfo(object sender, GridQueryCellInfoEventArgs e)
      {
         DataRow row = GetRow(e.RowIndex);
         if (row != null && row.RowState != DataRowState.Detached)
         {
            //MarkInvalidCells(e);
            e.Handled = true;
         }
      }

      protected virtual void OnSelectionChanging(object sender, GridSelectionChangingEventArgs e)
      {
         if (e.ClickRange.IsCells)
         {
            e.Cancel = true;
         }
      }

      #endregion

      #region Utils

      /// <summary>
      /// Selects all rows in the grid.
      /// </summary>
      public void SelectGrid()
      {
         bool hasOneRow = (grid.Model.RowCount == 1);
         int top = hasOneRow ? 0 : 1;
         int bottom = hasOneRow ? 1 : grid.Model.RowCount - 1;

         // selects row range, only row range allows to edit several selected rows at once
         grid.Selections.SelectRange(GridRangeInfo.Auto(top, -1, bottom, -1), true);
      }

      /// <summary>
      /// Deselects the row in the grid.
      /// </summary>
      public void DeselectGrid()
      {
         grid.Model.Selections.Clear();
      }

      protected void SetRowState(DataRow dataRow, DataRowState dataRowState)
      {
         dataRow.AcceptChanges();

         if (dataRowState == DataRowState.Added)
         {
            dataRow.SetAdded();
         }
         else
         {
            dataRow.SetModified();
         }
      }

      protected void SetRowState(DataRow dataRow, bool markAsAdded)
      {
         SetRowState(dataRow, markAsAdded ? DataRowState.Added : DataRowState.Modified);
      }


      /// <summary>
      /// Returns the current row of the current grid
      /// </summary>
      /// <returns></returns>
      protected DataRow GetCurrentRow()
      {
         return GetRow(grid.CurrentCell.RowIndex);
      }

      /// <summary>
      /// Returns datasource row by grid rowIndex
      /// </summary>
      /// <returns></returns>
      protected DataRow GetRow(int rowIndex)
      {
         int position = grid.Binder.RowIndexToPosition(rowIndex);
         if (position > -1 && position < dataSource.DefaultView.Count)
         {
            return dataSource.DefaultView[position].Row;
         }
         return null;
      }

      /// <summary>
      /// Checks if there are any not initialized rows with null values in columns that do not allow nulls
      /// </summary>
      /// <param name="row"></param>
      /// <param name="firstNotNullColumn"></param>
      /// <returns></returns>
      protected bool IsRowHasNullsInNotNullColumns(DataRow row, out string firstNotNullColumn)
      {
         firstNotNullColumn = "";
         bool err = false;

         foreach (DataColumn col in row.Table.Columns)
         {
            if (!col.AllowDBNull && row.IsNull(col))
            {
               err = true;
               break;
            }
         }

         if (err)
         {
            foreach (DataColumn col in row.Table.Columns)
            {
               if (!row.IsNull(col))
               {
                  firstNotNullColumn = col.ColumnName;
                  return true;
               }
            }
         }

         return false;
      }

      /// <summary>
      /// Returns style info for current cell of the current grid
      /// </summary>
      /// <returns></returns>
      protected GridStyleInfo GetCurrentCellStyleInfo()
      {
         return grid[grid.CurrentCell.RowIndex, grid.CurrentCell.ColIndex];
      }

      /// <summary>
      /// Returns header text of column by the mapping name
      /// </summary>
      /// <param name="text">Mapping name</param>
      /// <returns></returns>
      protected string FindHeaderTextByColName(string text)
      {
         foreach (GridBoundColumn col in grid.Binder.InternalColumns)
         {
            if (col.MappingName.ToUpper() == text.ToUpper())
               return col.HeaderText;
         }
         return string.Empty;
      }

      /// <summary>
      /// Returns mapping name of the source column
      /// </summary>
      /// <param name="text">Grid column header text</param>
      /// <returns></returns>
      protected string FindColNameByHeaderText(string text)
      {
         foreach (GridBoundColumn col in grid.Binder.InternalColumns)
         {
            if (col.HeaderText.ToUpper() == text.ToUpper())
               return col.MappingName;
         }
         return string.Empty;
      }

      protected string[] GetColumnsNamesForImporting()
      {
         List<string> list = new List<string>();

         foreach (GridBoundColumn col in grid.Binder.InternalColumns)
         {
            //if (col.StyleInfo.CellType == StructureSimpleGridColumn.CellType)
            //   continue;

            list.Add(col.HeaderText);
         }

         return list.ToArray();

      }

      /// <summary>
      /// Checks if current view contains changed rows
      /// </summary>
      /// <returns></returns>
      internal bool CurrentViewHasChanges()
      {
         DataTable cdt = dataSource.GetChanges();
         return (cdt != null);
      }

      /// <summary>
      /// Checks if grid is in mode when the underlying table events should be handled
      /// </summary>
      /// <param name="grid"></param>
      /// <param name="e"></param>
      /// <returns></returns>
      public bool IsEditing(DataColumnChangeEventArgs e)
      {
         if (e.ProposedValue == DBNull.Value) return false;
         if (grid.CurrentCell.IsInDeactivate && grid.CurrentCell.IsEditing) return true;
         //if (grid.CurrentCell.IsEditing) return true;
         return false;
      }

      /// <summary>
      /// Returns original version if exists, else returns current version
      /// </summary>
      /// <param name="row"></param>
      /// <param name="col"></param>
      /// <returns></returns>
      protected string GetOriginalValue(DataRow row, DataColumn col)
      {
         if (row.HasVersion(DataRowVersion.Original))
         {
            return row[col, DataRowVersion.Original].ToString();
         }
         else if (row.HasVersion(DataRowVersion.Current))
         {
            return row[col, DataRowVersion.Current].ToString();
         }
         else
         {
            return null;
         }
      }

      #endregion

      #region Grid initialization

      /// <summary>
      /// Initializes the grid.
      /// </summary>
      protected virtual void InitializeGrid()
      {
         grid.Model.Options.SelectCellsMouseButtonsMask = MouseButtons.Left | MouseButtons.Right;
         grid.Model.Options.WrapCellBehavior = GridWrapCellBehavior.WrapRow;
         grid.Model.Options.EnterKeyBehavior = GridDirectionType.Down;

         // Make sure the combo box button draws small 
         GridCellModelBase gcmb = grid.Model.CellModels["ComboBox"];
         gcmb.ButtonBarSize = new Size(15, 18);

         grid.CurrentCellValidating += OnCurrentCellValidating;
         grid.Model.ClipboardPaste += OnClipboardPaste;
         grid.Model.QueryCellInfo += OnQueryCellInfo;
         grid.Model.SelectionChanging += OnSelectionChanging;
      }

      #endregion
   }
}
