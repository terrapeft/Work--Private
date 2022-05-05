using Jnj.ThirdDimension.Data.BarcodeSeries;
namespace Jnj.ThirdDimension.Controls.BarcodeSeries
{
   partial class SeriesControl
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
         System.Windows.Forms.Button dbButton;
         System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(SeriesControl));
         Syncfusion.Windows.Forms.Grid.GridBaseStyle gridBaseStyle21 = new Syncfusion.Windows.Forms.Grid.GridBaseStyle();
         Syncfusion.Windows.Forms.Grid.GridBaseStyle gridBaseStyle22 = new Syncfusion.Windows.Forms.Grid.GridBaseStyle();
         Syncfusion.Windows.Forms.Grid.GridBaseStyle gridBaseStyle23 = new Syncfusion.Windows.Forms.Grid.GridBaseStyle();
         Syncfusion.Windows.Forms.Grid.GridBaseStyle gridBaseStyle24 = new Syncfusion.Windows.Forms.Grid.GridBaseStyle();
         Syncfusion.Windows.Forms.Grid.GridStyleInfo gridStyleInfo6 = new Syncfusion.Windows.Forms.Grid.GridStyleInfo();
         this.groupBox2 = new System.Windows.Forms.GroupBox();
         this.desktopOuterPanel = new System.Windows.Forms.Panel();
         this.label14 = new System.Windows.Forms.Label();
         this.label4 = new System.Windows.Forms.Label();
         this.examplePanel = new System.Windows.Forms.Panel();
         this.exampleRichTextBox = new System.Windows.Forms.RichTextBox();
         this.desktopPanel = new System.Windows.Forms.Panel();
         this.ilButtonsState = new System.Windows.Forms.ImageList(this.components);
         this.groupBox3 = new System.Windows.Forms.GroupBox();
         this.neverRadioButton = new System.Windows.Forms.RadioButton();
         this.weekNumRadioButton = new System.Windows.Forms.RadioButton();
         this.monthRadioButton = new System.Windows.Forms.RadioButton();
         this.yearRadioButton = new System.Windows.Forms.RadioButton();
         this.dayRadioButton = new System.Windows.Forms.RadioButton();
         this.label1 = new System.Windows.Forms.Label();
         this.findSeriesButton = new System.Windows.Forms.Button();
         this.newSeriesButton = new System.Windows.Forms.Button();
         this.startRangeTextBox = new Syncfusion.Windows.Forms.Tools.IntegerTextBox();
         this.seriesNameTextBox = new System.Windows.Forms.TextBox();
         this.label2 = new System.Windows.Forms.Label();
         this.label3 = new System.Windows.Forms.Label();
         this.dbGroupBox = new System.Windows.Forms.GroupBox();
         this.queryTextBox = new System.Windows.Forms.TextBox();
         this.sequenceTextBox = new System.Windows.Forms.TextBox();
         this.connStringTextBox = new System.Windows.Forms.TextBox();
         this.label9 = new System.Windows.Forms.Label();
         this.label8 = new System.Windows.Forms.Label();
         this.label6 = new System.Windows.Forms.Label();
         this.seriesTabControl = new Syncfusion.Windows.Forms.Tools.TabControlAdv();
         this.definitionTabPage = new Syncfusion.Windows.Forms.Tools.TabPageAdv();
         this.label7 = new System.Windows.Forms.Label();
         this.reservationTabPage = new Syncfusion.Windows.Forms.Tools.TabPageAdv();
         this.groupBox1 = new System.Windows.Forms.GroupBox();
         this.vialsGridRecordNavigationControl = new Syncfusion.Windows.Forms.Grid.GridRecordNavigationControl();
         this.reservationGridDataBoundGrid = new Jnj.Windows.Forms.SimpleGrid();
         this.ReservationDataTableBindingSource = new System.Windows.Forms.BindingSource(this.components);
         this.minGridBoundColumn = new Jnj.Windows.Forms.SimpleGridBoundColumn();
         this.maxGridBoundColumn = new Jnj.Windows.Forms.SimpleGridBoundColumn();
         this.statusGridBoundColumn = new Jnj.Windows.Forms.SimpleGridBoundColumn();
         this.refreshButton = new System.Windows.Forms.Button();
         this.toolPanel = new System.Windows.Forms.Panel();
         this.toolTip1 = new System.Windows.Forms.ToolTip(this.components);
         this.textDragLabel = new Jnj.ThirdDimension.Controls.BarcodeSeries.UI.DraggableLabel();
         this.yearDragLabel = new Jnj.ThirdDimension.Controls.BarcodeSeries.UI.DraggableLabel();
         this.monthDragLabel = new Jnj.ThirdDimension.Controls.BarcodeSeries.UI.DraggableLabel();
         this.seriesDragLabel = new Jnj.ThirdDimension.Controls.BarcodeSeries.UI.DraggableLabel();
         this.dayDragLabel = new Jnj.ThirdDimension.Controls.BarcodeSeries.UI.DraggableLabel();
         this.weekDragLabel = new Jnj.ThirdDimension.Controls.BarcodeSeries.UI.DraggableLabel();
         dbButton = new System.Windows.Forms.Button();
         this.groupBox2.SuspendLayout();
         this.desktopOuterPanel.SuspendLayout();
         this.examplePanel.SuspendLayout();
         this.groupBox3.SuspendLayout();
         ((System.ComponentModel.ISupportInitialize)(this.startRangeTextBox)).BeginInit();
         this.dbGroupBox.SuspendLayout();
         ((System.ComponentModel.ISupportInitialize)(this.seriesTabControl)).BeginInit();
         this.seriesTabControl.SuspendLayout();
         this.definitionTabPage.SuspendLayout();
         this.reservationTabPage.SuspendLayout();
         this.groupBox1.SuspendLayout();
         this.vialsGridRecordNavigationControl.SuspendLayout();
         ((System.ComponentModel.ISupportInitialize)(this.reservationGridDataBoundGrid)).BeginInit();
         ((System.ComponentModel.ISupportInitialize)(this.ReservationDataTableBindingSource)).BeginInit();
         this.toolPanel.SuspendLayout();
         this.SuspendLayout();
         // 
         // dbButton
         // 
         dbButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
         dbButton.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
         dbButton.Image = ((System.Drawing.Image)(resources.GetObject("dbButton.Image")));
         dbButton.Location = new System.Drawing.Point(573, 24);
         dbButton.Name = "dbButton";
         dbButton.Size = new System.Drawing.Size(23, 23);
         dbButton.TabIndex = 8;
         this.toolTip1.SetToolTip(dbButton, "Edit database settings.");
         dbButton.UseVisualStyleBackColor = true;
         dbButton.Click += new System.EventHandler(this.dbButton_Click);
         // 
         // groupBox2
         // 
         this.groupBox2.Controls.Add(this.desktopOuterPanel);
         this.groupBox2.Dock = System.Windows.Forms.DockStyle.Fill;
         this.groupBox2.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
         this.groupBox2.Location = new System.Drawing.Point(3, 106);
         this.groupBox2.Name = "groupBox2";
         this.groupBox2.Size = new System.Drawing.Size(665, 235);
         this.groupBox2.TabIndex = 27;
         this.groupBox2.TabStop = false;
         this.groupBox2.Text = "Label Series Template";
         // 
         // desktopOuterPanel
         // 
         this.desktopOuterPanel.AllowDrop = true;
         this.desktopOuterPanel.Controls.Add(this.refreshButton);
         this.desktopOuterPanel.Controls.Add(this.label14);
         this.desktopOuterPanel.Controls.Add(this.label4);
         this.desktopOuterPanel.Controls.Add(this.examplePanel);
         this.desktopOuterPanel.Controls.Add(this.desktopPanel);
         this.desktopOuterPanel.Controls.Add(this.toolPanel);
         this.desktopOuterPanel.Dock = System.Windows.Forms.DockStyle.Fill;
         this.desktopOuterPanel.Location = new System.Drawing.Point(3, 16);
         this.desktopOuterPanel.Name = "desktopOuterPanel";
         this.desktopOuterPanel.Size = new System.Drawing.Size(659, 216);
         this.desktopOuterPanel.TabIndex = 35;
         this.desktopOuterPanel.DragDrop += new System.Windows.Forms.DragEventHandler(this.desktopOuterPanel_DragDrop);
         this.desktopOuterPanel.DragEnter += new System.Windows.Forms.DragEventHandler(this.desktopOuterPanel_DragEnter);
         // 
         // label14
         // 
         this.label14.AutoSize = true;
         this.label14.Location = new System.Drawing.Point(9, 9);
         this.label14.Name = "label14";
         this.label14.Size = new System.Drawing.Size(87, 13);
         this.label14.TabIndex = 34;
         this.label14.Text = "Add template for:";
         // 
         // label4
         // 
         this.label4.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
         this.label4.AutoSize = true;
         this.label4.Location = new System.Drawing.Point(46, 175);
         this.label4.Name = "label4";
         this.label4.Size = new System.Drawing.Size(50, 13);
         this.label4.TabIndex = 7;
         this.label4.Text = "Example:";
         // 
         // examplePanel
         // 
         this.examplePanel.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)
                     | System.Windows.Forms.AnchorStyles.Right)));
         this.examplePanel.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
         this.examplePanel.Controls.Add(this.exampleRichTextBox);
         this.examplePanel.Location = new System.Drawing.Point(102, 171);
         this.examplePanel.Name = "examplePanel";
         this.examplePanel.Padding = new System.Windows.Forms.Padding(2);
         this.examplePanel.Size = new System.Drawing.Size(445, 26);
         this.examplePanel.TabIndex = 17;
         // 
         // exampleRichTextBox
         // 
         this.exampleRichTextBox.BackColor = System.Drawing.SystemColors.Control;
         this.exampleRichTextBox.BorderStyle = System.Windows.Forms.BorderStyle.None;
         this.exampleRichTextBox.Dock = System.Windows.Forms.DockStyle.Fill;
         this.exampleRichTextBox.Font = new System.Drawing.Font("Tahoma", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
         this.exampleRichTextBox.Location = new System.Drawing.Point(2, 2);
         this.exampleRichTextBox.Multiline = false;
         this.exampleRichTextBox.Name = "exampleRichTextBox";
         this.exampleRichTextBox.ScrollBars = System.Windows.Forms.RichTextBoxScrollBars.None;
         this.exampleRichTextBox.Size = new System.Drawing.Size(439, 20);
         this.exampleRichTextBox.TabIndex = 15;
         this.exampleRichTextBox.Text = "";
         this.exampleRichTextBox.Enter += new System.EventHandler(this.exampleRichTextBox_Enter);
         // 
         // desktopPanel
         // 
         this.desktopPanel.AllowDrop = true;
         this.desktopPanel.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                     | System.Windows.Forms.AnchorStyles.Left)
                     | System.Windows.Forms.AnchorStyles.Right)));
         this.desktopPanel.BackColor = System.Drawing.Color.WhiteSmoke;
         this.desktopPanel.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
         this.desktopPanel.Location = new System.Drawing.Point(102, 27);
         this.desktopPanel.Name = "desktopPanel";
         this.desktopPanel.Size = new System.Drawing.Size(445, 138);
         this.desktopPanel.TabIndex = 3;
         this.toolTip1.SetToolTip(this.desktopPanel, "Drag control out to remove.");
         this.desktopPanel.DragDrop += new System.Windows.Forms.DragEventHandler(this.desktopPanel_DragDrop);
         this.desktopPanel.DragEnter += new System.Windows.Forms.DragEventHandler(this.desktopPanel_DragEnter);
         // 
         // ilButtonsState
         // 
         this.ilButtonsState.ImageStream = ((System.Windows.Forms.ImageListStreamer)(resources.GetObject("ilButtonsState.ImageStream")));
         this.ilButtonsState.TransparentColor = System.Drawing.Color.Transparent;
         this.ilButtonsState.Images.SetKeyName(0, "plus2.gif");
         this.ilButtonsState.Images.SetKeyName(1, "minus2.gif");
         this.ilButtonsState.Images.SetKeyName(2, "plus_gray.gif");
         this.ilButtonsState.Images.SetKeyName(3, "minus_gray.gif");
         // 
         // groupBox3
         // 
         this.groupBox3.Controls.Add(this.neverRadioButton);
         this.groupBox3.Controls.Add(this.weekNumRadioButton);
         this.groupBox3.Controls.Add(this.monthRadioButton);
         this.groupBox3.Controls.Add(this.yearRadioButton);
         this.groupBox3.Controls.Add(this.dayRadioButton);
         this.groupBox3.Controls.Add(this.label1);
         this.groupBox3.Controls.Add(this.findSeriesButton);
         this.groupBox3.Controls.Add(this.newSeriesButton);
         this.groupBox3.Controls.Add(this.startRangeTextBox);
         this.groupBox3.Controls.Add(this.seriesNameTextBox);
         this.groupBox3.Controls.Add(this.label2);
         this.groupBox3.Controls.Add(this.label3);
         this.groupBox3.Dock = System.Windows.Forms.DockStyle.Top;
         this.groupBox3.Location = new System.Drawing.Point(3, 3);
         this.groupBox3.Name = "groupBox3";
         this.groupBox3.Size = new System.Drawing.Size(665, 103);
         this.groupBox3.TabIndex = 28;
         this.groupBox3.TabStop = false;
         this.groupBox3.Text = "Label Series";
         // 
         // neverRadioButton
         // 
         this.neverRadioButton.AutoSize = true;
         this.neverRadioButton.Checked = true;
         this.neverRadioButton.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
         this.neverRadioButton.Location = new System.Drawing.Point(261, 68);
         this.neverRadioButton.Name = "neverRadioButton";
         this.neverRadioButton.Size = new System.Drawing.Size(53, 17);
         this.neverRadioButton.TabIndex = 1085;
         this.neverRadioButton.TabStop = true;
         this.neverRadioButton.Text = "Never";
         this.neverRadioButton.UseVisualStyleBackColor = true;
         // 
         // weekNumRadioButton
         // 
         this.weekNumRadioButton.AutoSize = true;
         this.weekNumRadioButton.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
         this.weekNumRadioButton.Location = new System.Drawing.Point(449, 68);
         this.weekNumRadioButton.Name = "weekNumRadioButton";
         this.weekNumRadioButton.Size = new System.Drawing.Size(60, 17);
         this.weekNumRadioButton.TabIndex = 1084;
         this.weekNumRadioButton.Text = "Weekly";
         this.weekNumRadioButton.UseVisualStyleBackColor = true;
         // 
         // monthRadioButton
         // 
         this.monthRadioButton.AutoSize = true;
         this.monthRadioButton.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
         this.monthRadioButton.Location = new System.Drawing.Point(381, 68);
         this.monthRadioButton.Name = "monthRadioButton";
         this.monthRadioButton.Size = new System.Drawing.Size(61, 17);
         this.monthRadioButton.TabIndex = 1082;
         this.monthRadioButton.Text = "Monthly";
         this.monthRadioButton.UseVisualStyleBackColor = true;
         // 
         // yearRadioButton
         // 
         this.yearRadioButton.AutoSize = true;
         this.yearRadioButton.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
         this.yearRadioButton.Location = new System.Drawing.Point(321, 68);
         this.yearRadioButton.Name = "yearRadioButton";
         this.yearRadioButton.Size = new System.Drawing.Size(53, 17);
         this.yearRadioButton.TabIndex = 1081;
         this.yearRadioButton.Text = "Yearly";
         this.yearRadioButton.UseVisualStyleBackColor = true;
         // 
         // dayRadioButton
         // 
         this.dayRadioButton.AutoSize = true;
         this.dayRadioButton.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
         this.dayRadioButton.Location = new System.Drawing.Point(516, 68);
         this.dayRadioButton.Name = "dayRadioButton";
         this.dayRadioButton.Size = new System.Drawing.Size(47, 17);
         this.dayRadioButton.TabIndex = 1083;
         this.dayRadioButton.Text = "Daily";
         this.dayRadioButton.UseVisualStyleBackColor = true;
         // 
         // label1
         // 
         this.label1.AutoSize = true;
         this.label1.Location = new System.Drawing.Point(163, 70);
         this.label1.Name = "label1";
         this.label1.Size = new System.Drawing.Size(92, 13);
         this.label1.TabIndex = 1080;
         this.label1.Text = "Restart first value:";
         // 
         // findSeriesButton
         // 
         this.findSeriesButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
         this.findSeriesButton.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
         this.findSeriesButton.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F);
         this.findSeriesButton.Image = ((System.Drawing.Image)(resources.GetObject("findSeriesButton.Image")));
         this.findSeriesButton.Location = new System.Drawing.Point(602, 18);
         this.findSeriesButton.Name = "findSeriesButton";
         this.findSeriesButton.Size = new System.Drawing.Size(23, 23);
         this.findSeriesButton.TabIndex = 1079;
         this.findSeriesButton.TextAlign = System.Drawing.ContentAlignment.TopCenter;
         this.toolTip1.SetToolTip(this.findSeriesButton, "Search for series.");
         this.findSeriesButton.UseVisualStyleBackColor = true;
         this.findSeriesButton.Click += new System.EventHandler(this.findButton_Click);
         // 
         // newSeriesButton
         // 
         this.newSeriesButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
         this.newSeriesButton.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
         this.newSeriesButton.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F);
         this.newSeriesButton.ImageIndex = 0;
         this.newSeriesButton.ImageList = this.ilButtonsState;
         this.newSeriesButton.Location = new System.Drawing.Point(573, 18);
         this.newSeriesButton.Name = "newSeriesButton";
         this.newSeriesButton.Size = new System.Drawing.Size(23, 23);
         this.newSeriesButton.TabIndex = 1077;
         this.newSeriesButton.TextAlign = System.Drawing.ContentAlignment.TopCenter;
         this.toolTip1.SetToolTip(this.newSeriesButton, "Add new series.");
         this.newSeriesButton.UseVisualStyleBackColor = true;
         this.newSeriesButton.Click += new System.EventHandler(this.newSeriesButton_Click);
         // 
         // startRangeTextBox
         // 
         this.startRangeTextBox.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
         this.startRangeTextBox.IntegerValue = ((long)(1));
         this.startRangeTextBox.Location = new System.Drawing.Point(105, 66);
         this.startRangeTextBox.Name = "startRangeTextBox";
         this.startRangeTextBox.NegativeInputPendingOnSelectAll = false;
         this.startRangeTextBox.NullString = "0";
         this.startRangeTextBox.OverflowIndicatorToolTipText = null;
         this.startRangeTextBox.ReadOnlyBackColor = System.Drawing.SystemColors.Control;
         this.startRangeTextBox.Size = new System.Drawing.Size(52, 20);
         this.startRangeTextBox.TabIndex = 3;
         // 
         // seriesNameTextBox
         // 
         this.seriesNameTextBox.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left)
                     | System.Windows.Forms.AnchorStyles.Right)));
         this.seriesNameTextBox.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
         this.seriesNameTextBox.Enabled = false;
         this.seriesNameTextBox.Location = new System.Drawing.Point(105, 19);
         this.seriesNameTextBox.Name = "seriesNameTextBox";
         this.seriesNameTextBox.Size = new System.Drawing.Size(445, 20);
         this.seriesNameTextBox.TabIndex = 1;
         // 
         // label2
         // 
         this.label2.AutoSize = true;
         this.label2.Location = new System.Drawing.Point(61, 21);
         this.label2.Name = "label2";
         this.label2.Size = new System.Drawing.Size(38, 13);
         this.label2.TabIndex = 10;
         this.label2.Text = "Name:";
         // 
         // label3
         // 
         this.label3.AutoSize = true;
         this.label3.Location = new System.Drawing.Point(61, 47);
         this.label3.Name = "label3";
         this.label3.Size = new System.Drawing.Size(212, 13);
         this.label3.TabIndex = 12;
         this.label3.Text = "First Value (for labels using numeric values):";
         // 
         // dbGroupBox
         // 
         this.dbGroupBox.Controls.Add(this.queryTextBox);
         this.dbGroupBox.Controls.Add(this.sequenceTextBox);
         this.dbGroupBox.Controls.Add(this.connStringTextBox);
         this.dbGroupBox.Controls.Add(this.label9);
         this.dbGroupBox.Controls.Add(this.label8);
         this.dbGroupBox.Controls.Add(this.label6);
         this.dbGroupBox.Controls.Add(dbButton);
         this.dbGroupBox.Dock = System.Windows.Forms.DockStyle.Bottom;
         this.dbGroupBox.Location = new System.Drawing.Point(3, 341);
         this.dbGroupBox.Name = "dbGroupBox";
         this.dbGroupBox.Size = new System.Drawing.Size(665, 167);
         this.dbGroupBox.TabIndex = 29;
         this.dbGroupBox.TabStop = false;
         this.dbGroupBox.Text = "Database Settings";
         // 
         // queryTextBox
         // 
         this.queryTextBox.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                     | System.Windows.Forms.AnchorStyles.Left)
                     | System.Windows.Forms.AnchorStyles.Right)));
         this.queryTextBox.BackColor = System.Drawing.SystemColors.Control;
         this.queryTextBox.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
         this.queryTextBox.Location = new System.Drawing.Point(105, 93);
         this.queryTextBox.Multiline = true;
         this.queryTextBox.Name = "queryTextBox";
         this.queryTextBox.ReadOnly = true;
         this.queryTextBox.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
         this.queryTextBox.Size = new System.Drawing.Size(462, 65);
         this.queryTextBox.TabIndex = 19;
         // 
         // sequenceTextBox
         // 
         this.sequenceTextBox.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left)
                     | System.Windows.Forms.AnchorStyles.Right)));
         this.sequenceTextBox.BackColor = System.Drawing.SystemColors.Control;
         this.sequenceTextBox.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
         this.sequenceTextBox.Location = new System.Drawing.Point(105, 67);
         this.sequenceTextBox.Name = "sequenceTextBox";
         this.sequenceTextBox.ReadOnly = true;
         this.sequenceTextBox.Size = new System.Drawing.Size(445, 20);
         this.sequenceTextBox.TabIndex = 18;
         // 
         // connStringTextBox
         // 
         this.connStringTextBox.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left)
                     | System.Windows.Forms.AnchorStyles.Right)));
         this.connStringTextBox.BackColor = System.Drawing.SystemColors.Control;
         this.connStringTextBox.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
         this.connStringTextBox.Location = new System.Drawing.Point(105, 24);
         this.connStringTextBox.Multiline = true;
         this.connStringTextBox.Name = "connStringTextBox";
         this.connStringTextBox.ReadOnly = true;
         this.connStringTextBox.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
         this.connStringTextBox.Size = new System.Drawing.Size(462, 37);
         this.connStringTextBox.TabIndex = 17;
         // 
         // label9
         // 
         this.label9.AutoSize = true;
         this.label9.Location = new System.Drawing.Point(12, 95);
         this.label9.Name = "label9";
         this.label9.Size = new System.Drawing.Size(87, 13);
         this.label9.TabIndex = 16;
         this.label9.Text = "Validation Query:";
         // 
         // label8
         // 
         this.label8.AutoSize = true;
         this.label8.Location = new System.Drawing.Point(40, 69);
         this.label8.Name = "label8";
         this.label8.Size = new System.Drawing.Size(59, 13);
         this.label8.TabIndex = 15;
         this.label8.Text = "Sequence:";
         // 
         // label6
         // 
         this.label6.AutoSize = true;
         this.label6.Location = new System.Drawing.Point(7, 26);
         this.label6.Name = "label6";
         this.label6.Size = new System.Drawing.Size(92, 13);
         this.label6.TabIndex = 14;
         this.label6.Text = "Connection string:";
         // 
         // seriesTabControl
         // 
         this.seriesTabControl.BorderStyle = System.Windows.Forms.BorderStyle.None;
         this.seriesTabControl.Controls.Add(this.definitionTabPage);
         this.seriesTabControl.Controls.Add(this.reservationTabPage);
         this.seriesTabControl.Dock = System.Windows.Forms.DockStyle.Fill;
         this.seriesTabControl.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F);
         this.seriesTabControl.Location = new System.Drawing.Point(0, 0);
         this.seriesTabControl.Name = "seriesTabControl";
         this.seriesTabControl.Size = new System.Drawing.Size(671, 532);
         this.seriesTabControl.TabIndex = 1037;
         this.seriesTabControl.TabStyle = typeof(Syncfusion.Windows.Forms.Tools.TabRenderer2D);
         // 
         // definitionTabPage
         // 
         this.definitionTabPage.Controls.Add(this.groupBox2);
         this.definitionTabPage.Controls.Add(this.label7);
         this.definitionTabPage.Controls.Add(this.dbGroupBox);
         this.definitionTabPage.Controls.Add(this.groupBox3);
         this.definitionTabPage.Location = new System.Drawing.Point(0, 21);
         this.definitionTabPage.Name = "definitionTabPage";
         this.definitionTabPage.Padding = new System.Windows.Forms.Padding(3);
         this.definitionTabPage.Size = new System.Drawing.Size(671, 511);
         this.definitionTabPage.TabFont = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold);
         this.definitionTabPage.TabIndex = 1;
         this.definitionTabPage.Text = "Define/Update Label Series";
         this.definitionTabPage.ThemesEnabled = false;
         // 
         // label7
         // 
         this.label7.Font = new System.Drawing.Font("Verdana", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Pixel);
         this.label7.Location = new System.Drawing.Point(407, -92);
         this.label7.Name = "label7";
         this.label7.Size = new System.Drawing.Size(192, 12);
         this.label7.TabIndex = 1034;
         this.label7.Text = "Structure Match";
         this.label7.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
         // 
         // reservationTabPage
         // 
         this.reservationTabPage.Controls.Add(this.groupBox1);
         this.reservationTabPage.Location = new System.Drawing.Point(0, -1);
         this.reservationTabPage.Name = "reservationTabPage";
         this.reservationTabPage.Size = new System.Drawing.Size(671, 533);
         this.reservationTabPage.TabIndex = 1;
         this.reservationTabPage.Text = "Manage Reservations";
         this.reservationTabPage.ThemesEnabled = false;
         // 
         // groupBox1
         // 
         this.groupBox1.Controls.Add(this.vialsGridRecordNavigationControl);
         this.groupBox1.Dock = System.Windows.Forms.DockStyle.Fill;
         this.groupBox1.Location = new System.Drawing.Point(0, 0);
         this.groupBox1.Name = "groupBox1";
         this.groupBox1.Size = new System.Drawing.Size(671, 533);
         this.groupBox1.TabIndex = 18;
         this.groupBox1.TabStop = false;
         this.groupBox1.Text = "Reservation Options";
         // 
         // vialsGridRecordNavigationControl
         // 
         this.vialsGridRecordNavigationControl.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                     | System.Windows.Forms.AnchorStyles.Left)
                     | System.Windows.Forms.AnchorStyles.Right)));
         this.vialsGridRecordNavigationControl.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
         this.vialsGridRecordNavigationControl.Controls.Add(this.reservationGridDataBoundGrid);
         this.vialsGridRecordNavigationControl.Font = new System.Drawing.Font("Verdana", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Pixel);
         this.vialsGridRecordNavigationControl.Location = new System.Drawing.Point(6, 19);
         this.vialsGridRecordNavigationControl.MaxRecord = 0;
         this.vialsGridRecordNavigationControl.Name = "vialsGridRecordNavigationControl";
         this.vialsGridRecordNavigationControl.NavigationBarWidth = 300;
         this.vialsGridRecordNavigationControl.ShowToolTips = true;
         this.vialsGridRecordNavigationControl.Size = new System.Drawing.Size(659, 486);
         this.vialsGridRecordNavigationControl.SplitBars = Syncfusion.Windows.Forms.DynamicSplitBars.None;
         this.vialsGridRecordNavigationControl.TabIndex = 1064;
         this.vialsGridRecordNavigationControl.Text = "gridRecordNavigationControl1";
         this.vialsGridRecordNavigationControl.ThemesEnabled = false;
         // 
         // reservationGridDataBoundGrid
         // 
         this.reservationGridDataBoundGrid.ActivateCurrentCellBehavior = Syncfusion.Windows.Forms.Grid.GridCellActivateAction.DblClickOnCell;
         this.reservationGridDataBoundGrid.AllowDragSelectedCols = true;
         this.reservationGridDataBoundGrid.AllowResizeToFit = false;
         this.reservationGridDataBoundGrid.AllowSelection = ((Syncfusion.Windows.Forms.Grid.GridSelectionFlags)(((((Syncfusion.Windows.Forms.Grid.GridSelectionFlags.Row | Syncfusion.Windows.Forms.Grid.GridSelectionFlags.Multiple)
                     | Syncfusion.Windows.Forms.Grid.GridSelectionFlags.Shift)
                     | Syncfusion.Windows.Forms.Grid.GridSelectionFlags.Keyboard)
                     | Syncfusion.Windows.Forms.Grid.GridSelectionFlags.AlphaBlend)));
         this.reservationGridDataBoundGrid.BackColor = System.Drawing.Color.White;
         gridBaseStyle21.Name = "Row Header";
         gridBaseStyle21.StyleInfo.BaseStyle = "Header";
         gridBaseStyle21.StyleInfo.CellType = "RowHeaderCell";
         gridBaseStyle21.StyleInfo.Enabled = true;
         gridBaseStyle21.StyleInfo.HorizontalAlignment = Syncfusion.Windows.Forms.Grid.GridHorizontalAlignment.Left;
         gridBaseStyle22.Name = "Column Header";
         gridBaseStyle22.StyleInfo.BaseStyle = "Header";
         gridBaseStyle22.StyleInfo.CellType = "ColumnHeaderCell";
         gridBaseStyle22.StyleInfo.Enabled = false;
         gridBaseStyle22.StyleInfo.Font.Bold = true;
         gridBaseStyle22.StyleInfo.HorizontalAlignment = Syncfusion.Windows.Forms.Grid.GridHorizontalAlignment.Center;
         gridBaseStyle23.Name = "Standard";
         gridBaseStyle23.StyleInfo.Borders.Bottom = new Syncfusion.Windows.Forms.Grid.GridBorder(Syncfusion.Windows.Forms.Grid.GridBorderStyle.Solid, System.Drawing.SystemColors.Control, Syncfusion.Windows.Forms.Grid.GridBorderWeight.ExtraThin);
         gridBaseStyle23.StyleInfo.Borders.Right = new Syncfusion.Windows.Forms.Grid.GridBorder(Syncfusion.Windows.Forms.Grid.GridBorderStyle.Solid, System.Drawing.SystemColors.Control, Syncfusion.Windows.Forms.Grid.GridBorderWeight.ExtraThin);
         gridBaseStyle23.StyleInfo.CheckBoxOptions.CheckedValue = "True";
         gridBaseStyle23.StyleInfo.CheckBoxOptions.UncheckedValue = "False";
         gridBaseStyle23.StyleInfo.Interior = new Syncfusion.Drawing.BrushInfo(System.Drawing.SystemColors.Window);
         gridBaseStyle24.Name = "Header";
         gridBaseStyle24.StyleInfo.Borders.Bottom = new Syncfusion.Windows.Forms.Grid.GridBorder(Syncfusion.Windows.Forms.Grid.GridBorderStyle.Standard, System.Drawing.Color.Black);
         gridBaseStyle24.StyleInfo.Borders.Left = new Syncfusion.Windows.Forms.Grid.GridBorder(Syncfusion.Windows.Forms.Grid.GridBorderStyle.None);
         gridBaseStyle24.StyleInfo.Borders.Right = new Syncfusion.Windows.Forms.Grid.GridBorder(Syncfusion.Windows.Forms.Grid.GridBorderStyle.Standard, System.Drawing.Color.Black);
         gridBaseStyle24.StyleInfo.Borders.Top = new Syncfusion.Windows.Forms.Grid.GridBorder(Syncfusion.Windows.Forms.Grid.GridBorderStyle.None);
         gridBaseStyle24.StyleInfo.CellType = "Header";
         gridBaseStyle24.StyleInfo.Font.Bold = true;
         gridBaseStyle24.StyleInfo.Font.Facename = "Verdana";
         gridBaseStyle24.StyleInfo.Interior = new Syncfusion.Drawing.BrushInfo(System.Drawing.SystemColors.Control);
         gridBaseStyle24.StyleInfo.VerticalAlignment = Syncfusion.Windows.Forms.Grid.GridVerticalAlignment.Middle;
         this.reservationGridDataBoundGrid.BaseStylesMap.AddRange(new Syncfusion.Windows.Forms.Grid.GridBaseStyle[] {
            gridBaseStyle21,
            gridBaseStyle22,
            gridBaseStyle23,
            gridBaseStyle24});
         this.reservationGridDataBoundGrid.ControllerOptions = ((Syncfusion.Windows.Forms.Grid.GridControllerOptions)((((((Syncfusion.Windows.Forms.Grid.GridControllerOptions.ClickCells | Syncfusion.Windows.Forms.Grid.GridControllerOptions.DragSelectRowOrColumn)
                     | Syncfusion.Windows.Forms.Grid.GridControllerOptions.OleDropTarget)
                     | Syncfusion.Windows.Forms.Grid.GridControllerOptions.SelectCells)
                     | Syncfusion.Windows.Forms.Grid.GridControllerOptions.ExcelLikeSelection)
                     | Syncfusion.Windows.Forms.Grid.GridControllerOptions.ResizeCells)));
         this.reservationGridDataBoundGrid.DataMember = "";
         this.reservationGridDataBoundGrid.DataSource = this.ReservationDataTableBindingSource;
         this.reservationGridDataBoundGrid.FillSplitterPane = true;
         this.reservationGridDataBoundGrid.Font = new System.Drawing.Font("Verdana", 8.25F);
         this.reservationGridDataBoundGrid.Location = new System.Drawing.Point(0, 0);
         this.reservationGridDataBoundGrid.MinResizeRowSize = 5;
         this.reservationGridDataBoundGrid.Name = "reservationGridDataBoundGrid";
         this.reservationGridDataBoundGrid.OptimizeInsertRemoveCells = true;
         this.reservationGridDataBoundGrid.Properties.BackgroundColor = System.Drawing.Color.WhiteSmoke;
         this.reservationGridDataBoundGrid.Properties.Buttons3D = false;
         this.reservationGridDataBoundGrid.ResizeRowsBehavior = ((Syncfusion.Windows.Forms.Grid.GridResizeCellsBehavior)(((Syncfusion.Windows.Forms.Grid.GridResizeCellsBehavior.ResizeAll | Syncfusion.Windows.Forms.Grid.GridResizeCellsBehavior.OutlineHeaders)
                     | Syncfusion.Windows.Forms.Grid.GridResizeCellsBehavior.OutlineBounds)));
         this.reservationGridDataBoundGrid.ShowCurrentCellBorderBehavior = Syncfusion.Windows.Forms.Grid.GridShowCurrentCellBorder.GrayWhenLostFocus;
         this.reservationGridDataBoundGrid.SimpleGridBoundColumns.AddRange(new Syncfusion.Windows.Forms.Grid.GridBoundColumn[] {
            this.minGridBoundColumn,
            this.maxGridBoundColumn,
            this.statusGridBoundColumn});
         this.reservationGridDataBoundGrid.Size = new System.Drawing.Size(640, 467);
         this.reservationGridDataBoundGrid.SmartSizeBox = false;
         this.reservationGridDataBoundGrid.SortBehavior = Syncfusion.Windows.Forms.Grid.GridSortBehavior.DoubleClick;
         gridStyleInfo6.Font.Bold = false;
         gridStyleInfo6.Font.Facename = "Verdana";
         gridStyleInfo6.Font.Italic = false;
         gridStyleInfo6.Font.Size = 8.25F;
         gridStyleInfo6.Font.Strikeout = false;
         gridStyleInfo6.Font.Underline = false;
         gridStyleInfo6.Interior = new Syncfusion.Drawing.BrushInfo(System.Drawing.SystemColors.Window);
         this.reservationGridDataBoundGrid.TableStyle = gridStyleInfo6;
         this.reservationGridDataBoundGrid.UseListChangedEvent = true;
         // 
         // ReservationDataTableBindingSource
         // 
         this.ReservationDataTableBindingSource.DataSource = typeof(Jnj.ThirdDimension.Data.BarcodeSeries.BSDataSet.ReservationDataTable);
         // 
         // minGridBoundColumn
         // 
         this.minGridBoundColumn.HeaderText = "Min Value";
         this.minGridBoundColumn.MappingName = "MIN_VALUE";
         this.minGridBoundColumn.StyleInfo.CellValueType = typeof(decimal);
         this.minGridBoundColumn.StyleInfo.Format = "G";
         this.minGridBoundColumn.StyleInfo.HorizontalAlignment = Syncfusion.Windows.Forms.Grid.GridHorizontalAlignment.Right;
         this.minGridBoundColumn.StyleInfo.RightToLeft = System.Windows.Forms.RightToLeft.No;
         // 
         // maxGridBoundColumn
         // 
         this.maxGridBoundColumn.HeaderText = "Max Value";
         this.maxGridBoundColumn.MappingName = "MAX_VALUE";
         this.maxGridBoundColumn.StyleInfo.CellValueType = typeof(decimal);
         this.maxGridBoundColumn.StyleInfo.Format = "G";
         this.maxGridBoundColumn.StyleInfo.HorizontalAlignment = Syncfusion.Windows.Forms.Grid.GridHorizontalAlignment.Right;
         this.maxGridBoundColumn.StyleInfo.RightToLeft = System.Windows.Forms.RightToLeft.No;
         // 
         // statusGridBoundColumn
         // 
         this.statusGridBoundColumn.HeaderText = "Status";
         this.statusGridBoundColumn.MappingName = "RESERVATION_STATUS_ID";
         this.statusGridBoundColumn.StyleInfo.CellType = "ComboBox";
         this.statusGridBoundColumn.StyleInfo.CellValueType = typeof(decimal);
         // 
         // refreshButton
         // 
         this.refreshButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
         this.refreshButton.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
         this.refreshButton.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F);
         this.refreshButton.Image = ((System.Drawing.Image)(resources.GetObject("refreshButton.Image")));
         this.refreshButton.Location = new System.Drawing.Point(570, 27);
         this.refreshButton.Name = "refreshButton";
         this.refreshButton.Size = new System.Drawing.Size(23, 23);
         this.refreshButton.TabIndex = 1078;
         this.refreshButton.TextAlign = System.Drawing.ContentAlignment.TopCenter;
         this.toolTip1.SetToolTip(this.refreshButton, "Clear template.");
         this.refreshButton.UseVisualStyleBackColor = true;
         this.refreshButton.Click += new System.EventHandler(this.button1_Click);
         // 
         // toolPanel
         // 
         this.toolPanel.Controls.Add(this.textDragLabel);
         this.toolPanel.Controls.Add(this.yearDragLabel);
         this.toolPanel.Controls.Add(this.monthDragLabel);
         this.toolPanel.Controls.Add(this.seriesDragLabel);
         this.toolPanel.Controls.Add(this.dayDragLabel);
         this.toolPanel.Controls.Add(this.weekDragLabel);
         this.toolPanel.Location = new System.Drawing.Point(97, 6);
         this.toolPanel.Name = "toolPanel";
         this.toolPanel.Size = new System.Drawing.Size(381, 22);
         this.toolPanel.TabIndex = 1079;
         // 
         // textDragLabel
         // 
         this.textDragLabel.AutoSize = true;
         this.textDragLabel.Font = new System.Drawing.Font("Verdana", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Pixel);
         this.textDragLabel.LabelText = "TEXT";
         this.textDragLabel.Location = new System.Drawing.Point(3, 3);
         this.textDragLabel.Name = "textDragLabel";
         this.textDragLabel.Size = new System.Drawing.Size(49, 17);
         this.textDragLabel.TabIndex = 23;
         this.textDragLabel.LabelDoubleClick += new System.EventHandler(this.dragLabel_DoubleClick);
         // 
         // yearDragLabel
         // 
         this.yearDragLabel.AutoSize = true;
         this.yearDragLabel.Font = new System.Drawing.Font("Verdana", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Pixel);
         this.yearDragLabel.LabelText = "YEAR";
         this.yearDragLabel.Location = new System.Drawing.Point(140, 3);
         this.yearDragLabel.Name = "yearDragLabel";
         this.yearDragLabel.Size = new System.Drawing.Size(54, 17);
         this.yearDragLabel.TabIndex = 27;
         this.yearDragLabel.LabelDoubleClick += new System.EventHandler(this.dragLabel_DoubleClick);
         // 
         // monthDragLabel
         // 
         this.monthDragLabel.AutoSize = true;
         this.monthDragLabel.Font = new System.Drawing.Font("Verdana", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Pixel);
         this.monthDragLabel.LabelText = "MONTH";
         this.monthDragLabel.Location = new System.Drawing.Point(200, 3);
         this.monthDragLabel.Name = "monthDragLabel";
         this.monthDragLabel.Size = new System.Drawing.Size(62, 17);
         this.monthDragLabel.TabIndex = 29;
         this.monthDragLabel.LabelDoubleClick += new System.EventHandler(this.dragLabel_DoubleClick);
         // 
         // seriesDragLabel
         // 
         this.seriesDragLabel.AutoSize = true;
         this.seriesDragLabel.Font = new System.Drawing.Font("Verdana", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Pixel);
         this.seriesDragLabel.LabelText = "SERIES #";
         this.seriesDragLabel.Location = new System.Drawing.Point(58, 3);
         this.seriesDragLabel.Name = "seriesDragLabel";
         this.seriesDragLabel.Size = new System.Drawing.Size(76, 17);
         this.seriesDragLabel.TabIndex = 24;
         this.seriesDragLabel.LabelDoubleClick += new System.EventHandler(this.dragLabel_DoubleClick);
         // 
         // dayDragLabel
         // 
         this.dayDragLabel.AutoSize = true;
         this.dayDragLabel.Font = new System.Drawing.Font("Verdana", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Pixel);
         this.dayDragLabel.LabelText = "DAY";
         this.dayDragLabel.Location = new System.Drawing.Point(330, 3);
         this.dayDragLabel.Name = "dayDragLabel";
         this.dayDragLabel.Size = new System.Drawing.Size(48, 17);
         this.dayDragLabel.TabIndex = 33;
         this.dayDragLabel.LabelDoubleClick += new System.EventHandler(this.dragLabel_DoubleClick);
         // 
         // weekDragLabel
         // 
         this.weekDragLabel.AutoSize = true;
         this.weekDragLabel.Font = new System.Drawing.Font("Verdana", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Pixel);
         this.weekDragLabel.LabelText = "WEEK";
         this.weekDragLabel.Location = new System.Drawing.Point(268, 3);
         this.weekDragLabel.Name = "weekDragLabel";
         this.weekDragLabel.Size = new System.Drawing.Size(56, 17);
         this.weekDragLabel.TabIndex = 31;
         this.weekDragLabel.LabelDoubleClick += new System.EventHandler(this.dragLabel_DoubleClick);
         // 
         // SeriesControl
         // 
         this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
         this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
         this.Controls.Add(this.seriesTabControl);
         this.MinimumSize = new System.Drawing.Size(472, 362);
         this.Name = "SeriesControl";
         this.Size = new System.Drawing.Size(671, 532);
         this.groupBox2.ResumeLayout(false);
         this.desktopOuterPanel.ResumeLayout(false);
         this.desktopOuterPanel.PerformLayout();
         this.examplePanel.ResumeLayout(false);
         this.groupBox3.ResumeLayout(false);
         this.groupBox3.PerformLayout();
         ((System.ComponentModel.ISupportInitialize)(this.startRangeTextBox)).EndInit();
         this.dbGroupBox.ResumeLayout(false);
         this.dbGroupBox.PerformLayout();
         ((System.ComponentModel.ISupportInitialize)(this.seriesTabControl)).EndInit();
         this.seriesTabControl.ResumeLayout(false);
         this.definitionTabPage.ResumeLayout(false);
         this.reservationTabPage.ResumeLayout(false);
         this.groupBox1.ResumeLayout(false);
         this.vialsGridRecordNavigationControl.ResumeLayout(false);
         ((System.ComponentModel.ISupportInitialize)(this.reservationGridDataBoundGrid)).EndInit();
         ((System.ComponentModel.ISupportInitialize)(this.ReservationDataTableBindingSource)).EndInit();
         this.toolPanel.ResumeLayout(false);
         this.toolPanel.PerformLayout();
         this.ResumeLayout(false);

      }

      #endregion

      private System.Windows.Forms.GroupBox groupBox2;
      private System.Windows.Forms.Panel examplePanel;
      private System.Windows.Forms.RichTextBox exampleRichTextBox;
      private System.Windows.Forms.Label label4;
      private System.Windows.Forms.Panel desktopPanel;
      private System.Windows.Forms.GroupBox groupBox3;
      private Syncfusion.Windows.Forms.Tools.IntegerTextBox startRangeTextBox;
      private System.Windows.Forms.TextBox seriesNameTextBox;
      private System.Windows.Forms.Label label2;
      private System.Windows.Forms.Label label3;
      private System.Windows.Forms.GroupBox dbGroupBox;
      private Syncfusion.Windows.Forms.Tools.TabControlAdv seriesTabControl;
      private Syncfusion.Windows.Forms.Tools.TabPageAdv definitionTabPage;
      protected System.Windows.Forms.Label label7;
      private Syncfusion.Windows.Forms.Tools.TabPageAdv reservationTabPage;
      private System.Windows.Forms.GroupBox groupBox1;
      private Syncfusion.Windows.Forms.Grid.GridRecordNavigationControl vialsGridRecordNavigationControl;
      private Jnj.Windows.Forms.SimpleGrid reservationGridDataBoundGrid;
      private Jnj.Windows.Forms.SimpleGridBoundColumn minGridBoundColumn;
      private System.Windows.Forms.BindingSource ReservationDataTableBindingSource;
      private Jnj.Windows.Forms.SimpleGridBoundColumn maxGridBoundColumn;
      private Jnj.Windows.Forms.SimpleGridBoundColumn statusGridBoundColumn;
      private System.Windows.Forms.Label label6;
      private System.Windows.Forms.TextBox queryTextBox;
      private System.Windows.Forms.TextBox sequenceTextBox;
      private System.Windows.Forms.TextBox connStringTextBox;
      private System.Windows.Forms.Label label9;
      private System.Windows.Forms.Label label8;
      private System.Windows.Forms.Button newSeriesButton;
      private System.Windows.Forms.ImageList ilButtonsState;
      private System.Windows.Forms.Button findSeriesButton;
      private System.Windows.Forms.Label label1;
      private System.Windows.Forms.RadioButton neverRadioButton;
      private System.Windows.Forms.RadioButton weekNumRadioButton;
      private System.Windows.Forms.RadioButton monthRadioButton;
      private System.Windows.Forms.RadioButton yearRadioButton;
      private System.Windows.Forms.RadioButton dayRadioButton;
      private Jnj.ThirdDimension.Controls.BarcodeSeries.UI.DraggableLabel textDragLabel;
      private Jnj.ThirdDimension.Controls.BarcodeSeries.UI.DraggableLabel dayDragLabel;
      private Jnj.ThirdDimension.Controls.BarcodeSeries.UI.DraggableLabel weekDragLabel;
      private Jnj.ThirdDimension.Controls.BarcodeSeries.UI.DraggableLabel monthDragLabel;
      private Jnj.ThirdDimension.Controls.BarcodeSeries.UI.DraggableLabel seriesDragLabel;
      private System.Windows.Forms.Label label14;
      private System.Windows.Forms.Panel desktopOuterPanel;
      private Jnj.ThirdDimension.Controls.BarcodeSeries.UI.DraggableLabel yearDragLabel;
      private System.Windows.Forms.Button refreshButton;
      private System.Windows.Forms.Panel toolPanel;
      private System.Windows.Forms.ToolTip toolTip1;
   }
}
