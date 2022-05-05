namespace Jnj.ThirdDimension.Controls.BarcodeSeries
{
   partial class LabelPrinting
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

      #region Component Designer generated code

      /// <summary> 
      /// Required method for Designer support - do not modify 
      /// the contents of this method with the code editor.
      /// </summary>
      private void InitializeComponent()
      {
         this.components = new System.ComponentModel.Container();
         Syncfusion.Windows.Forms.Grid.GridBaseStyle gridBaseStyle1 = new Syncfusion.Windows.Forms.Grid.GridBaseStyle();
         Syncfusion.Windows.Forms.Grid.GridBaseStyle gridBaseStyle2 = new Syncfusion.Windows.Forms.Grid.GridBaseStyle();
         Syncfusion.Windows.Forms.Grid.GridBaseStyle gridBaseStyle3 = new Syncfusion.Windows.Forms.Grid.GridBaseStyle();
         Syncfusion.Windows.Forms.Grid.GridBaseStyle gridBaseStyle4 = new Syncfusion.Windows.Forms.Grid.GridBaseStyle();
         Syncfusion.Windows.Forms.Grid.GridBaseStyle gridBaseStyle5 = new Syncfusion.Windows.Forms.Grid.GridBaseStyle();
         Syncfusion.Windows.Forms.Grid.GridStyleInfo gridStyleInfo1 = new Syncfusion.Windows.Forms.Grid.GridStyleInfo();
         this.label1 = new System.Windows.Forms.Label();
         this.groupBox1 = new System.Windows.Forms.GroupBox();
         this.templateComboBox = new System.Windows.Forms.ComboBox();
         this.label2 = new System.Windows.Forms.Label();
         this.printerComboBox = new System.Windows.Forms.ComboBox();
         this.templateButton = new System.Windows.Forms.Button();
         this.printerToolTip = new System.Windows.Forms.ToolTip(this.components);
         this.saveFileDialog = new System.Windows.Forms.SaveFileDialog();
         this.gridRecordNavigationControl1 = new Syncfusion.Windows.Forms.Grid.GridRecordNavigationControl();
         this.printGrid = new Jnj.Windows.Forms.SimpleGrid();
         this.panel1 = new System.Windows.Forms.Panel();
         this.panel2 = new System.Windows.Forms.Panel();
         this.groupBox1.SuspendLayout();
         this.gridRecordNavigationControl1.SuspendLayout();
         ((System.ComponentModel.ISupportInitialize)(this.printGrid)).BeginInit();
         this.panel1.SuspendLayout();
         this.panel2.SuspendLayout();
         this.SuspendLayout();
         // 
         // label1
         // 
         this.label1.AutoSize = true;
         this.label1.Location = new System.Drawing.Point(34, 24);
         this.label1.Name = "label1";
         this.label1.Size = new System.Drawing.Size(40, 13);
         this.label1.TabIndex = 1;
         this.label1.Text = "Printer:";
         // 
         // groupBox1
         // 
         this.groupBox1.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left)
                     | System.Windows.Forms.AnchorStyles.Right)));
         this.groupBox1.Controls.Add(this.panel2);
         this.groupBox1.Controls.Add(this.panel1);
         this.groupBox1.Controls.Add(this.label2);
         this.groupBox1.Controls.Add(this.templateButton);
         this.groupBox1.Controls.Add(this.label1);
         this.groupBox1.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
         this.groupBox1.Location = new System.Drawing.Point(3, 3);
         this.groupBox1.Name = "groupBox1";
         this.groupBox1.Size = new System.Drawing.Size(713, 82);
         this.groupBox1.TabIndex = 14;
         this.groupBox1.TabStop = false;
         this.groupBox1.Text = "Label Printer Settings";
         // 
         // templateComboBox
         // 
         this.templateComboBox.Dock = System.Windows.Forms.DockStyle.Fill;
         this.templateComboBox.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
         this.templateComboBox.Location = new System.Drawing.Point(0, 0);
         this.templateComboBox.Name = "templateComboBox";
         this.templateComboBox.Size = new System.Drawing.Size(539, 21);
         this.templateComboBox.TabIndex = 2;
         this.templateComboBox.SelectedIndexChanged += new System.EventHandler(this.templateComboBox_SelectedIndexChanged);
         // 
         // label2
         // 
         this.label2.AutoSize = true;
         this.label2.Location = new System.Drawing.Point(20, 52);
         this.label2.Name = "label2";
         this.label2.Size = new System.Drawing.Size(54, 13);
         this.label2.TabIndex = 20;
         this.label2.Text = "Template:";
         // 
         // printerComboBox
         // 
         this.printerComboBox.Dock = System.Windows.Forms.DockStyle.Fill;
         this.printerComboBox.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
         this.printerComboBox.Location = new System.Drawing.Point(0, 0);
         this.printerComboBox.Name = "printerComboBox";
         this.printerComboBox.Size = new System.Drawing.Size(539, 21);
         this.printerComboBox.TabIndex = 1;
         this.printerComboBox.SelectedIndexChanged += new System.EventHandler(this.printerComboBox_SelectedIndexChanged);
         // 
         // templateButton
         // 
         this.templateButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
         this.templateButton.Enabled = false;
         this.templateButton.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
         this.templateButton.Location = new System.Drawing.Point(627, 48);
         this.templateButton.Name = "templateButton";
         this.templateButton.Size = new System.Drawing.Size(80, 23);
         this.templateButton.TabIndex = 3;
         this.templateButton.Text = "Map fields...";
         this.templateButton.UseVisualStyleBackColor = true;
         this.templateButton.Click += new System.EventHandler(this.templateButton_Click);
         // 
         // gridRecordNavigationControl1
         // 
         this.gridRecordNavigationControl1.AllowAddNew = false;
         this.gridRecordNavigationControl1.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                     | System.Windows.Forms.AnchorStyles.Left)
                     | System.Windows.Forms.AnchorStyles.Right)));
         this.gridRecordNavigationControl1.Controls.Add(this.printGrid);
         this.gridRecordNavigationControl1.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold);
         this.gridRecordNavigationControl1.Location = new System.Drawing.Point(3, 91);
         this.gridRecordNavigationControl1.MaxRecord = 0;
         this.gridRecordNavigationControl1.Name = "gridRecordNavigationControl1";
         this.gridRecordNavigationControl1.ShowToolTips = true;
         this.gridRecordNavigationControl1.Size = new System.Drawing.Size(713, 336);
         this.gridRecordNavigationControl1.SplitBars = Syncfusion.Windows.Forms.DynamicSplitBars.None;
         this.gridRecordNavigationControl1.TabIndex = 15;
         this.gridRecordNavigationControl1.Text = "gridRecordNavigationControl1";
         this.gridRecordNavigationControl1.CurrentRecordChanged += new Syncfusion.Windows.Forms.CurrentRecordChangedEventHandler(this.recordNavigationControl1_CurrentRecordChanged);
         // 
         // printGrid
         // 
         this.printGrid.AllowDragSelectedCols = true;
         this.printGrid.AllowResizeToFit = false;
         this.printGrid.AllowSelection = ((Syncfusion.Windows.Forms.Grid.GridSelectionFlags)((((((Syncfusion.Windows.Forms.Grid.GridSelectionFlags.Row | Syncfusion.Windows.Forms.Grid.GridSelectionFlags.Cell)
                     | Syncfusion.Windows.Forms.Grid.GridSelectionFlags.Multiple)
                     | Syncfusion.Windows.Forms.Grid.GridSelectionFlags.Shift)
                     | Syncfusion.Windows.Forms.Grid.GridSelectionFlags.Keyboard)
                     | Syncfusion.Windows.Forms.Grid.GridSelectionFlags.AlphaBlend)));
         this.printGrid.BackColor = System.Drawing.Color.White;
         gridBaseStyle1.Name = "Row Header";
         gridBaseStyle1.StyleInfo.BaseStyle = "Header";
         gridBaseStyle1.StyleInfo.CellType = "RowHeaderCell";
         gridBaseStyle1.StyleInfo.Enabled = true;
         gridBaseStyle1.StyleInfo.HorizontalAlignment = Syncfusion.Windows.Forms.Grid.GridHorizontalAlignment.Left;
         gridBaseStyle2.Name = "Column Header";
         gridBaseStyle2.StyleInfo.BaseStyle = "Header";
         gridBaseStyle2.StyleInfo.CellType = "ColumnHeaderCell";
         gridBaseStyle2.StyleInfo.Enabled = false;
         gridBaseStyle2.StyleInfo.Font.Bold = true;
         gridBaseStyle2.StyleInfo.Font.Facename = "Verdana";
         gridBaseStyle2.StyleInfo.Font.Size = 11F;
         gridBaseStyle2.StyleInfo.Font.Unit = System.Drawing.GraphicsUnit.Pixel;
         gridBaseStyle2.StyleInfo.HorizontalAlignment = Syncfusion.Windows.Forms.Grid.GridHorizontalAlignment.Center;
         gridBaseStyle3.Name = "Standard";
         gridBaseStyle3.StyleInfo.Borders.Bottom = new Syncfusion.Windows.Forms.Grid.GridBorder(Syncfusion.Windows.Forms.Grid.GridBorderStyle.Solid, System.Drawing.SystemColors.Control, Syncfusion.Windows.Forms.Grid.GridBorderWeight.ExtraThin);
         gridBaseStyle3.StyleInfo.Borders.Right = new Syncfusion.Windows.Forms.Grid.GridBorder(Syncfusion.Windows.Forms.Grid.GridBorderStyle.Solid, System.Drawing.SystemColors.Control, Syncfusion.Windows.Forms.Grid.GridBorderWeight.ExtraThin);
         gridBaseStyle3.StyleInfo.CheckBoxOptions.CheckedValue = "True";
         gridBaseStyle3.StyleInfo.CheckBoxOptions.UncheckedValue = "False";
         gridBaseStyle3.StyleInfo.Interior = new Syncfusion.Drawing.BrushInfo(System.Drawing.SystemColors.Window);
         gridBaseStyle4.Name = "Header";
         gridBaseStyle4.StyleInfo.Borders.Bottom = new Syncfusion.Windows.Forms.Grid.GridBorder(Syncfusion.Windows.Forms.Grid.GridBorderStyle.None);
         gridBaseStyle4.StyleInfo.Borders.Left = new Syncfusion.Windows.Forms.Grid.GridBorder(Syncfusion.Windows.Forms.Grid.GridBorderStyle.None);
         gridBaseStyle4.StyleInfo.Borders.Right = new Syncfusion.Windows.Forms.Grid.GridBorder(Syncfusion.Windows.Forms.Grid.GridBorderStyle.None);
         gridBaseStyle4.StyleInfo.Borders.Top = new Syncfusion.Windows.Forms.Grid.GridBorder(Syncfusion.Windows.Forms.Grid.GridBorderStyle.None);
         gridBaseStyle4.StyleInfo.CellType = "Header";
         gridBaseStyle4.StyleInfo.Font.Bold = true;
         gridBaseStyle4.StyleInfo.Interior = new Syncfusion.Drawing.BrushInfo(System.Drawing.SystemColors.Control);
         gridBaseStyle4.StyleInfo.VerticalAlignment = Syncfusion.Windows.Forms.Grid.GridVerticalAlignment.Middle;
         gridBaseStyle5.Name = "Highlight";
         gridBaseStyle5.StyleInfo.BaseStyle = "Standard";
         gridBaseStyle5.StyleInfo.Interior = new Syncfusion.Drawing.BrushInfo(System.Drawing.Color.Teal);
         this.printGrid.BaseStylesMap.AddRange(new Syncfusion.Windows.Forms.Grid.GridBaseStyle[] {
            gridBaseStyle1,
            gridBaseStyle2,
            gridBaseStyle3,
            gridBaseStyle4,
            gridBaseStyle5});
         this.printGrid.ControllerOptions = ((Syncfusion.Windows.Forms.Grid.GridControllerOptions)((((((Syncfusion.Windows.Forms.Grid.GridControllerOptions.ClickCells | Syncfusion.Windows.Forms.Grid.GridControllerOptions.DragSelectRowOrColumn)
                     | Syncfusion.Windows.Forms.Grid.GridControllerOptions.OleDropTarget)
                     | Syncfusion.Windows.Forms.Grid.GridControllerOptions.SelectCells)
                     | Syncfusion.Windows.Forms.Grid.GridControllerOptions.ExcelLikeSelection)
                     | Syncfusion.Windows.Forms.Grid.GridControllerOptions.ResizeCells)));
         this.printGrid.EnableAddNew = false;
         this.printGrid.EnableEdit = false;
         this.printGrid.FillSplitterPane = true;
         this.printGrid.Font = new System.Drawing.Font("Verdana", 8.25F);
         this.printGrid.Location = new System.Drawing.Point(0, 0);
         this.printGrid.MinResizeRowSize = 5;
         this.printGrid.Name = "printGrid";
         this.printGrid.OptimizeInsertRemoveCells = true;
         this.printGrid.Properties.BackgroundColor = System.Drawing.SystemColors.Window;
         this.printGrid.Properties.Buttons3D = false;
         this.printGrid.ResizeRowsBehavior = ((Syncfusion.Windows.Forms.Grid.GridResizeCellsBehavior)(((Syncfusion.Windows.Forms.Grid.GridResizeCellsBehavior.ResizeAll | Syncfusion.Windows.Forms.Grid.GridResizeCellsBehavior.OutlineHeaders)
                     | Syncfusion.Windows.Forms.Grid.GridResizeCellsBehavior.OutlineBounds)));
         this.printGrid.ShowCurrentCellBorderBehavior = Syncfusion.Windows.Forms.Grid.GridShowCurrentCellBorder.GrayWhenLostFocus;
         this.printGrid.Size = new System.Drawing.Size(692, 315);
         this.printGrid.SmartSizeBox = false;
         this.printGrid.SortBehavior = Syncfusion.Windows.Forms.Grid.GridSortBehavior.DoubleClick;
         gridStyleInfo1.Font.Bold = false;
         gridStyleInfo1.Font.Facename = "Verdana";
         gridStyleInfo1.Font.Italic = false;
         gridStyleInfo1.Font.Size = 8.25F;
         gridStyleInfo1.Font.Strikeout = false;
         gridStyleInfo1.Font.Underline = false;
         this.printGrid.TableStyle = gridStyleInfo1;
         this.printGrid.Text = "printGrid";
         this.printGrid.UseListChangedEvent = true;
         this.printGrid.UseRightToLeftCompatibleTextBox = true;
         // 
         // panel1
         // 
         this.panel1.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left)
                     | System.Windows.Forms.AnchorStyles.Right)));
         this.panel1.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
         this.panel1.Controls.Add(this.printerComboBox);
         this.panel1.Location = new System.Drawing.Point(80, 20);
         this.panel1.Name = "panel1";
         this.panel1.Size = new System.Drawing.Size(541, 23);
         this.panel1.TabIndex = 21;
         // 
         // panel2
         // 
         this.panel2.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left)
                     | System.Windows.Forms.AnchorStyles.Right)));
         this.panel2.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
         this.panel2.Controls.Add(this.templateComboBox);
         this.panel2.Location = new System.Drawing.Point(80, 48);
         this.panel2.Name = "panel2";
         this.panel2.Size = new System.Drawing.Size(541, 23);
         this.panel2.TabIndex = 22;
         // 
         // LabelPrinting
         // 
         this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
         this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
         this.Controls.Add(this.gridRecordNavigationControl1);
         this.Controls.Add(this.groupBox1);
         this.Name = "LabelPrinting";
         this.Size = new System.Drawing.Size(719, 430);
         this.groupBox1.ResumeLayout(false);
         this.groupBox1.PerformLayout();
         this.gridRecordNavigationControl1.ResumeLayout(false);
         ((System.ComponentModel.ISupportInitialize)(this.printGrid)).EndInit();
         this.panel1.ResumeLayout(false);
         this.panel2.ResumeLayout(false);
         this.ResumeLayout(false);

      }
      #endregion

      private System.Windows.Forms.Label label1;
      private Jnj.Windows.Forms.SimpleGrid printGrid;
      private System.Windows.Forms.GroupBox groupBox1;
      private System.Windows.Forms.Button templateButton;
      private System.Windows.Forms.ToolTip printerToolTip;
      private System.Windows.Forms.SaveFileDialog saveFileDialog;
      private Syncfusion.Windows.Forms.Grid.GridRecordNavigationControl gridRecordNavigationControl1;
      private System.Windows.Forms.ComboBox printerComboBox;
      private System.Windows.Forms.ComboBox templateComboBox;
      private System.Windows.Forms.Label label2;
      private System.Windows.Forms.Panel panel2;
      private System.Windows.Forms.Panel panel1;
   }
}
