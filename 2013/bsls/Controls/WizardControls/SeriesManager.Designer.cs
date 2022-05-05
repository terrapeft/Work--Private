using Jnj.ThirdDimension.Data.BarcodeSeries;
namespace Jnj.ThirdDimension.Controls.BarcodeSeries
{
   partial class SeriesManager
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
         System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(SeriesManager));
         Syncfusion.Windows.Forms.Grid.GridBaseStyle gridBaseStyle1 = new Syncfusion.Windows.Forms.Grid.GridBaseStyle();
         Syncfusion.Windows.Forms.Grid.GridBaseStyle gridBaseStyle2 = new Syncfusion.Windows.Forms.Grid.GridBaseStyle();
         Syncfusion.Windows.Forms.Grid.GridBaseStyle gridBaseStyle3 = new Syncfusion.Windows.Forms.Grid.GridBaseStyle();
         Syncfusion.Windows.Forms.Grid.GridBaseStyle gridBaseStyle4 = new Syncfusion.Windows.Forms.Grid.GridBaseStyle();
         Syncfusion.Windows.Forms.Grid.GridStyleInfo gridStyleInfo1 = new Syncfusion.Windows.Forms.Grid.GridStyleInfo();
         this.templateGroupBox = new System.Windows.Forms.GroupBox();
         this.seriesTemplateEditor = new Jnj.ThirdDimension.Controls.BarcodeSeries.SeriesTemplateEditor();
         this.ilButtonsState = new System.Windows.Forms.ImageList(this.components);
         this.groupBox3 = new System.Windows.Forms.GroupBox();
         this.label3 = new System.Windows.Forms.Label();
         this.seriesNameTextBox = new System.Windows.Forms.TextBox();
         this.expirationPanel = new System.Windows.Forms.Panel();
         this.neverRadioButton = new System.Windows.Forms.RadioButton();
         this.label4 = new System.Windows.Forms.Label();
         this.startRangeTextBox = new Syncfusion.Windows.Forms.Tools.IntegerTextBox();
         this.weekNumRadioButton = new System.Windows.Forms.RadioButton();
         this.dayRadioButton = new System.Windows.Forms.RadioButton();
         this.monthRadioButton = new System.Windows.Forms.RadioButton();
         this.yearRadioButton = new System.Windows.Forms.RadioButton();
         this.label1 = new System.Windows.Forms.Label();
         this.findSeriesButton = new System.Windows.Forms.Button();
         this.newSeriesButton = new System.Windows.Forms.Button();
         this.label2 = new System.Windows.Forms.Label();
         this.dbGroupBox = new System.Windows.Forms.GroupBox();
         this.tableAccTextBox = new System.Windows.Forms.TextBox();
         this.label10 = new System.Windows.Forms.Label();
         this.seqAccTextBox = new System.Windows.Forms.TextBox();
         this.label11 = new System.Windows.Forms.Label();
         this.tableRSTextBox = new System.Windows.Forms.TextBox();
         this.label5 = new System.Windows.Forms.Label();
         this.seqRSTextBox = new System.Windows.Forms.TextBox();
         this.queryTextBox = new System.Windows.Forms.TextBox();
         this.sequenceTextBox = new System.Windows.Forms.TextBox();
         this.label9 = new System.Windows.Forms.Label();
         this.label8 = new System.Windows.Forms.Label();
         this.label6 = new System.Windows.Forms.Label();
         this.seriesTabControl = new Syncfusion.Windows.Forms.Tools.TabControlAdv();
         this.definitionTabPage = new Syncfusion.Windows.Forms.Tools.TabPageAdv();
         this.label7 = new System.Windows.Forms.Label();
         this.reservationTabPage = new Syncfusion.Windows.Forms.Tools.TabPageAdv();
         this.groupBox1 = new System.Windows.Forms.GroupBox();
         this.seriesNameLabel = new System.Windows.Forms.Label();
         this.vialsGridRecordNavigationControl = new Syncfusion.Windows.Forms.Grid.GridRecordNavigationControl();
         this.reservationGridDataBoundGrid = new Jnj.Windows.Forms.SimpleGrid();
         this.descriptionGridBoundColumn = new Jnj.Windows.Forms.SimpleGridBoundColumn();
         this.minGridBoundColumn = new Jnj.Windows.Forms.SimpleGridBoundColumn();
         this.maxGridBoundColumn = new Jnj.Windows.Forms.SimpleGridBoundColumn();
         this.statusGridBoundColumn = new Jnj.Windows.Forms.SimpleGridBoundColumn();
         this.toolTip1 = new System.Windows.Forms.ToolTip(this.components);
         dbButton = new System.Windows.Forms.Button();
         this.templateGroupBox.SuspendLayout();
         this.groupBox3.SuspendLayout();
         this.expirationPanel.SuspendLayout();
         ((System.ComponentModel.ISupportInitialize)(this.startRangeTextBox)).BeginInit();
         this.dbGroupBox.SuspendLayout();
         ((System.ComponentModel.ISupportInitialize)(this.seriesTabControl)).BeginInit();
         this.seriesTabControl.SuspendLayout();
         this.definitionTabPage.SuspendLayout();
         this.reservationTabPage.SuspendLayout();
         this.groupBox1.SuspendLayout();
         this.vialsGridRecordNavigationControl.SuspendLayout();
         ((System.ComponentModel.ISupportInitialize)(this.reservationGridDataBoundGrid)).BeginInit();
         this.SuspendLayout();
         // 
         // dbButton
         // 
         dbButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
         dbButton.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
         dbButton.Image = ((System.Drawing.Image)(resources.GetObject("dbButton.Image")));
         dbButton.Location = new System.Drawing.Point(573, 43);
         dbButton.Name = "dbButton";
         dbButton.Size = new System.Drawing.Size(23, 23);
         dbButton.TabIndex = 17;
         this.toolTip1.SetToolTip(dbButton, "Edit database settings.");
         dbButton.UseVisualStyleBackColor = true;
         dbButton.Click += new System.EventHandler(this.dbButton_Click);
         // 
         // templateGroupBox
         // 
         this.templateGroupBox.Controls.Add(this.seriesTemplateEditor);
         this.templateGroupBox.Dock = System.Windows.Forms.DockStyle.Fill;
         this.templateGroupBox.Enabled = false;
         this.templateGroupBox.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
         this.templateGroupBox.Location = new System.Drawing.Point(3, 106);
         this.templateGroupBox.Name = "templateGroupBox";
         this.templateGroupBox.Size = new System.Drawing.Size(665, 238);
         this.templateGroupBox.TabIndex = 27;
         this.templateGroupBox.TabStop = false;
         this.templateGroupBox.Text = "Label Series Template";
         // 
         // seriesTemplateEditor
         // 
         this.seriesTemplateEditor.Dock = System.Windows.Forms.DockStyle.Fill;
         this.seriesTemplateEditor.EditMode = false;
         this.seriesTemplateEditor.Location = new System.Drawing.Point(3, 16);
         this.seriesTemplateEditor.MinimumSize = new System.Drawing.Size(586, 198);
         this.seriesTemplateEditor.Name = "seriesTemplateEditor";
         this.seriesTemplateEditor.RangeStart = 0;
         this.seriesTemplateEditor.Size = new System.Drawing.Size(659, 219);
         this.seriesTemplateEditor.TabIndex = 27;
         this.seriesTemplateEditor.TabStop = false;
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
         this.groupBox3.Controls.Add(this.label3);
         this.groupBox3.Controls.Add(this.seriesNameTextBox);
         this.groupBox3.Controls.Add(this.expirationPanel);
         this.groupBox3.Controls.Add(this.label1);
         this.groupBox3.Controls.Add(this.findSeriesButton);
         this.groupBox3.Controls.Add(this.newSeriesButton);
         this.groupBox3.Controls.Add(this.label2);
         this.groupBox3.Dock = System.Windows.Forms.DockStyle.Top;
         this.groupBox3.Location = new System.Drawing.Point(3, 3);
         this.groupBox3.Name = "groupBox3";
         this.groupBox3.Size = new System.Drawing.Size(665, 103);
         this.groupBox3.TabIndex = 28;
         this.groupBox3.TabStop = false;
         this.groupBox3.Text = "Label Series";
         // 
         // label3
         // 
         this.label3.AutoSize = true;
         this.label3.Location = new System.Drawing.Point(40, 47);
         this.label3.Name = "label3";
         this.label3.Size = new System.Drawing.Size(59, 13);
         this.label3.TabIndex = 12;
         this.label3.Text = "First Value:";
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
         // expirationPanel
         // 
         this.expirationPanel.Controls.Add(this.neverRadioButton);
         this.expirationPanel.Controls.Add(this.label4);
         this.expirationPanel.Controls.Add(this.startRangeTextBox);
         this.expirationPanel.Controls.Add(this.weekNumRadioButton);
         this.expirationPanel.Controls.Add(this.dayRadioButton);
         this.expirationPanel.Controls.Add(this.monthRadioButton);
         this.expirationPanel.Controls.Add(this.yearRadioButton);
         this.expirationPanel.Enabled = false;
         this.expirationPanel.Location = new System.Drawing.Point(105, 39);
         this.expirationPanel.Name = "expirationPanel";
         this.expirationPanel.Size = new System.Drawing.Size(445, 58);
         this.expirationPanel.TabIndex = 1081;
         // 
         // neverRadioButton
         // 
         this.neverRadioButton.AutoSize = true;
         this.neverRadioButton.Checked = true;
         this.neverRadioButton.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
         this.neverRadioButton.Location = new System.Drawing.Point(0, 32);
         this.neverRadioButton.Name = "neverRadioButton";
         this.neverRadioButton.Size = new System.Drawing.Size(53, 17);
         this.neverRadioButton.TabIndex = 5;
         this.neverRadioButton.TabStop = true;
         this.neverRadioButton.Text = "Never";
         this.neverRadioButton.UseVisualStyleBackColor = true;
         // 
         // label4
         // 
         this.label4.AutoSize = true;
         this.label4.Location = new System.Drawing.Point(165, 8);
         this.label4.Name = "label4";
         this.label4.Size = new System.Drawing.Size(157, 13);
         this.label4.TabIndex = 1082;
         this.label4.Text = "(for labels using numeric values)";
         // 
         // startRangeTextBox
         // 
         this.startRangeTextBox.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
         this.startRangeTextBox.IntegerValue = ((long)(1));
         this.startRangeTextBox.Location = new System.Drawing.Point(0, 6);
         this.startRangeTextBox.Name = "startRangeTextBox";
         this.startRangeTextBox.NullString = "0";
         this.startRangeTextBox.OverflowIndicatorToolTipText = null;
         this.startRangeTextBox.Size = new System.Drawing.Size(159, 20);
         this.startRangeTextBox.TabIndex = 4;
         this.startRangeTextBox.TextChanged += new System.EventHandler(this.startRangeTextBox_TextChanged);
         // 
         // weekNumRadioButton
         // 
         this.weekNumRadioButton.AutoSize = true;
         this.weekNumRadioButton.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
         this.weekNumRadioButton.Location = new System.Drawing.Point(188, 32);
         this.weekNumRadioButton.Name = "weekNumRadioButton";
         this.weekNumRadioButton.Size = new System.Drawing.Size(60, 17);
         this.weekNumRadioButton.TabIndex = 8;
         this.weekNumRadioButton.Text = "Weekly";
         this.weekNumRadioButton.UseVisualStyleBackColor = true;
         // 
         // dayRadioButton
         // 
         this.dayRadioButton.AutoSize = true;
         this.dayRadioButton.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
         this.dayRadioButton.Location = new System.Drawing.Point(255, 32);
         this.dayRadioButton.Name = "dayRadioButton";
         this.dayRadioButton.Size = new System.Drawing.Size(47, 17);
         this.dayRadioButton.TabIndex = 9;
         this.dayRadioButton.Text = "Daily";
         this.dayRadioButton.UseVisualStyleBackColor = true;
         // 
         // monthRadioButton
         // 
         this.monthRadioButton.AutoSize = true;
         this.monthRadioButton.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
         this.monthRadioButton.Location = new System.Drawing.Point(120, 32);
         this.monthRadioButton.Name = "monthRadioButton";
         this.monthRadioButton.Size = new System.Drawing.Size(61, 17);
         this.monthRadioButton.TabIndex = 7;
         this.monthRadioButton.Text = "Monthly";
         this.monthRadioButton.UseVisualStyleBackColor = true;
         // 
         // yearRadioButton
         // 
         this.yearRadioButton.AutoSize = true;
         this.yearRadioButton.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
         this.yearRadioButton.Location = new System.Drawing.Point(60, 32);
         this.yearRadioButton.Name = "yearRadioButton";
         this.yearRadioButton.Size = new System.Drawing.Size(53, 17);
         this.yearRadioButton.TabIndex = 6;
         this.yearRadioButton.Text = "Yearly";
         this.yearRadioButton.UseVisualStyleBackColor = true;
         // 
         // label1
         // 
         this.label1.AutoSize = true;
         this.label1.Location = new System.Drawing.Point(7, 73);
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
         this.findSeriesButton.TabIndex = 3;
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
         this.newSeriesButton.TabIndex = 2;
         this.newSeriesButton.TextAlign = System.Drawing.ContentAlignment.TopCenter;
         this.toolTip1.SetToolTip(this.newSeriesButton, "Add new series.");
         this.newSeriesButton.UseVisualStyleBackColor = true;
         this.newSeriesButton.Click += new System.EventHandler(this.newSeriesButton_Click);
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
         // dbGroupBox
         // 
         this.dbGroupBox.Controls.Add(this.tableAccTextBox);
         this.dbGroupBox.Controls.Add(this.label10);
         this.dbGroupBox.Controls.Add(this.seqAccTextBox);
         this.dbGroupBox.Controls.Add(this.label11);
         this.dbGroupBox.Controls.Add(this.tableRSTextBox);
         this.dbGroupBox.Controls.Add(this.label5);
         this.dbGroupBox.Controls.Add(this.seqRSTextBox);
         this.dbGroupBox.Controls.Add(dbButton);
         this.dbGroupBox.Controls.Add(this.queryTextBox);
         this.dbGroupBox.Controls.Add(this.sequenceTextBox);
         this.dbGroupBox.Controls.Add(this.label9);
         this.dbGroupBox.Controls.Add(this.label8);
         this.dbGroupBox.Controls.Add(this.label6);
         this.dbGroupBox.Dock = System.Windows.Forms.DockStyle.Bottom;
         this.dbGroupBox.Enabled = false;
         this.dbGroupBox.Location = new System.Drawing.Point(3, 344);
         this.dbGroupBox.Name = "dbGroupBox";
         this.dbGroupBox.Size = new System.Drawing.Size(665, 195);
         this.dbGroupBox.TabIndex = 29;
         this.dbGroupBox.TabStop = false;
         this.dbGroupBox.Text = "Database Settings";
         // 
         // tableAccTextBox
         // 
         this.tableAccTextBox.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
         this.tableAccTextBox.BackColor = System.Drawing.SystemColors.Control;
         this.tableAccTextBox.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
         this.tableAccTextBox.Location = new System.Drawing.Point(333, 90);
         this.tableAccTextBox.Name = "tableAccTextBox";
         this.tableAccTextBox.ReadOnly = true;
         this.tableAccTextBox.Size = new System.Drawing.Size(217, 20);
         this.tableAccTextBox.TabIndex = 24;
         // 
         // label10
         // 
         this.label10.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
         this.label10.AutoSize = true;
         this.label10.Location = new System.Drawing.Point(330, 74);
         this.label10.Name = "label10";
         this.label10.Size = new System.Drawing.Size(50, 13);
         this.label10.TabIndex = 23;
         this.label10.Text = "Account:";
         // 
         // seqAccTextBox
         // 
         this.seqAccTextBox.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
         this.seqAccTextBox.BackColor = System.Drawing.SystemColors.Control;
         this.seqAccTextBox.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
         this.seqAccTextBox.Location = new System.Drawing.Point(333, 46);
         this.seqAccTextBox.Name = "seqAccTextBox";
         this.seqAccTextBox.ReadOnly = true;
         this.seqAccTextBox.Size = new System.Drawing.Size(217, 20);
         this.seqAccTextBox.TabIndex = 22;
         // 
         // label11
         // 
         this.label11.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
         this.label11.AutoSize = true;
         this.label11.Location = new System.Drawing.Point(330, 30);
         this.label11.Name = "label11";
         this.label11.Size = new System.Drawing.Size(50, 13);
         this.label11.TabIndex = 21;
         this.label11.Text = "Account:";
         // 
         // tableRSTextBox
         // 
         this.tableRSTextBox.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left)
                     | System.Windows.Forms.AnchorStyles.Right)));
         this.tableRSTextBox.BackColor = System.Drawing.SystemColors.Control;
         this.tableRSTextBox.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
         this.tableRSTextBox.Location = new System.Drawing.Point(105, 90);
         this.tableRSTextBox.Name = "tableRSTextBox";
         this.tableRSTextBox.ReadOnly = true;
         this.tableRSTextBox.Size = new System.Drawing.Size(219, 20);
         this.tableRSTextBox.TabIndex = 20;
         // 
         // label5
         // 
         this.label5.AutoSize = true;
         this.label5.Location = new System.Drawing.Point(102, 74);
         this.label5.Name = "label5";
         this.label5.Size = new System.Drawing.Size(127, 13);
         this.label5.TabIndex = 19;
         this.label5.Text = "Target Resource System:";
         // 
         // seqRSTextBox
         // 
         this.seqRSTextBox.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left)
                     | System.Windows.Forms.AnchorStyles.Right)));
         this.seqRSTextBox.BackColor = System.Drawing.SystemColors.Control;
         this.seqRSTextBox.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
         this.seqRSTextBox.Location = new System.Drawing.Point(105, 46);
         this.seqRSTextBox.Name = "seqRSTextBox";
         this.seqRSTextBox.ReadOnly = true;
         this.seqRSTextBox.Size = new System.Drawing.Size(219, 20);
         this.seqRSTextBox.TabIndex = 18;
         // 
         // queryTextBox
         // 
         this.queryTextBox.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                     | System.Windows.Forms.AnchorStyles.Left)
                     | System.Windows.Forms.AnchorStyles.Right)));
         this.queryTextBox.BackColor = System.Drawing.SystemColors.Control;
         this.queryTextBox.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
         this.queryTextBox.Location = new System.Drawing.Point(105, 146);
         this.queryTextBox.Multiline = true;
         this.queryTextBox.Name = "queryTextBox";
         this.queryTextBox.ReadOnly = true;
         this.queryTextBox.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
         this.queryTextBox.Size = new System.Drawing.Size(462, 40);
         this.queryTextBox.TabIndex = 15;
         // 
         // sequenceTextBox
         // 
         this.sequenceTextBox.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left)
                     | System.Windows.Forms.AnchorStyles.Right)));
         this.sequenceTextBox.BackColor = System.Drawing.SystemColors.Control;
         this.sequenceTextBox.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
         this.sequenceTextBox.Location = new System.Drawing.Point(105, 120);
         this.sequenceTextBox.Name = "sequenceTextBox";
         this.sequenceTextBox.ReadOnly = true;
         this.sequenceTextBox.Size = new System.Drawing.Size(445, 20);
         this.sequenceTextBox.TabIndex = 14;
         // 
         // label9
         // 
         this.label9.AutoSize = true;
         this.label9.Location = new System.Drawing.Point(12, 148);
         this.label9.Name = "label9";
         this.label9.Size = new System.Drawing.Size(87, 13);
         this.label9.TabIndex = 16;
         this.label9.Text = "Validation Query:";
         // 
         // label8
         // 
         this.label8.AutoSize = true;
         this.label8.Location = new System.Drawing.Point(40, 122);
         this.label8.Name = "label8";
         this.label8.Size = new System.Drawing.Size(59, 13);
         this.label8.TabIndex = 15;
         this.label8.Text = "Sequence:";
         // 
         // label6
         // 
         this.label6.AutoSize = true;
         this.label6.Location = new System.Drawing.Point(102, 30);
         this.label6.Name = "label6";
         this.label6.Size = new System.Drawing.Size(145, 13);
         this.label6.TabIndex = 14;
         this.label6.Text = "Sequence Resource System:";
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
         this.seriesTabControl.Size = new System.Drawing.Size(671, 563);
         this.seriesTabControl.TabIndex = 1037;
         this.seriesTabControl.TabStyle = typeof(Syncfusion.Windows.Forms.Tools.TabRenderer2D);
         this.seriesTabControl.SelectedIndexChanged += new System.EventHandler(this.seriesTabControl_SelectedIndexChanged);
         this.seriesTabControl.SelectedIndexChanging += new Syncfusion.Windows.Forms.Tools.SelectedIndexChangingEventHandler(this.seriesTabControl_SelectedIndexChanging);
         // 
         // definitionTabPage
         // 
         this.definitionTabPage.Controls.Add(this.templateGroupBox);
         this.definitionTabPage.Controls.Add(this.label7);
         this.definitionTabPage.Controls.Add(this.dbGroupBox);
         this.definitionTabPage.Controls.Add(this.groupBox3);
         this.definitionTabPage.Location = new System.Drawing.Point(0, 21);
         this.definitionTabPage.Name = "definitionTabPage";
         this.definitionTabPage.Padding = new System.Windows.Forms.Padding(3);
         this.definitionTabPage.Size = new System.Drawing.Size(671, 542);
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
         this.reservationTabPage.Location = new System.Drawing.Point(0, 21);
         this.reservationTabPage.Name = "reservationTabPage";
         this.reservationTabPage.Size = new System.Drawing.Size(671, 542);
         this.reservationTabPage.TabIndex = 1;
         this.reservationTabPage.Text = "Manage Reservations";
         this.reservationTabPage.ThemesEnabled = false;
         // 
         // groupBox1
         // 
         this.groupBox1.Controls.Add(this.seriesNameLabel);
         this.groupBox1.Controls.Add(this.vialsGridRecordNavigationControl);
         this.groupBox1.Dock = System.Windows.Forms.DockStyle.Fill;
         this.groupBox1.Location = new System.Drawing.Point(0, 0);
         this.groupBox1.Name = "groupBox1";
         this.groupBox1.Size = new System.Drawing.Size(671, 542);
         this.groupBox1.TabIndex = 18;
         this.groupBox1.TabStop = false;
         this.groupBox1.Text = "Reservation Options";
         // 
         // seriesNameLabel
         // 
         this.seriesNameLabel.AutoSize = true;
         this.seriesNameLabel.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold);
         this.seriesNameLabel.Location = new System.Drawing.Point(6, 21);
         this.seriesNameLabel.Name = "seriesNameLabel";
         this.seriesNameLabel.Size = new System.Drawing.Size(78, 13);
         this.seriesNameLabel.TabIndex = 1065;
         this.seriesNameLabel.Text = "Series Name";
         // 
         // vialsGridRecordNavigationControl
         // 
         this.vialsGridRecordNavigationControl.AllowAddNew = false;
         this.vialsGridRecordNavigationControl.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                     | System.Windows.Forms.AnchorStyles.Left)
                     | System.Windows.Forms.AnchorStyles.Right)));
         this.vialsGridRecordNavigationControl.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
         this.vialsGridRecordNavigationControl.Controls.Add(this.reservationGridDataBoundGrid);
         this.vialsGridRecordNavigationControl.Font = new System.Drawing.Font("Verdana", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Pixel);
         this.vialsGridRecordNavigationControl.Location = new System.Drawing.Point(6, 39);
         this.vialsGridRecordNavigationControl.MaxRecord = 0;
         this.vialsGridRecordNavigationControl.Name = "vialsGridRecordNavigationControl";
         this.vialsGridRecordNavigationControl.NavigationBarWidth = 300;
         this.vialsGridRecordNavigationControl.ShowToolTips = true;
         this.vialsGridRecordNavigationControl.Size = new System.Drawing.Size(659, 497);
         this.vialsGridRecordNavigationControl.SplitBars = Syncfusion.Windows.Forms.DynamicSplitBars.None;
         this.vialsGridRecordNavigationControl.TabIndex = 1064;
         this.vialsGridRecordNavigationControl.Text = "gridRecordNavigationControl1";
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
         gridBaseStyle2.StyleInfo.HorizontalAlignment = Syncfusion.Windows.Forms.Grid.GridHorizontalAlignment.Center;
         gridBaseStyle3.Name = "Standard";
         gridBaseStyle3.StyleInfo.Borders.Bottom = new Syncfusion.Windows.Forms.Grid.GridBorder(Syncfusion.Windows.Forms.Grid.GridBorderStyle.Solid, System.Drawing.SystemColors.Control, Syncfusion.Windows.Forms.Grid.GridBorderWeight.ExtraThin);
         gridBaseStyle3.StyleInfo.Borders.Right = new Syncfusion.Windows.Forms.Grid.GridBorder(Syncfusion.Windows.Forms.Grid.GridBorderStyle.Solid, System.Drawing.SystemColors.Control, Syncfusion.Windows.Forms.Grid.GridBorderWeight.ExtraThin);
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
         this.reservationGridDataBoundGrid.BaseStylesMap.AddRange(new Syncfusion.Windows.Forms.Grid.GridBaseStyle[] {
            gridBaseStyle1,
            gridBaseStyle2,
            gridBaseStyle3,
            gridBaseStyle4});
         this.reservationGridDataBoundGrid.ControllerOptions = ((Syncfusion.Windows.Forms.Grid.GridControllerOptions)((((((Syncfusion.Windows.Forms.Grid.GridControllerOptions.ClickCells | Syncfusion.Windows.Forms.Grid.GridControllerOptions.DragSelectRowOrColumn)
                     | Syncfusion.Windows.Forms.Grid.GridControllerOptions.OleDropTarget)
                     | Syncfusion.Windows.Forms.Grid.GridControllerOptions.SelectCells)
                     | Syncfusion.Windows.Forms.Grid.GridControllerOptions.ExcelLikeSelection)
                     | Syncfusion.Windows.Forms.Grid.GridControllerOptions.ResizeCells)));
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
            this.descriptionGridBoundColumn,
            this.minGridBoundColumn,
            this.maxGridBoundColumn,
            this.statusGridBoundColumn});
         this.reservationGridDataBoundGrid.Size = new System.Drawing.Size(640, 478);
         this.reservationGridDataBoundGrid.SmartSizeBox = false;
         this.reservationGridDataBoundGrid.SortBehavior = Syncfusion.Windows.Forms.Grid.GridSortBehavior.DoubleClick;
         gridStyleInfo1.Font.Bold = false;
         gridStyleInfo1.Font.Facename = "Verdana";
         gridStyleInfo1.Font.Italic = false;
         gridStyleInfo1.Font.Size = 8.25F;
         gridStyleInfo1.Font.Strikeout = false;
         gridStyleInfo1.Font.Underline = false;
         gridStyleInfo1.Interior = new Syncfusion.Drawing.BrushInfo(System.Drawing.SystemColors.Window);
         this.reservationGridDataBoundGrid.TableStyle = gridStyleInfo1;
         this.reservationGridDataBoundGrid.UseListChangedEvent = true;
         // 
         // descriptionGridBoundColumn
         // 
         this.descriptionGridBoundColumn.HeaderText = "Description";
         this.descriptionGridBoundColumn.MappingName = "DESCRIPTION";
         this.descriptionGridBoundColumn.StyleInfo.CellValueType = typeof(string);
         this.descriptionGridBoundColumn.StyleInfo.MaskEdit.Mask = "##";
         // 
         // minGridBoundColumn
         // 
         this.minGridBoundColumn.HeaderText = "Min Value";
         this.minGridBoundColumn.MappingName = "USER_MIN_VALUE";
         this.minGridBoundColumn.StyleInfo.CellValueType = typeof(string);
         // 
         // maxGridBoundColumn
         // 
         this.maxGridBoundColumn.HeaderText = "Max Value";
         this.maxGridBoundColumn.MappingName = "USER_MAX_VALUE";
         this.maxGridBoundColumn.StyleInfo.CellValueType = typeof(string);
         // 
         // statusGridBoundColumn
         // 
         this.statusGridBoundColumn.HeaderText = "Status";
         this.statusGridBoundColumn.MappingName = "RESERVATION_STATUS_ID";
         this.statusGridBoundColumn.StyleInfo.CellType = "ComboBox";
         this.statusGridBoundColumn.StyleInfo.CellValueType = typeof(decimal);
         // 
         // SeriesManager
         // 
         this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
         this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
         this.Controls.Add(this.seriesTabControl);
         this.MinimumSize = new System.Drawing.Size(671, 563);
         this.Name = "SeriesManager";
         this.Size = new System.Drawing.Size(671, 563);
         this.templateGroupBox.ResumeLayout(false);
         this.groupBox3.ResumeLayout(false);
         this.groupBox3.PerformLayout();
         this.expirationPanel.ResumeLayout(false);
         this.expirationPanel.PerformLayout();
         ((System.ComponentModel.ISupportInitialize)(this.startRangeTextBox)).EndInit();
         this.dbGroupBox.ResumeLayout(false);
         this.dbGroupBox.PerformLayout();
         ((System.ComponentModel.ISupportInitialize)(this.seriesTabControl)).EndInit();
         this.seriesTabControl.ResumeLayout(false);
         this.definitionTabPage.ResumeLayout(false);
         this.reservationTabPage.ResumeLayout(false);
         this.groupBox1.ResumeLayout(false);
         this.groupBox1.PerformLayout();
         this.vialsGridRecordNavigationControl.ResumeLayout(false);
         ((System.ComponentModel.ISupportInitialize)(this.reservationGridDataBoundGrid)).EndInit();
         this.ResumeLayout(false);

      }

      #endregion

      private System.Windows.Forms.GroupBox templateGroupBox;
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
      private Jnj.Windows.Forms.SimpleGridBoundColumn maxGridBoundColumn;
      private Jnj.Windows.Forms.SimpleGridBoundColumn statusGridBoundColumn;
      private System.Windows.Forms.Label label6;
      private System.Windows.Forms.TextBox queryTextBox;
      private System.Windows.Forms.TextBox sequenceTextBox;
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
      private System.Windows.Forms.ToolTip toolTip1;
      private Jnj.Windows.Forms.SimpleGridBoundColumn descriptionGridBoundColumn;
      private System.Windows.Forms.Panel expirationPanel;
      private SeriesTemplateEditor seriesTemplateEditor;
      private System.Windows.Forms.Label seriesNameLabel;
      private System.Windows.Forms.Label label4;
      private System.Windows.Forms.TextBox tableAccTextBox;
      private System.Windows.Forms.Label label10;
      private System.Windows.Forms.TextBox seqAccTextBox;
      private System.Windows.Forms.Label label11;
      private System.Windows.Forms.TextBox tableRSTextBox;
      private System.Windows.Forms.Label label5;
      private System.Windows.Forms.TextBox seqRSTextBox;
   }
}
