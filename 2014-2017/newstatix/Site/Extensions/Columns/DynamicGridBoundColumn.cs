namespace Telerik.Web.UI.DynamicData
{
	using System;
	using System.Collections;
	using System.Collections.Specialized;
	using System.ComponentModel;
	using System.Web.DynamicData;
	using System.Web.UI;
	using System.Web.UI.WebControls;

	using UsersDb;
	using UsersDb.Helpers;

	using UsersUI;

	public class DynamicGridBoundColumn : GridBoundColumn
	{
		private bool? _applyFormatInEditMode;
		private bool? _convertEmptyStringToNull;
		private string _dataField;
		private string _dataFormatString;
		private bool _htmlEncode = true;
		private string _nullDisplayText;
		private MetaColumn _column;

		/// <summary>
		/// Fills the values.
		/// </summary>
		/// <param name="newValues">The new values.</param>
		/// <param name="editableItem">The editable item.</param>
		public override void FillValues(IDictionary newValues, GridEditableItem editableItem)
		{
			var values = new OrderedDictionary();

			ExtractValuesFromBindableControls(values, editableItem);

			foreach (DictionaryEntry entry in values)
			{
				if (!newValues.Contains(entry.Key))
				{
					newValues.Add(entry.Key, entry.Value);
				}
			}
		}

		/// <summary>
		/// Extracts the values from bindable controls.
		/// </summary>
		/// <param name="dictionary">The dictionary.</param>
		/// <param name="container">The container.</param>
		internal static void ExtractValuesFromBindableControls(IOrderedDictionary dictionary, Control container)
		{
			var control = container as IBindableControl;
			if (control != null)
			{
				control.ExtractValues(dictionary);
			}
			foreach (Control control2 in container.Controls)
			{
				ExtractValuesFromBindableControls(dictionary, control2);
			}
		}

		/// <summary>
		/// Resets the specified cell in the <strong>GridBoundColumn</strong> to its initial
		/// state.
		/// </summary>
		/// <param name="cell"></param>
		/// <param name="columnIndex"></param>
		/// <param name="inItem"></param>
		public override void InitializeCell(TableCell cell, int columnIndex, GridItem inItem)
		{
			if (inItem is GridEditableItem)
			{
				var dynamicControl = new DynamicControl
					                     {
						                     DataField = this.DataField,
						                     UIHint = this.UIHint,
						                     HtmlEncode = this.HtmlEncode,
						                     DataFormatString = this.DataFormatString,
						                     NullDisplayText = this.NullDisplayText
					                     };

				var isInsert = inItem is GridEditFormInsertItem || inItem is GridDataInsertItem;

				if (inItem.IsInEditMode)
				{
					if (_column.CanEdit())
					{
						dynamicControl.Mode = _column.CanEdit() ? DataBoundControlMode.Edit : DataBoundControlMode.ReadOnly;
					}
				}

				if (isInsert)
					dynamicControl.Mode = DataBoundControlMode.Insert;

				if (this._convertEmptyStringToNull.HasValue)
				{
					dynamicControl.ConvertEmptyStringToNull = this.ConvertEmptyStringToNull;
				}

				if (this._applyFormatInEditMode.HasValue)
				{
					dynamicControl.ApplyFormatInEditMode = this.ApplyFormatInEditMode;
				}

				cell.Controls.Add(dynamicControl);
			}
			else
			{
				base.InitializeCell(cell, columnIndex, inItem);
			}
		}

		/// <summary>
		/// Convert the emty string to null when extracting values for inserting, updating, deleting
		/// </summary>
		[Category("Behavior"), DefaultValue(false)]
		public new bool ConvertEmptyStringToNull
		{
			get
			{
				if (this._convertEmptyStringToNull.HasValue)
				{
					return this._convertEmptyStringToNull.Value;
				}
				return false;
			}
			set
			{
				this._convertEmptyStringToNull = new bool?(value);
			}
		}

		/// <summary>
		/// Gets or sets the field name from the specified data source to bind to the
		/// <strong>GridBoundColumn</strong>.
		/// </summary>
		/// <value>
		/// A <strong><em>string</em></strong>, specifying the data field from the data
		/// source, from which to bind the column.
		/// </value>
		[DefaultValue(""), Category("Behavior")]
		public override string DataField
		{
			get
			{
				if (this._dataField != null)
				{
					return this._dataField;
				}
				object obj2 = base.ViewState["DataField"];
				if (obj2 != null)
				{
					return (string)obj2;
				}
				return string.Empty;
			}
			set
			{
				if (!object.Equals(value, base.ViewState["DataField"]))
				{
					base.ViewState["DataField"] = value;
					this._dataField = value;
					this.OnColumnChanged();
				}
			}
		}

		/// <summary>
		/// Gets or sets the string that specifies the display format for items in the
		/// column.
		/// </summary>
		/// <value>
		/// A <strong><em>string</em></strong> that specifies the display format for items in
		/// the column
		/// </value>
		/// <remarks>
		///   <div id="ctl00_LibFrame_MainContent_ctl22">
		///   <para>Use the <b>DataFormatString</b> property to provide a custom format for the items
		/// in the column.</para>
		///   <para>The data format string consists of two parts, separated by a colon, in the form {
		///   <span class="parameter">A</span> : <span class="parameter">Bxx</span> }.<br />
		/// For example, the formatting string {0:C2} displays a currency formatted number with two
		/// decimal places.</para>
		///   <para><strong>Note:</strong> The entire string must be enclosed in braces to indicate
		/// that it is a format string and not a literal string. Any text outside the braces is
		/// displayed as literal text.</para>
		///   <para>The value before the colon (<span class="parameter">A</span> in the general
		/// example) specifies the parameter index in a zero-based list of parameters.</para>
		///   <div class="alert">
		///   <para><strong>Note:</strong> This value can only be set to 0 because there is only one
		/// value in each cell.</para></div>
		///   <para>The value before the colon (<span class="parameter">A</span> in the general
		/// example) specifies the parameter index in a zero-based list of parameters.</para>
		///   <para>The character after the colon (<span class="parameter">B</span> in the general
		/// example) specifies the format to display the value in. The following table lists the
		/// common formats.</para>
		///   <div class="labelheading">
		///   <div class="tableSection">
		///   <list type="table">
		///   <listheader>
		///   <term>
		///   <para>Format character</para></term>
		///   <description>
		///   <para>Description</para></description></listheader>
		///   <item>
		///   <term>
		///   <para><b>C</b></para></term>
		///   <description>
		///   <para>Displays numeric values in currency format.</para></description></item>
		///   <item>
		///   <term>
		///   <para><b>D</b></para></term>
		///   <description>
		///   <para>Displays numeric values in decimal format.</para></description></item>
		///   <item>
		///   <term>
		///   <para><b>E</b></para></term>
		///   <description>
		///   <para>Displays numeric values in scientific (exponential)
		/// format.</para></description></item>
		///   <item>
		///   <term>
		///   <para><b>F</b></para></term>
		///   <description>
		///   <para>Displays numeric values in fixed format.</para></description></item>
		///   <item>
		///   <term>
		///   <para><b>G</b></para></term>
		///   <description>
		///   <para>Displays numeric values in general format.</para></description></item>
		///   <item>
		///   <term>
		///   <para><b>N</b></para></term>
		///   <description>
		///   <para>Displays numeric values in number format.</para></description></item>
		///   <item>
		///   <term>
		///   <para><b>X</b></para></term>
		///   <description>
		///   <para>Displays numeric values in hexadecimal
		/// format.</para></description></item></list></div>
		///   <div class="tableSection">
		///   <para><strong>Note:</strong> The format character is not case-sensitive, except for
		///   <b>X</b>, which displays the hexadecimal characters in the case specified.</para></div>
		///   <div class="alert">The value after the format character
		/// (<span class="parameter">xx</span> in the general example) specifies the number of
		/// significant digits or decimal places to display.</div>
		///   <para>For more information on formatting strings, see
		///   <a href="http://msdn2.microsoft.com/en-us/library/26etazsy(VS.80).aspx">Formatting
		/// Overview</a> (external link to MSDN library).</para></div></div>
		/// </remarks>
		[Category("Data"), DefaultValue("")]
		public override string DataFormatString
		{
			get
			{
				return (this._dataFormatString ?? string.Empty);
			}
			set
			{
				this._dataFormatString = value;
			}
		}

		/// <summary>
		/// Gets the GridColumn instance implementing this interface
		/// </summary>
		/// <exception cref="System.InvalidOperationException"></exception>
		private MetaColumn Column
		{
			get
			{
				if (base.DesignMode || (this.Owner == null))
				{
					return null;
				}
				if (this._column == null)
				{
					MetaTable table = this.Owner.OwnerGrid.FindMetaTable();
					if (table == null)
					{
						throw new InvalidOperationException("");
					}
					this._column = table.GetColumn(this.DataField);
				}
				return this._column;
			}
		}

		/// <summary>
		/// Use the <b>HeaderText</b> property to specify your own or determine the current
		/// text for the header section of the column.
		/// </summary>
		public override string HeaderText
		{
			get
			{
				object obj2 = base.ViewState["HeaderText"];
				if (obj2 != null)
				{
					return (string)obj2;
				}
				if (this.Column != null)
				{
					return this.Column.DisplayName;
				}
				return this.DataField;
			}
			set
			{
				base.HeaderText = value;
			}
		}

		/// <summary>
		/// Sets or gets whether cell content must be encoded. Default value is
		/// <em>false</em>.
		/// </summary>
		[DefaultValue(true), Category("Behavior")]
		public override bool HtmlEncode
		{
			get
			{
				return this._htmlEncode;
			}
			set
			{
				this._htmlEncode = value;
			}
		}

		/// <summary>
		/// Gets or sets the null display text.
		/// </summary>
		/// <value>
		/// The null display text.
		/// </value>
		[Category("Behavior"), DefaultValue("")]
		public string NullDisplayText
		{
			get
			{
				return (this._nullDisplayText ?? string.Empty);
			}
			set
			{
				this._nullDisplayText = value;
			}
		}

		/// <summary>
		/// The string representing a filed-name from the DataSource that should be used when grid sorts by this column. For example:
		/// 'EmployeeName'
		/// </summary>
		public override string SortExpression
		{
			get
			{
				object obj2 = base.ViewState["SortExpression"];
				if (obj2 != null)
				{
					return (string)obj2;
				}
				if (this.Column != null)
				{
					return this.Column.SortExpression;
				}
				return string.Empty;
			}
		}

		/// <summary>
		/// Gets or sets the UI hint.
		/// </summary>
		/// <value>
		/// The UI hint.
		/// </value>
		[DefaultValue(""), Category("Behavior")]
		public virtual string UIHint
		{
			get
			{
				object obj2 = base.ViewState["UIHint"];
				if (obj2 != null)
				{
					return (string)obj2;
				}
				return string.Empty;
			}
			set
			{
				if (!object.Equals(value, base.ViewState["UIHint"]))
				{
					base.ViewState["UIHint"] = value;
					this.OnColumnChanged();
				}
			}
		}


		/// <summary>
		/// Gets or sets the hide column in.
		/// </summary>
		/// <value>
		/// The hide column in.
		/// </value>
		[DefaultValue(""), Category("Behavior")]
		public virtual PageTemplate? HideColumnIn
		{
			get
			{
				object obj2 = base.ViewState["HideColumnIn"];
				if (obj2 != null)
				{
					return (PageTemplate)obj2;
				}
				return PageTemplate.Unknown;
			}
			set
			{
				if (!Equals(value, base.ViewState["HideColumnIn"]))
				{
					base.ViewState["HideColumnIn"] = value;
					this.OnColumnChanged();
				}
			}
		}


		/// <summary>
		/// Gets or sets a value indicating whether [apply format in edit mode].
		/// </summary>
		/// <value>
		/// <c>true</c> if [apply format in edit mode]; otherwise, <c>false</c>.
		/// </value>
		[Category("Behavior"), DefaultValue(false)]
		public bool ApplyFormatInEditMode
		{
			get
			{
				if (this._applyFormatInEditMode.HasValue)
				{
					return this._applyFormatInEditMode.Value;
				}
				return false;
			}
			set
			{
				this._applyFormatInEditMode = new bool?(value);
			}
		}

		/// <summary>
		/// Clones this instance.
		/// </summary>
		/// <returns></returns>
		public override GridColumn Clone()
		{
			var column = new DynamicGridBoundColumn();
			column.CopyBaseProperties(this);

			return column;
		}

		/// <summary>
		/// Copies the base properties.
		/// </summary>
		/// <param name="fromColumn">From column.</param>
		protected override void CopyBaseProperties(GridColumn fromColumn)
		{
			base.CopyBaseProperties(fromColumn);
			var source = (DynamicGridBoundColumn)fromColumn;

			this.ConvertEmptyStringToNull = source.ConvertEmptyStringToNull;
			this.DataFormatString = source.DataFormatString;
			this.UIHint = source.UIHint;
			this.HtmlEncode = source.HtmlEncode;
			this.NullDisplayText = source.NullDisplayText;
			this.ApplyFormatInEditMode = source.ApplyFormatInEditMode;
		}
	}
}