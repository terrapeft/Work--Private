namespace Jnj.ThirdDimension.Controls.BarcodeSeries
{
   partial class SeriesSearchDialog
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
         this.components = new System.ComponentModel.Container();
         Syncfusion.Windows.Forms.Grid.GridBaseStyle gridBaseStyle1 = new Syncfusion.Windows.Forms.Grid.GridBaseStyle();
         Syncfusion.Windows.Forms.Grid.GridBaseStyle gridBaseStyle2 = new Syncfusion.Windows.Forms.Grid.GridBaseStyle();
         Syncfusion.Windows.Forms.Grid.GridBaseStyle gridBaseStyle3 = new Syncfusion.Windows.Forms.Grid.GridBaseStyle();
         Syncfusion.Windows.Forms.Grid.GridBaseStyle gridBaseStyle4 = new Syncfusion.Windows.Forms.Grid.GridBaseStyle();
         System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(SeriesSearchDialog));
         this.tabControl = new System.Windows.Forms.TabControl();
         this.queryTabPage = new System.Windows.Forms.TabPage();
         this.label5 = new System.Windows.Forms.Label();
         this.wwidTextBox = new Syncfusion.Windows.Forms.Tools.TextBoxExt();
         this.label4 = new System.Windows.Forms.Label();
         this.userNameTextBox = new Syncfusion.Windows.Forms.Tools.TextBoxExt();
         this.label2 = new System.Windows.Forms.Label();
         this.lastNameTextBox = new Syncfusion.Windows.Forms.Tools.TextBoxExt();
         this.label1 = new System.Windows.Forms.Label();
         this.firstNameTextBox = new Syncfusion.Windows.Forms.Tools.TextBoxExt();
         this.resetButton = new System.Windows.Forms.Button();
         this.findButton = new System.Windows.Forms.Button();
         this.label3 = new System.Windows.Forms.Label();
         this.nameTextBoxExt = new Syncfusion.Windows.Forms.Tools.TextBoxExt();
         this.cancel2Button = new System.Windows.Forms.Button();
         this.resultTabPage = new System.Windows.Forms.TabPage();
         this.gridRecordNavigationControl = new Syncfusion.Windows.Forms.Grid.GridRecordNavigationControl();
         this.gridDataBoundGrid = new Syncfusion.Windows.Forms.Grid.GridDataBoundGrid();
         this.nameColumn = new Syncfusion.Windows.Forms.Grid.GridBoundColumn();
         this.decrColumn = new Syncfusion.Windows.Forms.Grid.GridBoundColumn();
         this.lastDateColumn = new Syncfusion.Windows.Forms.Grid.GridBoundColumn();
         this.okButton = new System.Windows.Forms.Button();
         this.cancelButton = new System.Windows.Forms.Button();
         this.seriesDataTableBindingSource = new System.Windows.Forms.BindingSource(this.components);
         this.templateColumn = new Syncfusion.Windows.Forms.Grid.GridBoundColumn();
         this.tabControl.SuspendLayout();
         this.queryTabPage.SuspendLayout();
         ((System.ComponentModel.ISupportInitialize)(this.wwidTextBox)).BeginInit();
         ((System.ComponentModel.ISupportInitialize)(this.userNameTextBox)).BeginInit();
         ((System.ComponentModel.ISupportInitialize)(this.lastNameTextBox)).BeginInit();
         ((System.ComponentModel.ISupportInitialize)(this.firstNameTextBox)).BeginInit();
         ((System.ComponentModel.ISupportInitialize)(this.nameTextBoxExt)).BeginInit();
         this.resultTabPage.SuspendLayout();
         this.gridRecordNavigationControl.SuspendLayout();
         ((System.ComponentModel.ISupportInitialize)(this.gridDataBoundGrid)).BeginInit();
         ((System.ComponentModel.ISupportInitialize)(this.seriesDataTableBindingSource)).BeginInit();
         this.SuspendLayout();
         // 
         // tabControl
         // 
         this.tabControl.Controls.Add(this.queryTabPage);
         this.tabControl.Controls.Add(this.resultTabPage);
         this.tabControl.Dock = System.Windows.Forms.DockStyle.Fill;
         this.tabControl.Font = new System.Drawing.Font("Verdana", 9F, System.Drawing.FontStyle.Bold);
         this.tabControl.ItemSize = new System.Drawing.Size(96, 28);
         this.tabControl.Location = new System.Drawing.Point(0, 0);
         this.tabControl.Name = "tabControl";
         this.tabControl.Padding = new System.Drawing.Point(10, 4);
         this.tabControl.SelectedIndex = 0;
         this.tabControl.Size = new System.Drawing.Size(459, 246);
         this.tabControl.SizeMode = System.Windows.Forms.TabSizeMode.Fixed;
         this.tabControl.TabIndex = 25;
         // 
         // queryTabPage
         // 
         this.queryTabPage.AutoScroll = true;
         this.queryTabPage.Controls.Add(this.label5);
         this.queryTabPage.Controls.Add(this.wwidTextBox);
         this.queryTabPage.Controls.Add(this.label4);
         this.queryTabPage.Controls.Add(this.userNameTextBox);
         this.queryTabPage.Controls.Add(this.label2);
         this.queryTabPage.Controls.Add(this.lastNameTextBox);
         this.queryTabPage.Controls.Add(this.label1);
         this.queryTabPage.Controls.Add(this.firstNameTextBox);
         this.queryTabPage.Controls.Add(this.resetButton);
         this.queryTabPage.Controls.Add(this.findButton);
         this.queryTabPage.Controls.Add(this.label3);
         this.queryTabPage.Controls.Add(this.nameTextBoxExt);
         this.queryTabPage.Controls.Add(this.cancel2Button);
         this.queryTabPage.Location = new System.Drawing.Point(4, 32);
         this.queryTabPage.Name = "queryTabPage";
         this.queryTabPage.Size = new System.Drawing.Size(451, 210);
         this.queryTabPage.TabIndex = 0;
         this.queryTabPage.Text = "Query";
         // 
         // label5
         // 
         this.label5.AutoSize = true;
         this.label5.Font = new System.Drawing.Font("Verdana", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Pixel, ((byte)(0)));
         this.label5.Location = new System.Drawing.Point(13, 133);
         this.label5.Name = "label5";
         this.label5.Size = new System.Drawing.Size(91, 14);
         this.label5.TabIndex = 21;
         this.label5.Text = "User WWID:";
         this.label5.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
         // 
         // wwidTextBox
         // 
         this.wwidTextBox.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left)
                     | System.Windows.Forms.AnchorStyles.Right)));
         this.wwidTextBox.Border3DStyle = System.Windows.Forms.Border3DStyle.Flat;
         this.wwidTextBox.BorderColor = System.Drawing.SystemColors.ControlText;
         this.wwidTextBox.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
         this.wwidTextBox.Font = new System.Drawing.Font("Verdana", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Pixel, ((byte)(0)));
         this.wwidTextBox.Location = new System.Drawing.Point(110, 130);
         this.wwidTextBox.Name = "wwidTextBox";
         this.wwidTextBox.OverflowIndicatorToolTipText = null;
         this.wwidTextBox.Size = new System.Drawing.Size(324, 22);
         this.wwidTextBox.TabIndex = 20;
         // 
         // label4
         // 
         this.label4.AutoSize = true;
         this.label4.Font = new System.Drawing.Font("Verdana", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Pixel, ((byte)(0)));
         this.label4.Location = new System.Drawing.Point(19, 105);
         this.label4.Name = "label4";
         this.label4.Size = new System.Drawing.Size(85, 14);
         this.label4.TabIndex = 19;
         this.label4.Text = "User Name:";
         this.label4.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
         // 
         // userNameTextBox
         // 
         this.userNameTextBox.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left)
                     | System.Windows.Forms.AnchorStyles.Right)));
         this.userNameTextBox.Border3DStyle = System.Windows.Forms.Border3DStyle.Flat;
         this.userNameTextBox.BorderColor = System.Drawing.SystemColors.ControlText;
         this.userNameTextBox.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
         this.userNameTextBox.Font = new System.Drawing.Font("Verdana", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Pixel, ((byte)(0)));
         this.userNameTextBox.Location = new System.Drawing.Point(110, 102);
         this.userNameTextBox.Name = "userNameTextBox";
         this.userNameTextBox.OverflowIndicatorToolTipText = null;
         this.userNameTextBox.Size = new System.Drawing.Size(324, 22);
         this.userNameTextBox.TabIndex = 18;
         // 
         // label2
         // 
         this.label2.AutoSize = true;
         this.label2.Font = new System.Drawing.Font("Verdana", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Pixel, ((byte)(0)));
         this.label2.Location = new System.Drawing.Point(22, 77);
         this.label2.Name = "label2";
         this.label2.Size = new System.Drawing.Size(82, 14);
         this.label2.TabIndex = 17;
         this.label2.Text = "Last Name:";
         this.label2.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
         // 
         // lastNameTextBox
         // 
         this.lastNameTextBox.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left)
                     | System.Windows.Forms.AnchorStyles.Right)));
         this.lastNameTextBox.Border3DStyle = System.Windows.Forms.Border3DStyle.Flat;
         this.lastNameTextBox.BorderColor = System.Drawing.SystemColors.ControlText;
         this.lastNameTextBox.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
         this.lastNameTextBox.Font = new System.Drawing.Font("Verdana", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Pixel, ((byte)(0)));
         this.lastNameTextBox.Location = new System.Drawing.Point(110, 74);
         this.lastNameTextBox.Name = "lastNameTextBox";
         this.lastNameTextBox.OverflowIndicatorToolTipText = null;
         this.lastNameTextBox.Size = new System.Drawing.Size(324, 22);
         this.lastNameTextBox.TabIndex = 16;
         // 
         // label1
         // 
         this.label1.AutoSize = true;
         this.label1.Font = new System.Drawing.Font("Verdana", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Pixel, ((byte)(0)));
         this.label1.Location = new System.Drawing.Point(20, 49);
         this.label1.Name = "label1";
         this.label1.Size = new System.Drawing.Size(84, 14);
         this.label1.TabIndex = 15;
         this.label1.Text = "First Name:";
         this.label1.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
         // 
         // firstNameTextBox
         // 
         this.firstNameTextBox.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left)
                     | System.Windows.Forms.AnchorStyles.Right)));
         this.firstNameTextBox.Border3DStyle = System.Windows.Forms.Border3DStyle.Flat;
         this.firstNameTextBox.BorderColor = System.Drawing.SystemColors.ControlText;
         this.firstNameTextBox.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
         this.firstNameTextBox.Font = new System.Drawing.Font("Verdana", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Pixel, ((byte)(0)));
         this.firstNameTextBox.Location = new System.Drawing.Point(110, 46);
         this.firstNameTextBox.Name = "firstNameTextBox";
         this.firstNameTextBox.OverflowIndicatorToolTipText = null;
         this.firstNameTextBox.Size = new System.Drawing.Size(324, 22);
         this.firstNameTextBox.TabIndex = 14;
         // 
         // resetButton
         // 
         this.resetButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
         this.resetButton.BackColor = System.Drawing.SystemColors.Control;
         this.resetButton.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
         this.resetButton.Font = new System.Drawing.Font("Verdana", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Pixel, ((byte)(0)));
         this.resetButton.Location = new System.Drawing.Point(291, 178);
         this.resetButton.Name = "resetButton";
         this.resetButton.Size = new System.Drawing.Size(72, 23);
         this.resetButton.TabIndex = 6;
         this.resetButton.Text = "Reset";
         this.resetButton.UseVisualStyleBackColor = false;
         this.resetButton.Click += new System.EventHandler(this.resetButton_Click);
         // 
         // findButton
         // 
         this.findButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
         this.findButton.BackColor = System.Drawing.SystemColors.Control;
         this.findButton.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
         this.findButton.Font = new System.Drawing.Font("Verdana", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Pixel, ((byte)(0)));
         this.findButton.Location = new System.Drawing.Point(211, 178);
         this.findButton.Name = "findButton";
         this.findButton.Size = new System.Drawing.Size(72, 23);
         this.findButton.TabIndex = 5;
         this.findButton.Text = "Find";
         this.findButton.UseVisualStyleBackColor = false;
         this.findButton.Click += new System.EventHandler(this.findButton_Click);
         // 
         // label3
         // 
         this.label3.AutoSize = true;
         this.label3.Font = new System.Drawing.Font("Verdana", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Pixel, ((byte)(0)));
         this.label3.Location = new System.Drawing.Point(8, 21);
         this.label3.Name = "label3";
         this.label3.Size = new System.Drawing.Size(96, 14);
         this.label3.TabIndex = 13;
         this.label3.Text = "Series Name:";
         this.label3.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
         // 
         // nameTextBoxExt
         // 
         this.nameTextBoxExt.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left)
                     | System.Windows.Forms.AnchorStyles.Right)));
         this.nameTextBoxExt.Border3DStyle = System.Windows.Forms.Border3DStyle.Flat;
         this.nameTextBoxExt.BorderColor = System.Drawing.SystemColors.ControlText;
         this.nameTextBoxExt.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
         this.nameTextBoxExt.Font = new System.Drawing.Font("Verdana", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Pixel, ((byte)(0)));
         this.nameTextBoxExt.Location = new System.Drawing.Point(110, 18);
         this.nameTextBoxExt.Name = "nameTextBoxExt";
         this.nameTextBoxExt.OverflowIndicatorToolTipText = null;
         this.nameTextBoxExt.Size = new System.Drawing.Size(324, 22);
         this.nameTextBoxExt.TabIndex = 1;
         // 
         // cancel2Button
         // 
         this.cancel2Button.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
         this.cancel2Button.BackColor = System.Drawing.SystemColors.Control;
         this.cancel2Button.DialogResult = System.Windows.Forms.DialogResult.Cancel;
         this.cancel2Button.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
         this.cancel2Button.Font = new System.Drawing.Font("Verdana", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Pixel, ((byte)(0)));
         this.cancel2Button.Location = new System.Drawing.Point(371, 178);
         this.cancel2Button.Name = "cancel2Button";
         this.cancel2Button.Size = new System.Drawing.Size(72, 23);
         this.cancel2Button.TabIndex = 7;
         this.cancel2Button.Text = "Cancel";
         this.cancel2Button.UseVisualStyleBackColor = false;
         this.cancel2Button.Click += new System.EventHandler(this.cancel2Button_Click);
         // 
         // resultTabPage
         // 
         this.resultTabPage.Controls.Add(this.gridRecordNavigationControl);
         this.resultTabPage.Controls.Add(this.okButton);
         this.resultTabPage.Controls.Add(this.cancelButton);
         this.resultTabPage.Location = new System.Drawing.Point(4, 32);
         this.resultTabPage.Name = "resultTabPage";
         this.resultTabPage.Size = new System.Drawing.Size(451, 210);
         this.resultTabPage.TabIndex = 1;
         this.resultTabPage.Text = "Result";
         // 
         // gridRecordNavigationControl
         // 
         this.gridRecordNavigationControl.AllowAddNew = false;
         this.gridRecordNavigationControl.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                     | System.Windows.Forms.AnchorStyles.Left)
                     | System.Windows.Forms.AnchorStyles.Right)));
         this.gridRecordNavigationControl.BorderStyle = System.Windows.Forms.BorderStyle.None;
         this.gridRecordNavigationControl.Controls.Add(this.gridDataBoundGrid);
         this.gridRecordNavigationControl.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F);
         this.gridRecordNavigationControl.Location = new System.Drawing.Point(0, 0);
         this.gridRecordNavigationControl.MaxRecord = 0;
         this.gridRecordNavigationControl.Name = "gridRecordNavigationControl";
         this.gridRecordNavigationControl.ShowToolTips = true;
         this.gridRecordNavigationControl.Size = new System.Drawing.Size(451, 179);
         this.gridRecordNavigationControl.SplitBars = Syncfusion.Windows.Forms.DynamicSplitBars.None;
         this.gridRecordNavigationControl.TabIndex = 24;
         this.gridRecordNavigationControl.Text = "gridRecordNavigationControl1";
         this.gridRecordNavigationControl.CurrentRecordChanged += new Syncfusion.Windows.Forms.CurrentRecordChangedEventHandler(this.gridRecordNavigationControl_CurrentRecordChanged);
         // 
         // gridDataBoundGrid
         // 
         this.gridDataBoundGrid.ActivateCurrentCellBehavior = Syncfusion.Windows.Forms.Grid.GridCellActivateAction.DblClickOnCell;
         this.gridDataBoundGrid.AllowDragSelectedCols = true;
         this.gridDataBoundGrid.AllowSelection = ((Syncfusion.Windows.Forms.Grid.GridSelectionFlags)((((((((Syncfusion.Windows.Forms.Grid.GridSelectionFlags.Row | Syncfusion.Windows.Forms.Grid.GridSelectionFlags.Column)
                     | Syncfusion.Windows.Forms.Grid.GridSelectionFlags.Cell)
                     | Syncfusion.Windows.Forms.Grid.GridSelectionFlags.Multiple)
                     | Syncfusion.Windows.Forms.Grid.GridSelectionFlags.Shift)
                     | Syncfusion.Windows.Forms.Grid.GridSelectionFlags.Keyboard)
                     | Syncfusion.Windows.Forms.Grid.GridSelectionFlags.AlphaBlend)
                     | Syncfusion.Windows.Forms.Grid.GridSelectionFlags.MixRangeType)));
         this.gridDataBoundGrid.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                     | System.Windows.Forms.AnchorStyles.Left)
                     | System.Windows.Forms.AnchorStyles.Right)));
         this.gridDataBoundGrid.BackColor = System.Drawing.Color.White;
         gridBaseStyle1.Name = "Row Header";
         gridBaseStyle1.StyleInfo.BaseStyle = "Header";
         gridBaseStyle1.StyleInfo.CellType = "RowHeaderCell";
         gridBaseStyle1.StyleInfo.Enabled = true;
         gridBaseStyle1.StyleInfo.HorizontalAlignment = Syncfusion.Windows.Forms.Grid.GridHorizontalAlignment.Left;
         gridBaseStyle2.Name = "Column Header";
         gridBaseStyle2.StyleInfo.BaseStyle = "Header";
         gridBaseStyle2.StyleInfo.CellType = "ColumnHeaderCell";
         gridBaseStyle2.StyleInfo.Enabled = true;
         gridBaseStyle2.StyleInfo.Font.Bold = false;
         gridBaseStyle2.StyleInfo.HorizontalAlignment = Syncfusion.Windows.Forms.Grid.GridHorizontalAlignment.Center;
         gridBaseStyle3.Name = "Standard";
         gridBaseStyle3.StyleInfo.CheckBoxOptions.CheckedValue = "True";
         gridBaseStyle3.StyleInfo.CheckBoxOptions.UncheckedValue = "False";
         gridBaseStyle4.Name = "Header";
         gridBaseStyle4.StyleInfo.Borders.Bottom = new Syncfusion.Windows.Forms.Grid.GridBorder(Syncfusion.Windows.Forms.Grid.GridBorderStyle.Standard, System.Drawing.Color.Black);
         gridBaseStyle4.StyleInfo.Borders.Left = new Syncfusion.Windows.Forms.Grid.GridBorder(Syncfusion.Windows.Forms.Grid.GridBorderStyle.None);
         gridBaseStyle4.StyleInfo.Borders.Right = new Syncfusion.Windows.Forms.Grid.GridBorder(Syncfusion.Windows.Forms.Grid.GridBorderStyle.Standard, System.Drawing.Color.Black);
         gridBaseStyle4.StyleInfo.Borders.Top = new Syncfusion.Windows.Forms.Grid.GridBorder(Syncfusion.Windows.Forms.Grid.GridBorderStyle.None);
         gridBaseStyle4.StyleInfo.CellType = "Header";
         gridBaseStyle4.StyleInfo.Font.Bold = true;
         gridBaseStyle4.StyleInfo.Font.Facename = "Verdana";
         gridBaseStyle4.StyleInfo.VerticalAlignment = Syncfusion.Windows.Forms.Grid.GridVerticalAlignment.Middle;
         this.gridDataBoundGrid.BaseStylesMap.AddRange(new Syncfusion.Windows.Forms.Grid.GridBaseStyle[] {
            gridBaseStyle1,
            gridBaseStyle2,
            gridBaseStyle3,
            gridBaseStyle4});
         this.gridDataBoundGrid.ControllerOptions = ((Syncfusion.Windows.Forms.Grid.GridControllerOptions)((((((Syncfusion.Windows.Forms.Grid.GridControllerOptions.ClickCells | Syncfusion.Windows.Forms.Grid.GridControllerOptions.DragSelectRowOrColumn)
                     | Syncfusion.Windows.Forms.Grid.GridControllerOptions.OleDropTarget)
                     | Syncfusion.Windows.Forms.Grid.GridControllerOptions.SelectCells)
                     | Syncfusion.Windows.Forms.Grid.GridControllerOptions.ExcelLikeSelection)
                     | Syncfusion.Windows.Forms.Grid.GridControllerOptions.ResizeCells)));
         this.gridDataBoundGrid.DataMember = "";
         this.gridDataBoundGrid.EnableAddNew = false;
         this.gridDataBoundGrid.EnableRemove = false;
         this.gridDataBoundGrid.FillSplitterPane = true;
         this.gridDataBoundGrid.GridBoundColumns.AddRange(new Syncfusion.Windows.Forms.Grid.GridBoundColumn[] {
            this.nameColumn,
            this.templateColumn,
            this.lastDateColumn,
            this.decrColumn});
         this.gridDataBoundGrid.Location = new System.Drawing.Point(0, 0);
         this.gridDataBoundGrid.MinResizeRowSize = 5;
         this.gridDataBoundGrid.Name = "gridDataBoundGrid";
         this.gridDataBoundGrid.OptimizeInsertRemoveCells = true;
         this.gridDataBoundGrid.Properties.BackgroundColor = System.Drawing.Color.WhiteSmoke;
         this.gridDataBoundGrid.Properties.Buttons3D = false;
         this.gridDataBoundGrid.ResizeRowsBehavior = ((Syncfusion.Windows.Forms.Grid.GridResizeCellsBehavior)(((Syncfusion.Windows.Forms.Grid.GridResizeCellsBehavior.ResizeAll | Syncfusion.Windows.Forms.Grid.GridResizeCellsBehavior.OutlineHeaders)
                     | Syncfusion.Windows.Forms.Grid.GridResizeCellsBehavior.OutlineBounds)));
         this.gridDataBoundGrid.ShowCurrentCellBorderBehavior = Syncfusion.Windows.Forms.Grid.GridShowCurrentCellBorder.GrayWhenLostFocus;
         this.gridDataBoundGrid.Size = new System.Drawing.Size(434, 162);
         this.gridDataBoundGrid.SmartSizeBox = false;
         this.gridDataBoundGrid.SortBehavior = Syncfusion.Windows.Forms.Grid.GridSortBehavior.DoubleClick;
         this.gridDataBoundGrid.Text = "gridDataBoundGrid";
         this.gridDataBoundGrid.UseListChangedEvent = true;
         // 
         // nameColumn
         // 
         this.nameColumn.HeaderText = "Name";
         this.nameColumn.MappingName = "NAME";
         this.nameColumn.ReadOnly = true;
         // 
         // decrColumn
         // 
         this.decrColumn.HeaderText = "Description";
         this.decrColumn.MappingName = "DESCRIPTION";
         this.decrColumn.ReadOnly = true;
         // 
         // lastDateColumn
         // 
         this.lastDateColumn.HeaderText = "Last Date";
         this.lastDateColumn.MappingName = "LAST_DATE";
         this.lastDateColumn.ReadOnly = true;
         this.lastDateColumn.StyleInfo.CellValueType = typeof(System.DateTime);
         this.lastDateColumn.StyleInfo.CharacterCasing = System.Windows.Forms.CharacterCasing.Normal;
         this.lastDateColumn.StyleInfo.Format = "dd-MMM-yyyy";
         // 
         // okButton
         // 
         this.okButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
         this.okButton.BackColor = System.Drawing.SystemColors.Control;
         this.okButton.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
         this.okButton.Font = new System.Drawing.Font("Verdana", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Pixel, ((byte)(0)));
         this.okButton.Location = new System.Drawing.Point(291, 183);
         this.okButton.Name = "okButton";
         this.okButton.Size = new System.Drawing.Size(72, 23);
         this.okButton.TabIndex = 7;
         this.okButton.Text = "OK";
         this.okButton.UseVisualStyleBackColor = false;
         this.okButton.Click += new System.EventHandler(this.okButton_Click);
         // 
         // cancelButton
         // 
         this.cancelButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
         this.cancelButton.BackColor = System.Drawing.SystemColors.Control;
         this.cancelButton.DialogResult = System.Windows.Forms.DialogResult.Cancel;
         this.cancelButton.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
         this.cancelButton.Font = new System.Drawing.Font("Verdana", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Pixel, ((byte)(0)));
         this.cancelButton.Location = new System.Drawing.Point(371, 183);
         this.cancelButton.Name = "cancelButton";
         this.cancelButton.Size = new System.Drawing.Size(72, 23);
         this.cancelButton.TabIndex = 8;
         this.cancelButton.Text = "Cancel";
         this.cancelButton.UseVisualStyleBackColor = false;
         // 
         // seriesDataTableBindingSource
         // 
         this.seriesDataTableBindingSource.DataSource = typeof(Jnj.ThirdDimension.Data.BarcodeSeries.BSDataSet.SeriesDataTable);
         // 
         // templateColumn
         // 
         this.templateColumn.HeaderText = "Template";
         this.templateColumn.MappingName = "__TEMPLATE";
         // 
         // SeriesSearchDialog
         // 
         this.AcceptButton = this.findButton;
         this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
         this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
         this.CancelButton = this.cancelButton;
         this.ClientSize = new System.Drawing.Size(459, 246);
         this.Controls.Add(this.tabControl);
         this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
         this.Name = "SeriesSearchDialog";
         this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
         this.Text = "Series Search";
         this.Load += new System.EventHandler(this.SeriesSearch_Load);
         this.tabControl.ResumeLayout(false);
         this.queryTabPage.ResumeLayout(false);
         this.queryTabPage.PerformLayout();
         ((System.ComponentModel.ISupportInitialize)(this.wwidTextBox)).EndInit();
         ((System.ComponentModel.ISupportInitialize)(this.userNameTextBox)).EndInit();
         ((System.ComponentModel.ISupportInitialize)(this.lastNameTextBox)).EndInit();
         ((System.ComponentModel.ISupportInitialize)(this.firstNameTextBox)).EndInit();
         ((System.ComponentModel.ISupportInitialize)(this.nameTextBoxExt)).EndInit();
         this.resultTabPage.ResumeLayout(false);
         this.gridRecordNavigationControl.ResumeLayout(false);
         ((System.ComponentModel.ISupportInitialize)(this.gridDataBoundGrid)).EndInit();
         ((System.ComponentModel.ISupportInitialize)(this.seriesDataTableBindingSource)).EndInit();
         this.ResumeLayout(false);

      }

      #endregion

      private System.Windows.Forms.TabControl tabControl;
      private System.Windows.Forms.TabPage queryTabPage;
      private System.Windows.Forms.Button resetButton;
      private System.Windows.Forms.Button findButton;
      private System.Windows.Forms.Label label3;
      private Syncfusion.Windows.Forms.Tools.TextBoxExt nameTextBoxExt;
      private System.Windows.Forms.Button cancel2Button;
      private System.Windows.Forms.TabPage resultTabPage;
      private Syncfusion.Windows.Forms.Grid.GridRecordNavigationControl gridRecordNavigationControl;
      private Syncfusion.Windows.Forms.Grid.GridDataBoundGrid gridDataBoundGrid;
      private System.Windows.Forms.Button okButton;
      private System.Windows.Forms.Button cancelButton;
      private System.Windows.Forms.Label label5;
      private Syncfusion.Windows.Forms.Tools.TextBoxExt wwidTextBox;
      private System.Windows.Forms.Label label4;
      private Syncfusion.Windows.Forms.Tools.TextBoxExt userNameTextBox;
      private System.Windows.Forms.Label label2;
      private Syncfusion.Windows.Forms.Tools.TextBoxExt lastNameTextBox;
      private System.Windows.Forms.Label label1;
      private Syncfusion.Windows.Forms.Tools.TextBoxExt firstNameTextBox;
      private System.Windows.Forms.BindingSource seriesDataTableBindingSource;
      private Syncfusion.Windows.Forms.Grid.GridBoundColumn nameColumn;
      private Syncfusion.Windows.Forms.Grid.GridBoundColumn decrColumn;
      private Syncfusion.Windows.Forms.Grid.GridBoundColumn lastDateColumn;
      private Syncfusion.Windows.Forms.Grid.GridBoundColumn templateColumn;
   }
}