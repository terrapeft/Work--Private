#region Copyright (C) 1994-2006, Johnson & Johnson PRD, LLC.
//---------------------------------------------------------------------------*
//
//    CompoundSubmissionClipboardHelper.cs: Helper for copy\paste operations in GridDataBoundGrid
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
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Threading;
using System.Windows.Forms;
using Syncfusion.Windows.Forms.Grid;
using Jnj.ThirdDimension.Utils.BarcodeSeries;

namespace Jnj.ThirdDimension.Controls.BarcodeSeries
{
   public interface IGridDataBoundGridValidator
   {
      /// <summary>
      /// Collection of rules
      /// </summary>
      GridValidationRulesCollection Rules { get; set; }

      /// <summary>
      /// Process all rules for specified column
      /// </summary>
      /// <param name="colName">The column, the rule is specified for</param>
      /// <param name="value">Current value</param>
      /// <returns></returns>
      bool IsValidColumn(string colName, object value);

      /// <summary>
      /// Process all rules for specified column
      /// </summary>
      /// <param name="colName">The column, the rule is specified for</param>
      /// <param name="value">Current value</param>
      /// <param name="errorMessage">Error message specific for a rule</param>
      /// <returns></returns>
      bool IsValidColumn(string colName, object value, out string errorMessage);

      /// <summary>
      /// Process all simple rules (which are not marked as manual)
      /// </summary>
      /// <returns></returns>
      bool IsValid(GridDataBoundGrid grid);

      /// <summary>
      /// Contains a list of invalid cells' rows and cols indicies
      /// </summary>
      InvalidCells InvalidCells { get; }
   }

   /// <summary>
   /// Simplify validation of DataTables.
   /// Accumulates all rules for validation in rules collection and calls IsValid method of each rule
   /// </summary>
   public class GridDataBoundGridValidator : IGridDataBoundGridValidator
   {
      /// <summary>
      /// The method to create an instance of the class
      /// </summary>
      /// <returns></returns>
      public static IGridDataBoundGridValidator CreateGridDataBoundGridValidator()
      {
         return new GridDataBoundGridValidator();
      }

      private GridValidationRulesCollection rules;
      private InvalidCells invalidCells;

      /// <summary>
      /// Collection of rules
      /// </summary>
      public GridValidationRulesCollection Rules
      {
         get { return rules; }
         set { rules = value; }
      }

      /// <summary>
      /// Contains a list of invalid cells' rows and cols indicies
      /// </summary>
      public InvalidCells InvalidCells
      {
         get
         {
            if (invalidCells == null)
            {
               invalidCells = new InvalidCells();
            }
            return invalidCells;
         }
      }

      /// <summary>
      /// Default constructor. Use factory method CreateGridDataBoundGridValidator instead.
      /// </summary>
      public GridDataBoundGridValidator()
      {
         rules = new GridValidationRulesCollection();
      }

      /// <summary>
      /// Process all rules for specified column
      /// </summary>
      /// <param name="colName">The column the rule is specified for</param>
      /// <param name="value">Curreant value</param>
      /// <returns></returns>
      public bool IsValidColumn(string colName, object value)
      {
         string errM;
         return IsValidColumn(colName, value, out errM);
      }

      /// <summary>
      /// Process all rules for specified column
      /// </summary>
      /// <param name="colName">The column the rule is specified for</param>
      /// <param name="value">Curreant value</param>
      /// <param name="errorMessage">Error message specific for a rule</param>
      /// <returns></returns>
      public bool IsValidColumn(string colName, object value, out string errorMessage)
      {
         errorMessage = string.Empty;

         foreach (GridValidationRule rule in Rules[colName])
         {
            if (!rule.IsValid(value))
            {
               errorMessage = rule.ErrorMessage;
               return false;
            }
         }
         return true;
      }

      /// <summary>
      /// Process all simple rules (which are not marked as manual)
      /// </summary>
      /// <returns></returns>
      public bool IsValid(GridDataBoundGrid grid)
      {
         InvalidCells.Clear();

         GridStyleInfo styleInfo = null;
         string message = "";
         string header = "";
         string colName = "";
         int rowCount = GetRowsCount(grid);
         int columnCount = grid.GridBoundColumns.Count;
         bool valid = true;
         List<string> skipColumns = new List<string>();

         for (int rowIndex = 1; rowIndex <= rowCount; rowIndex++)
         {
            for (int columnIndex = 0; columnIndex < columnCount; columnIndex++)
            {
               GetCurrentCellValues(grid, rowIndex, columnIndex, out styleInfo, out header, out colName);
               
               if (skipColumns.Contains(colName)) continue;

               List<GridValidationRule> rulesForCurrentCol = rules[colName];
               foreach (GridValidationRule rule in rulesForCurrentCol)
               {
                  if (!rule.IsValid(styleInfo.CellValue, rowIndex, columnIndex))
                  {
                     if (!string.IsNullOrEmpty(rule.ErrorMessage))
                     {
                        message = rule.ErrorMessage + " ";
                     }
                     else
                     {
                        message = string.Format("'{0}' is incorrect value for {1} ", styleInfo.CellValue, header);
                     }

                     InvalidCell ci = new InvalidCell(rowIndex, columnIndex + 1, message);
                     InvalidCells.Add(ci);
                     valid = false;
                  }

                  if (rule.StopColumnCheck) skipColumns.Add(colName);
               }
            }
         }
         return valid;
      }

      private int GetRowsCount(GridDataBoundGrid grid)
      {
         if (grid.DataSource is DataView) return ((DataView) grid.DataSource).Count;
         if (grid.DataSource is DataTable) return ((DataTable)grid.DataSource).DefaultView.Count;
         return 0;
      }

      /// <summary>
      /// This property is not intended for use by developer
      /// </summary>
      /// <param name="grid"></param>
      /// <param name="rowIndex"></param>
      /// <param name="columnIndex"></param>
      /// <param name="styleInfo"></param>
      /// <param name="header"></param>
      /// <param name="colName"></param>
      public virtual void GetCurrentCellValues(GridDataBoundGrid grid, int rowIndex, int columnIndex, out GridStyleInfo styleInfo, out string header, out string colName)
      {
         styleInfo = grid[rowIndex, columnIndex + 1];
         header = grid.GridBoundColumns[columnIndex].HeaderText;
         colName = grid.GridBoundColumns[columnIndex].MappingName;
      }

      /// <summary>
      /// Displays a Validation Failure Message and a correspoding row
      /// </summary>
      /// <param name="message"></param>
      /// <param name="rowIndex"></param>
      public virtual void ShowValidationFailMessage(string message, int rowIndex)
      {
         MessagesHelper.ShowWarning(
            message + "( see row #" + rowIndex + "). Submission can not be performed.", "Validation of the Grid's content failed");
      }
   }

   /// <summary>
   /// The instance of the class represents a constraint for specified grid column
   /// </summary>
   public class GridValidationRule
   {
      private object valueToCompare;
      private Operator action = Operator.NotEqual;
      private string tag;

      /// <summary>
      /// Validate event delegate
      /// </summary>
      /// <param name="e"></param>
      /// <returns></returns>
      public delegate bool OnValidate(ValidateEventArgs e);
      
      /// <summary>
      /// Custom validation event
      /// </summary>
      public event OnValidate Validate;

      /// <summary>
      /// Comparison operator
      /// </summary>
      public enum Operator
      {
         NotEqual,
         Greater
      }

      /// <summary>
      /// The name of the column to apply this rule to
      /// </summary>
      public string ColumnName { get; set; }

      /// <summary>
      /// This message will shown in case of error
      /// </summary>
      public string ErrorMessage { get; set; }

      /// <summary>
      /// Container for some value
      /// </summary>
      public string Tag
      {
         get { return tag; }
         set { tag = value; }
      }

      /// <summary>
      /// Stops further processing of the column.
      /// </summary>
      public bool StopColumnCheck { get; set; }

      /// <summary>
      /// Consider value valid if it is DBNull
      /// </summary>
      public bool AllowDBNull { get; set; }

      #region Constructors
      /// <summary>
      /// Creates new rule
      /// </summary>
      /// <param name="columnName">Column name for the rule</param>
      public GridValidationRule(string columnName)
      {
         ColumnName = columnName;
      }

      /// <summary>
      /// Creates new rule
      /// </summary>
      /// <param name="columnName">Column name for the rule</param>
      /// <param name="restrictedValue">Restricted value</param>
      public GridValidationRule(string columnName, object restrictedValue)
         : this(columnName)
      {
         valueToCompare = restrictedValue;
      }

      /// <summary>
      /// Creates new rule
      /// </summary>
      /// <param name="columnName">Column name for the rule</param>
      /// <param name="restrictedValue">Restricted value</param>
      /// <param name="tag">Tag</param>
      public GridValidationRule(string columnName, object restrictedValue, string tag)
         : this(columnName)
      {
         valueToCompare = restrictedValue;
         this.tag = tag;
      }

      /// <summary>
      /// Creates new rule
      /// </summary>
      /// <param name="columnName">Column name for the rule</param>
      /// <param name="valueToCompare">Value to compare</param>
      /// <param name="action">Operator, that specifies how to compare</param>
      public GridValidationRule(string columnName, object valueToCompare, Operator action)
         : this(columnName, valueToCompare)
      {
         this.action = action;
      }

      #endregion

      #region Validation methods

      /// <summary>
      /// Used by validator for checking value against valueToCompare
      /// </summary>
      /// <param name="actualValue"></param>
      /// <returns></returns>
      public bool IsValid(object actualValue)
      {
         return IsValid(actualValue, -1, -1);
      }

      /// <summary>
      /// Checks the validity, if handler specified for Validate event, 
      /// the event will be fired and internal validity check will be bypassed
      /// </summary>
      /// <param name="actualValue"></param>
      /// <param name="rowIndex"></param>
      /// <param name="colIndex"></param>
      /// <returns></returns>
      public bool IsValid(object actualValue, int rowIndex, int colIndex)
      {
         //if event handler exists
         if (Validate != null)
         {
            ValidateEventArgs args = new ValidateEventArgs(actualValue, rowIndex, colIndex, tag);
            bool res = Validate(args);
            this.ErrorMessage = args.ErrorMessage;
            this.StopColumnCheck = args.StopColumnCheck;
            return res;
         }

         if (AllowDBNull && actualValue == DBNull.Value) return true;

         switch (action)
         {
            case Operator.NotEqual:
               return (Compare(actualValue) != 0);
            case Operator.Greater:
               return (Compare(actualValue) == 1);
         }

         return false;
      }

      protected int Compare(object actualValue)
      {
         if (IsNull(actualValue) || IsNull(valueToCompare))
         {
            if (IsNull(actualValue) && IsNull(valueToCompare)) return 0;
            if (IsNull(actualValue)) return -1;
            return 1;
         }

         object val = Convert.ChangeType(actualValue, actualValue.GetType());
         object val2 = Convert.ChangeType(valueToCompare, actualValue.GetType());

         Comparer comparer = new Comparer(Thread.CurrentThread.CurrentCulture);
         return comparer.Compare(val, val2);
      }

      private bool IsNull(object val)
      {
         return (val == null || val is DBNull);
      }
      #endregion
   }

   /// <summary>
   /// Collection of validation rules
   /// </summary>
   public class GridValidationRulesCollection : List<GridValidationRule>
   {
      /// <summary>
      /// Returns all validation rules for specified column
      /// </summary>
      /// <param name="columnName"></param>
      /// <returns></returns>
      public List<GridValidationRule> this[string columnName]
      {
         get 
         {
            List<GridValidationRule> list = new List<GridValidationRule>();
            foreach (GridValidationRule rule in this)
            {
               if (rule.ColumnName == columnName)
               {
                  list.Add(rule);
               }
            } 
            return list;
         }
      }
   }

   /// <summary>
   /// Event arguments for Validate event of GridValidationRule class
   /// </summary>
   public class ValidateEventArgs
   {
      private object val;
      private int rIndx;
      private int cIndx;

      public ValidateEventArgs(object value, int rowIndex, int colIndex, string tag)
      {
         val = value;
         rIndx = rowIndex;
         cIndx = colIndex;
         this.Tag = tag;
      }
      
      /// <summary>
      /// Value to validate
      /// </summary>
      public object Value
      {
         get { return val; }
      }

      /// <summary>
      /// Row index of validating cell
      /// </summary>
      public int RowIndex
      {
         get { return rIndx; }
      }

      /// <summary>
      /// Column index of validating cell
      /// </summary>
      public int ColumnIndex
      {
         get { return cIndx; }
      }

      /// <summary>
      /// Custom error message
      /// </summary>
      public string ErrorMessage { get; set; }

      /// <summary>
      /// Container for some value
      /// </summary>
      public string Tag { get; set; }

      /// <summary>
      /// Indicates whether the column should be checked again or not.
      /// </summary>
      public bool StopColumnCheck { get; set; }
   }

   /// <summary>
   /// Collection of InvalidCell instances
   /// </summary>
   public class InvalidCells: List<InvalidCell>
   {
      /// <summary>
      /// Returns InvalidCell instance for specified grid cell
      /// </summary>
      /// <param name="r">row index</param>
      /// <param name="c">column index</param>
      /// <returns></returns>
      public InvalidCell this [int r, int c]
      {
         get
         {
            foreach (InvalidCell cell in this)
            {
               if (cell.RowIndex == r && cell.ColumnIndex == c)
                  return cell;
            }
            return null;
         }
      }
   }

   /// <summary>
   /// Contains information about invalid cell
   /// </summary>
   public class InvalidCell
   {
      public InvalidCell(int rowInd, int colInd)
      {
         RowIndex = rowInd;
         ColumnIndex = colInd;
      }

      public InvalidCell(int rowInd, int colInd, string txt) : this(rowInd, colInd)
      {
         Text = txt;
      }

      /// <summary>
      /// Row index
      /// </summary>
      public int RowIndex { get; set; }

      /// <summary>
      /// Column index
      /// </summary>
      public int ColumnIndex { get; set; }

      /// <summary>
      /// Custom text, e.g. error message (currently not used)
      /// </summary>
      public string Text { get; set; }
   }
}
