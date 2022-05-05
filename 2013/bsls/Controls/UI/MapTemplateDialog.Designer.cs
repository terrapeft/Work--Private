namespace Jnj.ThirdDimension.Controls.BarcodeSeries
{
   partial class MapTemplateDialog
   {
      /// <summary>
      /// Required designer variable.
      /// </summary>
      private System.ComponentModel.IContainer components = null;

      /// <summary>
      /// Clean up any resources being used.
      /// </summary>
      /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
      protected override void Dispose(bool disposing)
      {
         if (disposing && (components != null))
         {
            components.Dispose();
         }
         base.Dispose(disposing);
      }

      #region Windows Form Designer generated code

      /// <summary>
      /// Required method for Designer support - do not modify
      /// the contents of this method with the code editor.
      /// </summary>
      private void InitializeComponent()
      {
         Syncfusion.Windows.Forms.Grid.GridBaseStyle gridBaseStyle1 = new Syncfusion.Windows.Forms.Grid.GridBaseStyle();
         Syncfusion.Windows.Forms.Grid.GridBaseStyle gridBaseStyle2 = new Syncfusion.Windows.Forms.Grid.GridBaseStyle();
         Syncfusion.Windows.Forms.Grid.GridBaseStyle gridBaseStyle3 = new Syncfusion.Windows.Forms.Grid.GridBaseStyle();
         Syncfusion.Windows.Forms.Grid.GridBaseStyle gridBaseStyle4 = new Syncfusion.Windows.Forms.Grid.GridBaseStyle();
         Syncfusion.Windows.Forms.Grid.GridStyleInfo gridStyleInfo1 = new Syncfusion.Windows.Forms.Grid.GridStyleInfo();
         System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(MapTemplateDialog));
         this.btnOK = new System.Windows.Forms.Button();
         this.btnCancel = new System.Windows.Forms.Button();
         this.openFileDialog1 = new System.Windows.Forms.OpenFileDialog();
         this.groupBox1 = new System.Windows.Forms.GroupBox();
         this.label2 = new System.Windows.Forms.Label();
         this.mappingGrid = new Jnj.Windows.Forms.SimpleGrid();
         this.templateGridBoundColumn = new Jnj.Windows.Forms.SimpleGridBoundColumn();
         this.gridGridBoundColumn = new Jnj.Windows.Forms.SimpleGridBoundColumn();
         this.defaultColumn = new Jnj.Windows.Forms.SimpleGridBoundColumn();
         ((System.ComponentModel.ISupportInitialize)(this.mappingGrid)).BeginInit();
         this.SuspendLayout();
         // 
         // btnOK
         // 
         this.btnOK.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
         this.btnOK.DialogResult = System.Windows.Forms.DialogResult.OK;
         this.btnOK.Enabled = false;
         this.btnOK.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
         this.btnOK.Location = new System.Drawing.Point(237, 459);
         this.btnOK.Name = "btnOK";
         this.btnOK.Size = new System.Drawing.Size(75, 23);
         this.btnOK.TabIndex = 9;
         this.btnOK.Text = "OK";
         this.btnOK.UseVisualStyleBackColor = true;
         // 
         // btnCancel
         // 
         this.btnCancel.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
         this.btnCancel.DialogResult = System.Windows.Forms.DialogResult.Cancel;
         this.btnCancel.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
         this.btnCancel.Location = new System.Drawing.Point(318, 459);
         this.btnCancel.Name = "btnCancel";
         this.btnCancel.Size = new System.Drawing.Size(75, 23);
         this.btnCancel.TabIndex = 10;
         this.btnCancel.Text = "Cancel";
         this.btnCancel.UseVisualStyleBackColor = true;
         // 
         // openFileDialog1
         // 
         this.openFileDialog1.Filter = "CSV|*.csv";
         this.openFileDialog1.Title = "Open file";
         // 
         // groupBox1
         // 
         this.groupBox1.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)
                     | System.Windows.Forms.AnchorStyles.Right)));
         this.groupBox1.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
         this.groupBox1.Location = new System.Drawing.Point(-4, 446);
         this.groupBox1.Name = "groupBox1";
         this.groupBox1.Size = new System.Drawing.Size(419, 3);
         this.groupBox1.TabIndex = 1091;
         this.groupBox1.TabStop = false;
         // 
         // label2
         // 
         this.label2.AutoSize = true;
         this.label2.Location = new System.Drawing.Point(12, 7);
         this.label2.Name = "label2";
         this.label2.Size = new System.Drawing.Size(73, 13);
         this.label2.TabIndex = 1099;
         this.label2.Text = "Map columns:";
         // 
         // mappingGrid
         // 
         this.mappingGrid.ActivateCurrentCellBehavior = Syncfusion.Windows.Forms.Grid.GridCellActivateAction.DblClickOnCell;
         this.mappingGrid.AllowDragSelectedCols = true;
         this.mappingGrid.AllowIncreaseSmallChange = false;
         this.mappingGrid.AllowResizeToFit = false;
         this.mappingGrid.AllowSelection = ((Syncfusion.Windows.Forms.Grid.GridSelectionFlags)(((((Syncfusion.Windows.Forms.Grid.GridSelectionFlags.Row | Syncfusion.Windows.Forms.Grid.GridSelectionFlags.Multiple)
                     | Syncfusion.Windows.Forms.Grid.GridSelectionFlags.Shift)
                     | Syncfusion.Windows.Forms.Grid.GridSelectionFlags.Keyboard)
                     | Syncfusion.Windows.Forms.Grid.GridSelectionFlags.AlphaBlend)));
         this.mappingGrid.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                     | System.Windows.Forms.AnchorStyles.Left)
                     | System.Windows.Forms.AnchorStyles.Right)));
         this.mappingGrid.BackColor = System.Drawing.Color.White;
         gridBaseStyle1.Name = "Row Header";
         gridBaseStyle1.StyleInfo.BaseStyle = "Header";
         gridBaseStyle1.StyleInfo.CellType = "RowHeaderCell";
         gridBaseStyle1.StyleInfo.Enabled = true;
         gridBaseStyle1.StyleInfo.HorizontalAlignment = Syncfusion.Windows.Forms.Grid.GridHorizontalAlignment.Left;
         gridBaseStyle2.Name = "Column Header";
         gridBaseStyle2.StyleInfo.BaseStyle = "Header";
         gridBaseStyle2.StyleInfo.CellType = "ColumnHeaderCell";
         gridBaseStyle2.StyleInfo.HorizontalAlignment = Syncfusion.Windows.Forms.Grid.GridHorizontalAlignment.Center;
         gridBaseStyle3.Name = "Standard";
         gridBaseStyle3.StyleInfo.AutoSize = true;
         gridBaseStyle3.StyleInfo.CheckBoxOptions.CheckedValue = "True";
         gridBaseStyle3.StyleInfo.CheckBoxOptions.UncheckedValue = "False";
         gridBaseStyle3.StyleInfo.Interior = new Syncfusion.Drawing.BrushInfo(System.Drawing.SystemColors.Window);
         gridBaseStyle4.Name = "Header";
         gridBaseStyle4.StyleInfo.Borders.Bottom = new Syncfusion.Windows.Forms.Grid.GridBorder(Syncfusion.Windows.Forms.Grid.GridBorderStyle.Standard, System.Drawing.Color.Black);
         gridBaseStyle4.StyleInfo.Borders.Left = new Syncfusion.Windows.Forms.Grid.GridBorder(Syncfusion.Windows.Forms.Grid.GridBorderStyle.None);
         gridBaseStyle4.StyleInfo.Borders.Right = new Syncfusion.Windows.Forms.Grid.GridBorder(Syncfusion.Windows.Forms.Grid.GridBorderStyle.Standard, System.Drawing.Color.Black);
         gridBaseStyle4.StyleInfo.Borders.Top = new Syncfusion.Windows.Forms.Grid.GridBorder(Syncfusion.Windows.Forms.Grid.GridBorderStyle.None);
         gridBaseStyle4.StyleInfo.CellType = "Header";
         gridBaseStyle4.StyleInfo.Font.Bold = true;
         gridBaseStyle4.StyleInfo.Font.Facename = "Verdana";
         gridBaseStyle4.StyleInfo.Interior = new Syncfusion.Drawing.BrushInfo(System.Drawing.SystemColors.Control);
         gridBaseStyle4.StyleInfo.VerticalAlignment = Syncfusion.Windows.Forms.Grid.GridVerticalAlignment.Middle;
         this.mappingGrid.BaseStylesMap.AddRange(new Syncfusion.Windows.Forms.Grid.GridBaseStyle[] {
            gridBaseStyle1,
            gridBaseStyle2,
            gridBaseStyle3,
            gridBaseStyle4});
         this.mappingGrid.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
         this.mappingGrid.ControllerOptions = ((Syncfusion.Windows.Forms.Grid.GridControllerOptions)((((((Syncfusion.Windows.Forms.Grid.GridControllerOptions.ClickCells | Syncfusion.Windows.Forms.Grid.GridControllerOptions.DragSelectRowOrColumn)
                     | Syncfusion.Windows.Forms.Grid.GridControllerOptions.OleDropTarget)
                     | Syncfusion.Windows.Forms.Grid.GridControllerOptions.SelectCells)
                     | Syncfusion.Windows.Forms.Grid.GridControllerOptions.ExcelLikeSelection)
                     | Syncfusion.Windows.Forms.Grid.GridControllerOptions.ResizeCells)));
         this.mappingGrid.DataMember = "";
         this.mappingGrid.Location = new System.Drawing.Point(12, 23);
         this.mappingGrid.MinResizeRowSize = 5;
         this.mappingGrid.MouseWheelScrollLines = 1;
         this.mappingGrid.Name = "mappingGrid";
         this.mappingGrid.OptimizeInsertRemoveCells = true;
         this.mappingGrid.Properties.BackgroundColor = System.Drawing.Color.WhiteSmoke;
         this.mappingGrid.Properties.Buttons3D = false;
         this.mappingGrid.ResizeColsBehavior = ((Syncfusion.Windows.Forms.Grid.GridResizeCellsBehavior)((((Syncfusion.Windows.Forms.Grid.GridResizeCellsBehavior.ResizeAll | Syncfusion.Windows.Forms.Grid.GridResizeCellsBehavior.ResizeSingle)
                     | Syncfusion.Windows.Forms.Grid.GridResizeCellsBehavior.OutlineHeaders)
                     | Syncfusion.Windows.Forms.Grid.GridResizeCellsBehavior.OutlineBounds)));
         this.mappingGrid.ResizeRowsBehavior = ((Syncfusion.Windows.Forms.Grid.GridResizeCellsBehavior)(((((Syncfusion.Windows.Forms.Grid.GridResizeCellsBehavior.ResizeAll | Syncfusion.Windows.Forms.Grid.GridResizeCellsBehavior.ResizeSingle)
                     | Syncfusion.Windows.Forms.Grid.GridResizeCellsBehavior.InsideGrid)
                     | Syncfusion.Windows.Forms.Grid.GridResizeCellsBehavior.OutlineHeaders)
                     | Syncfusion.Windows.Forms.Grid.GridResizeCellsBehavior.OutlineBounds)));
         this.mappingGrid.ShowCurrentCellBorderBehavior = Syncfusion.Windows.Forms.Grid.GridShowCurrentCellBorder.GrayWhenLostFocus;
         this.mappingGrid.SimpleGridBoundColumns.AddRange(new Syncfusion.Windows.Forms.Grid.GridBoundColumn[] {
            this.templateGridBoundColumn,
            this.gridGridBoundColumn,
            this.defaultColumn});
         this.mappingGrid.Size = new System.Drawing.Size(381, 417);
         this.mappingGrid.SizeGripStyle = System.Windows.Forms.SizeGripStyle.Show;
         this.mappingGrid.SmartSizeBox = false;
         this.mappingGrid.SortBehavior = Syncfusion.Windows.Forms.Grid.GridSortBehavior.DoubleClick;
         this.mappingGrid.TabIndex = 1101;
         gridStyleInfo1.Interior = new Syncfusion.Drawing.BrushInfo(System.Drawing.SystemColors.Window);
         this.mappingGrid.TableStyle = gridStyleInfo1;
         this.mappingGrid.UseListChangedEvent = true;
         this.mappingGrid.CurrentCellChanged += new System.EventHandler(this.mappingGrid_CurrentCellChanged);
         // 
         // templateGridBoundColumn
         // 
         this.templateGridBoundColumn.EnableAutoChanges = false;
         this.templateGridBoundColumn.EnableFilter = false;
         this.templateGridBoundColumn.HeaderText = "Template";
         this.templateGridBoundColumn.MappingName = "DestinationName";
         this.templateGridBoundColumn.ReadOnly = true;
         // 
         // gridGridBoundColumn
         // 
         this.gridGridBoundColumn.EnableAutoChanges = false;
         this.gridGridBoundColumn.EnableFilter = false;
         this.gridGridBoundColumn.HeaderText = "Grid";
         this.gridGridBoundColumn.MappingName = "SourceName";
         this.gridGridBoundColumn.StyleInfo.CellType = "ComboBox";
         this.gridGridBoundColumn.StyleInfo.DisplayMember = "";
         this.gridGridBoundColumn.StyleInfo.DropDownStyle = Syncfusion.Windows.Forms.Grid.GridDropDownStyle.Exclusive;
         this.gridGridBoundColumn.StyleInfo.ValueMember = "";
         // 
         // defaultColumn
         // 
         this.defaultColumn.EnableFilter = false;
         this.defaultColumn.HeaderText = "Default value";
         this.defaultColumn.MappingName = "DefaultValue";
         // 
         // MapTemplateDialog
         // 
         this.AcceptButton = this.btnOK;
         this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
         this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
         this.CancelButton = this.btnCancel;
         this.ClientSize = new System.Drawing.Size(405, 497);
         this.Controls.Add(this.mappingGrid);
         this.Controls.Add(this.label2);
         this.Controls.Add(this.groupBox1);
         this.Controls.Add(this.btnCancel);
         this.Controls.Add(this.btnOK);
         this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
         this.MaximizeBox = false;
         this.MinimizeBox = false;
         this.Name = "MapTemplateDialog";
         this.ShowIcon = false;
         this.ShowInTaskbar = false;
         this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
         this.Text = "Mapping Columns";
         ((System.ComponentModel.ISupportInitialize)(this.mappingGrid)).EndInit();
         this.ResumeLayout(false);
         this.PerformLayout();

      }

      #endregion

      private System.Windows.Forms.Button btnOK;
      private System.Windows.Forms.Button btnCancel;
      private System.Windows.Forms.OpenFileDialog openFileDialog1;
      private System.Windows.Forms.GroupBox groupBox1;
      private System.Windows.Forms.Label label2;
      private Jnj.Windows.Forms.SimpleGrid mappingGrid;
      private Jnj.Windows.Forms.SimpleGridBoundColumn templateGridBoundColumn;
      private Jnj.Windows.Forms.SimpleGridBoundColumn gridGridBoundColumn;
      private Jnj.Windows.Forms.SimpleGridBoundColumn defaultColumn;
   }
}