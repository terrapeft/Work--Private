using System.Windows.Forms;

namespace SimpleClient
{
    partial class Form1
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Form1));
            this.spNameComboBox = new System.Windows.Forms.ComboBox();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.paramsTabControl = new System.Windows.Forms.TabControl();
            this.tabPage1 = new System.Windows.Forms.TabPage();
            this.dataGridView1 = new System.Windows.Forms.DataGridView();
            this.ParameterCol = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.ValueCol = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.loadOutputButton = new System.Windows.Forms.Button();
            this.label16 = new System.Windows.Forms.Label();
            this.dbComboBox = new System.Windows.Forms.ComboBox();
            this.button3 = new System.Windows.Forms.Button();
            this.button2 = new System.Windows.Forms.Button();
            this.userMethodsCheckBox = new System.Windows.Forms.CheckBox();
            this.label4 = new System.Windows.Forms.Label();
            this.imageList1 = new System.Windows.Forms.ImageList(this.components);
            this.extendResultsCheckBox = new System.Windows.Forms.CheckBox();
            this.toolTip1 = new System.Windows.Forms.ToolTip(this.components);
            this.searchGroupsListBox = new System.Windows.Forms.ListBox();
            this.equalsRadio = new System.Windows.Forms.RadioButton();
            this.containsRadio = new System.Windows.Forms.RadioButton();
            this.endsWithRadio = new System.Windows.Forms.RadioButton();
            this.startsWithRadio = new System.Windows.Forms.RadioButton();
            this.ctypeListBox = new System.Windows.Forms.ListBox();
            this.xcodeListBox = new System.Windows.Forms.ListBox();
            this.label12 = new System.Windows.Forms.Label();
            this.label13 = new System.Windows.Forms.Label();
            this.listView1 = new System.Windows.Forms.ListView();
            this.usernameComboBox = new System.Windows.Forms.ComboBox();
            this.button1 = new System.Windows.Forms.Button();
            this.multiUserCheckBox = new System.Windows.Forms.CheckBox();
            this.bytesCheckBox = new System.Windows.Forms.CheckBox();
            this.tabControl1 = new System.Windows.Forms.TabControl();
            this.methodsTab = new System.Windows.Forms.TabPage();
            this.searchTab = new System.Windows.Forms.TabPage();
            this.zipCheckBox = new System.Windows.Forms.CheckBox();
            this.includeRootCheckBox = new System.Windows.Forms.CheckBox();
            this.label6 = new System.Windows.Forms.Label();
            this.label7 = new System.Windows.Forms.Label();
            this.searchBox = new System.Windows.Forms.TextBox();
            this.openFileDialog1 = new System.Windows.Forms.OpenFileDialog();
            this.saveFileDialog1 = new System.Windows.Forms.SaveFileDialog();
            this.panel1 = new System.Windows.Forms.Panel();
            this.groupBox3 = new System.Windows.Forms.GroupBox();
            this.csvRadioButton = new System.Windows.Forms.RadioButton();
            this.countRadioButton = new System.Windows.Forms.RadioButton();
            this.jsonRadioButton = new System.Windows.Forms.RadioButton();
            this.indentJsonCheckBox = new System.Windows.Forms.CheckBox();
            this.xmlRadioButton = new System.Windows.Forms.RadioButton();
            this.label3 = new System.Windows.Forms.Label();
            this.csvColumnsCheckBox = new System.Windows.Forms.CheckBox();
            this.delimiterTextBox = new System.Windows.Forms.TextBox();
            this.helpRadioButton = new System.Windows.Forms.RadioButton();
            this.forceQuotesCheckBox = new System.Windows.Forms.CheckBox();
            this.listRadioButton = new System.Windows.Forms.RadioButton();
            this.baseUrlTextBox = new System.Windows.Forms.TextBox();
            this.groupBox4 = new System.Windows.Forms.GroupBox();
            this.label2 = new System.Windows.Forms.Label();
            this.stringLengthNumericUpDown = new System.Windows.Forms.NumericUpDown();
            this.passwordTextbox = new System.Windows.Forms.TextBox();
            this.label5 = new System.Windows.Forms.Label();
            this.label15 = new System.Windows.Forms.Label();
            this.label14 = new System.Windows.Forms.Label();
            this.iterationsNumericUpDown = new System.Windows.Forms.NumericUpDown();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.usePagingCheckBox = new System.Windows.Forms.CheckBox();
            this.label17 = new System.Windows.Forms.Label();
            this.pageSizeNumericUpDown = new System.Windows.Forms.NumericUpDown();
            this.pageNumberNumericUpDown = new System.Windows.Forms.NumericUpDown();
            this.label18 = new System.Windows.Forms.Label();
            this.resultTextBox = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.cancelButton = new System.Windows.Forms.Button();
            this.runButton = new System.Windows.Forms.Button();
            this.label9 = new System.Windows.Forms.Label();
            this.statusStrip1 = new System.Windows.Forms.StatusStrip();
            this.splitContainer1 = new System.Windows.Forms.SplitContainer();
            this.saveZipAsFileCheckBox = new System.Windows.Forms.CheckBox();
            this.clearCacheRadioButton = new System.Windows.Forms.RadioButton();
            this.groupBox1.SuspendLayout();
            this.paramsTabControl.SuspendLayout();
            this.tabPage1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).BeginInit();
            this.tabControl1.SuspendLayout();
            this.methodsTab.SuspendLayout();
            this.searchTab.SuspendLayout();
            this.panel1.SuspendLayout();
            this.groupBox3.SuspendLayout();
            this.groupBox4.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.stringLengthNumericUpDown)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.iterationsNumericUpDown)).BeginInit();
            this.groupBox2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pageSizeNumericUpDown)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.pageNumberNumericUpDown)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.splitContainer1)).BeginInit();
            this.splitContainer1.Panel1.SuspendLayout();
            this.splitContainer1.Panel2.SuspendLayout();
            this.splitContainer1.SuspendLayout();
            this.SuspendLayout();
            // 
            // spNameComboBox
            // 
            this.spNameComboBox.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.spNameComboBox.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.spNameComboBox.FormattingEnabled = true;
            this.spNameComboBox.Location = new System.Drawing.Point(227, 42);
            this.spNameComboBox.Margin = new System.Windows.Forms.Padding(2);
            this.spNameComboBox.Name = "spNameComboBox";
            this.spNameComboBox.Size = new System.Drawing.Size(683, 21);
            this.spNameComboBox.TabIndex = 1;
            this.spNameComboBox.SelectedIndexChanged += new System.EventHandler(this.spNameComboBox_SelectedIndexChange);
            // 
            // groupBox1
            // 
            this.groupBox1.BackColor = System.Drawing.Color.Transparent;
            this.groupBox1.Controls.Add(this.paramsTabControl);
            this.groupBox1.Controls.Add(this.loadOutputButton);
            this.groupBox1.Controls.Add(this.label16);
            this.groupBox1.Controls.Add(this.dbComboBox);
            this.groupBox1.Controls.Add(this.button3);
            this.groupBox1.Controls.Add(this.button2);
            this.groupBox1.Controls.Add(this.userMethodsCheckBox);
            this.groupBox1.Controls.Add(this.label4);
            this.groupBox1.Controls.Add(this.spNameComboBox);
            this.groupBox1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.groupBox1.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.groupBox1.Location = new System.Drawing.Point(3, 3);
            this.groupBox1.Margin = new System.Windows.Forms.Padding(2);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Padding = new System.Windows.Forms.Padding(2);
            this.groupBox1.Size = new System.Drawing.Size(1044, 305);
            this.groupBox1.TabIndex = 1;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Basic settings";
            // 
            // paramsTabControl
            // 
            this.paramsTabControl.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.paramsTabControl.Controls.Add(this.tabPage1);
            this.paramsTabControl.Location = new System.Drawing.Point(11, 68);
            this.paramsTabControl.Name = "paramsTabControl";
            this.paramsTabControl.SelectedIndex = 0;
            this.paramsTabControl.Size = new System.Drawing.Size(914, 229);
            this.paramsTabControl.TabIndex = 61;
            // 
            // tabPage1
            // 
            this.tabPage1.Controls.Add(this.dataGridView1);
            this.tabPage1.Location = new System.Drawing.Point(4, 22);
            this.tabPage1.Name = "tabPage1";
            this.tabPage1.Padding = new System.Windows.Forms.Padding(3);
            this.tabPage1.Size = new System.Drawing.Size(906, 203);
            this.tabPage1.TabIndex = 0;
            this.tabPage1.Text = "Method parameters";
            this.tabPage1.UseVisualStyleBackColor = true;
            // 
            // dataGridView1
            // 
            this.dataGridView1.AllowDrop = true;
            this.dataGridView1.AllowUserToOrderColumns = true;
            this.dataGridView1.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill;
            this.dataGridView1.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.ParameterCol,
            this.ValueCol});
            this.dataGridView1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dataGridView1.Location = new System.Drawing.Point(3, 3);
            this.dataGridView1.Margin = new System.Windows.Forms.Padding(2);
            this.dataGridView1.Name = "dataGridView1";
            this.dataGridView1.RowTemplate.Height = 24;
            this.dataGridView1.Size = new System.Drawing.Size(900, 197);
            this.dataGridView1.TabIndex = 3;
            this.dataGridView1.CellLeave += new System.Windows.Forms.DataGridViewCellEventHandler(this.dataGridView1_CellLeave);
            this.dataGridView1.RowLeave += new System.Windows.Forms.DataGridViewCellEventHandler(this.dataGridView1_CellLeave);
            this.dataGridView1.Leave += new System.EventHandler(this.dataGridView1_Leave);
            // 
            // ParameterCol
            // 
            this.ParameterCol.DataPropertyName = "ParameterName";
            this.ParameterCol.HeaderText = "Parameter";
            this.ParameterCol.Name = "ParameterCol";
            // 
            // ValueCol
            // 
            this.ValueCol.DataPropertyName = "ParameterValue";
            this.ValueCol.HeaderText = "Value";
            this.ValueCol.Name = "ValueCol";
            // 
            // loadOutputButton
            // 
            this.loadOutputButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.loadOutputButton.BackColor = System.Drawing.Color.PapayaWhip;
            this.loadOutputButton.Location = new System.Drawing.Point(927, 160);
            this.loadOutputButton.Margin = new System.Windows.Forms.Padding(2);
            this.loadOutputButton.Name = "loadOutputButton";
            this.loadOutputButton.Size = new System.Drawing.Size(111, 26);
            this.loadOutputButton.TabIndex = 62;
            this.loadOutputButton.Text = "Filter output";
            this.toolTip1.SetToolTip(this.loadOutputButton, "Load method output based \r\non provided parameters.");
            this.loadOutputButton.UseVisualStyleBackColor = false;
            this.loadOutputButton.Click += new System.EventHandler(this.loadOutputButton_Click);
            // 
            // label16
            // 
            this.label16.AutoSize = true;
            this.label16.Location = new System.Drawing.Point(8, 27);
            this.label16.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label16.Name = "label16";
            this.label16.Size = new System.Drawing.Size(21, 13);
            this.label16.TabIndex = 60;
            this.label16.Text = "Db";
            // 
            // dbComboBox
            // 
            this.dbComboBox.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.dbComboBox.FormattingEnabled = true;
            this.dbComboBox.Location = new System.Drawing.Point(11, 42);
            this.dbComboBox.Margin = new System.Windows.Forms.Padding(2);
            this.dbComboBox.Name = "dbComboBox";
            this.dbComboBox.Size = new System.Drawing.Size(212, 21);
            this.dbComboBox.TabIndex = 59;
            this.dbComboBox.SelectedIndexChanged += new System.EventHandler(this.dbComboBox_SelectedIndexChanged);
            // 
            // button3
            // 
            this.button3.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.button3.BackColor = System.Drawing.SystemColors.Control;
            this.button3.Location = new System.Drawing.Point(927, 120);
            this.button3.Margin = new System.Windows.Forms.Padding(2);
            this.button3.Name = "button3";
            this.button3.Size = new System.Drawing.Size(111, 26);
            this.button3.TabIndex = 58;
            this.button3.Text = "Load";
            this.toolTip1.SetToolTip(this.button3, "Save method parameters and users list");
            this.button3.UseVisualStyleBackColor = false;
            this.button3.Click += new System.EventHandler(this.loadButton_Click);
            // 
            // button2
            // 
            this.button2.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.button2.BackColor = System.Drawing.SystemColors.Control;
            this.button2.Location = new System.Drawing.Point(927, 90);
            this.button2.Margin = new System.Windows.Forms.Padding(2);
            this.button2.Name = "button2";
            this.button2.Size = new System.Drawing.Size(111, 26);
            this.button2.TabIndex = 57;
            this.button2.Text = "Save";
            this.toolTip1.SetToolTip(this.button2, "Save method parameters and users list");
            this.button2.UseVisualStyleBackColor = false;
            this.button2.Click += new System.EventHandler(this.saveButton_Click);
            // 
            // userMethodsCheckBox
            // 
            this.userMethodsCheckBox.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.userMethodsCheckBox.AutoSize = true;
            this.userMethodsCheckBox.Checked = true;
            this.userMethodsCheckBox.CheckState = System.Windows.Forms.CheckState.Checked;
            this.userMethodsCheckBox.Location = new System.Drawing.Point(914, 44);
            this.userMethodsCheckBox.Margin = new System.Windows.Forms.Padding(2);
            this.userMethodsCheckBox.Name = "userMethodsCheckBox";
            this.userMethodsCheckBox.Size = new System.Drawing.Size(128, 17);
            this.userMethodsCheckBox.TabIndex = 2;
            this.userMethodsCheckBox.Text = "Filter methods by user";
            this.userMethodsCheckBox.UseVisualStyleBackColor = true;
            this.userMethodsCheckBox.CheckedChanged += new System.EventHandler(this.userMethodsCheckBox_CheckedChanged);
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(224, 27);
            this.label4.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(43, 13);
            this.label4.TabIndex = 45;
            this.label4.Text = "Method";
            // 
            // imageList1
            // 
            this.imageList1.ImageStream = ((System.Windows.Forms.ImageListStreamer)(resources.GetObject("imageList1.ImageStream")));
            this.imageList1.TransparentColor = System.Drawing.Color.Transparent;
            this.imageList1.Images.SetKeyName(0, "copy.png");
            this.imageList1.Images.SetKeyName(1, "firefox.exe");
            this.imageList1.Images.SetKeyName(2, "google chrome");
            this.imageList1.Images.SetKeyName(3, "iexplore.exe");
            this.imageList1.Images.SetKeyName(4, "opera");
            // 
            // extendResultsCheckBox
            // 
            this.extendResultsCheckBox.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.extendResultsCheckBox.AutoSize = true;
            this.extendResultsCheckBox.Location = new System.Drawing.Point(950, 82);
            this.extendResultsCheckBox.Margin = new System.Windows.Forms.Padding(2);
            this.extendResultsCheckBox.Name = "extendResultsCheckBox";
            this.extendResultsCheckBox.Size = new System.Drawing.Size(91, 17);
            this.extendResultsCheckBox.TabIndex = 5;
            this.extendResultsCheckBox.Text = "Include series";
            this.extendResultsCheckBox.UseVisualStyleBackColor = true;
            this.extendResultsCheckBox.CheckedChanged += new System.EventHandler(this.control_SelectedIndexChanged);
            // 
            // toolTip1
            // 
            this.toolTip1.AutoPopDelay = 32767;
            this.toolTip1.InitialDelay = 500;
            this.toolTip1.IsBalloon = true;
            this.toolTip1.ReshowDelay = 100;
            // 
            // searchGroupsListBox
            // 
            this.searchGroupsListBox.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.searchGroupsListBox.FormattingEnabled = true;
            this.searchGroupsListBox.Location = new System.Drawing.Point(14, 61);
            this.searchGroupsListBox.Name = "searchGroupsListBox";
            this.searchGroupsListBox.SelectionMode = System.Windows.Forms.SelectionMode.MultiExtended;
            this.searchGroupsListBox.Size = new System.Drawing.Size(591, 238);
            this.searchGroupsListBox.TabIndex = 2;
            this.toolTip1.SetToolTip(this.searchGroupsListBox, "No selection is the same as to select all.\r\n\r\nCTRL+Click to deselect last item.\r\n" +
        "");
            this.searchGroupsListBox.SelectedIndexChanged += new System.EventHandler(this.control_SelectedIndexChanged);
            // 
            // equalsRadio
            // 
            this.equalsRadio.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.equalsRadio.AutoSize = true;
            this.equalsRadio.Checked = true;
            this.equalsRadio.Location = new System.Drawing.Point(950, 173);
            this.equalsRadio.Name = "equalsRadio";
            this.equalsRadio.Size = new System.Drawing.Size(57, 17);
            this.equalsRadio.TabIndex = 9;
            this.equalsRadio.TabStop = true;
            this.equalsRadio.Text = "Equals";
            this.toolTip1.SetToolTip(this.equalsRadio, "Value = 4");
            this.equalsRadio.UseVisualStyleBackColor = true;
            this.equalsRadio.CheckedChanged += new System.EventHandler(this.control_SelectedIndexChanged);
            // 
            // containsRadio
            // 
            this.containsRadio.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.containsRadio.AutoSize = true;
            this.containsRadio.Location = new System.Drawing.Point(950, 150);
            this.containsRadio.Name = "containsRadio";
            this.containsRadio.Size = new System.Drawing.Size(66, 17);
            this.containsRadio.TabIndex = 8;
            this.containsRadio.Text = "Contains";
            this.toolTip1.SetToolTip(this.containsRadio, "Value = 3");
            this.containsRadio.UseVisualStyleBackColor = true;
            this.containsRadio.CheckedChanged += new System.EventHandler(this.control_SelectedIndexChanged);
            // 
            // endsWithRadio
            // 
            this.endsWithRadio.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.endsWithRadio.AutoSize = true;
            this.endsWithRadio.Location = new System.Drawing.Point(950, 127);
            this.endsWithRadio.Name = "endsWithRadio";
            this.endsWithRadio.Size = new System.Drawing.Size(74, 17);
            this.endsWithRadio.TabIndex = 7;
            this.endsWithRadio.Text = "Ends With";
            this.toolTip1.SetToolTip(this.endsWithRadio, "Value = 2");
            this.endsWithRadio.UseVisualStyleBackColor = true;
            this.endsWithRadio.CheckedChanged += new System.EventHandler(this.control_SelectedIndexChanged);
            // 
            // startsWithRadio
            // 
            this.startsWithRadio.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.startsWithRadio.AutoSize = true;
            this.startsWithRadio.Location = new System.Drawing.Point(950, 104);
            this.startsWithRadio.Name = "startsWithRadio";
            this.startsWithRadio.Size = new System.Drawing.Size(77, 17);
            this.startsWithRadio.TabIndex = 6;
            this.startsWithRadio.Text = "Starts With";
            this.toolTip1.SetToolTip(this.startsWithRadio, "Value = 1");
            this.startsWithRadio.UseVisualStyleBackColor = true;
            this.startsWithRadio.CheckedChanged += new System.EventHandler(this.control_SelectedIndexChanged);
            // 
            // ctypeListBox
            // 
            this.ctypeListBox.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.ctypeListBox.FormattingEnabled = true;
            this.ctypeListBox.Location = new System.Drawing.Point(782, 61);
            this.ctypeListBox.Name = "ctypeListBox";
            this.ctypeListBox.SelectionMode = System.Windows.Forms.SelectionMode.MultiExtended;
            this.ctypeListBox.Size = new System.Drawing.Size(149, 238);
            this.ctypeListBox.TabIndex = 4;
            this.toolTip1.SetToolTip(this.ctypeListBox, "No selection is the same as to select all.\r\n\r\nCTRL+Click to deselect last item.");
            this.ctypeListBox.SelectedIndexChanged += new System.EventHandler(this.control_SelectedIndexChanged);
            // 
            // xcodeListBox
            // 
            this.xcodeListBox.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.xcodeListBox.FormattingEnabled = true;
            this.xcodeListBox.Location = new System.Drawing.Point(618, 61);
            this.xcodeListBox.Name = "xcodeListBox";
            this.xcodeListBox.SelectionMode = System.Windows.Forms.SelectionMode.MultiExtended;
            this.xcodeListBox.Size = new System.Drawing.Size(149, 238);
            this.xcodeListBox.TabIndex = 3;
            this.toolTip1.SetToolTip(this.xcodeListBox, "No selection is the same as to select all.\r\n\r\nCTRL+Click to deselect last item.\r\n" +
        "");
            this.xcodeListBox.SelectedIndexChanged += new System.EventHandler(this.control_SelectedIndexChanged);
            // 
            // label12
            // 
            this.label12.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.label12.AutoSize = true;
            this.label12.Location = new System.Drawing.Point(615, 43);
            this.label12.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label12.Name = "label12";
            this.label12.Size = new System.Drawing.Size(87, 13);
            this.label12.TabIndex = 75;
            this.label12.Text = "Exchange codes";
            this.toolTip1.SetToolTip(this.label12, "No selection is the same as to select all.");
            // 
            // label13
            // 
            this.label13.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.label13.AutoSize = true;
            this.label13.Location = new System.Drawing.Point(779, 45);
            this.label13.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label13.Name = "label13";
            this.label13.Size = new System.Drawing.Size(75, 13);
            this.label13.TabIndex = 76;
            this.label13.Text = "Contract types";
            this.toolTip1.SetToolTip(this.label13, "No selection is the same as to select all.");
            // 
            // listView1
            // 
            this.listView1.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.listView1.HideSelection = false;
            this.listView1.Location = new System.Drawing.Point(430, 113);
            this.listView1.MultiSelect = false;
            this.listView1.Name = "listView1";
            this.listView1.ShowGroups = false;
            this.listView1.Size = new System.Drawing.Size(615, 85);
            this.listView1.SmallImageList = this.imageList1;
            this.listView1.TabIndex = 26;
            this.toolTip1.SetToolTip(this.listView1, "Leave unselected to use default.\r\n\r\nClick in empty space to deselct.");
            this.listView1.UseCompatibleStateImageBehavior = false;
            this.listView1.View = System.Windows.Forms.View.List;
            // 
            // usernameComboBox
            // 
            this.usernameComboBox.DropDownStyle = System.Windows.Forms.ComboBoxStyle.Simple;
            this.usernameComboBox.FormattingEnabled = true;
            this.usernameComboBox.Location = new System.Drawing.Point(69, 13);
            this.usernameComboBox.Margin = new System.Windows.Forms.Padding(2);
            this.usernameComboBox.Name = "usernameComboBox";
            this.usernameComboBox.Size = new System.Drawing.Size(208, 21);
            this.usernameComboBox.TabIndex = 2;
            this.toolTip1.SetToolTip(this.usernameComboBox, "In multi-user mode a new user will be added to the list\r\nautomatically, when comb" +
        "obox loses focus.");
            this.usernameComboBox.SelectedIndexChanged += new System.EventHandler(this.userMethodsCheckBox_CheckedChanged);
            this.usernameComboBox.TextChanged += new System.EventHandler(this.textbox_TextChanged);
            this.usernameComboBox.Leave += new System.EventHandler(this.usernameComboBox_Leave);
            // 
            // button1
            // 
            this.button1.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.button1.Image = ((System.Drawing.Image)(resources.GetObject("button1.Image")));
            this.button1.Location = new System.Drawing.Point(934, 14);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(24, 24);
            this.button1.TabIndex = 29;
            this.toolTip1.SetToolTip(this.button1, "Copy URL to clipboard");
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // multiUserCheckBox
            // 
            this.multiUserCheckBox.AutoSize = true;
            this.multiUserCheckBox.Location = new System.Drawing.Point(289, 17);
            this.multiUserCheckBox.Margin = new System.Windows.Forms.Padding(2);
            this.multiUserCheckBox.Name = "multiUserCheckBox";
            this.multiUserCheckBox.Size = new System.Drawing.Size(100, 17);
            this.multiUserCheckBox.TabIndex = 14;
            this.multiUserCheckBox.Text = "Multi-user mode";
            this.toolTip1.SetToolTip(this.multiUserCheckBox, resources.GetString("multiUserCheckBox.ToolTip"));
            this.multiUserCheckBox.UseVisualStyleBackColor = true;
            this.multiUserCheckBox.CheckedChanged += new System.EventHandler(this.multiUserCheckBox_CheckedChanged);
            // 
            // bytesCheckBox
            // 
            this.bytesCheckBox.AutoSize = true;
            this.bytesCheckBox.Enabled = false;
            this.bytesCheckBox.Location = new System.Drawing.Point(523, 39);
            this.bytesCheckBox.Margin = new System.Windows.Forms.Padding(2);
            this.bytesCheckBox.Name = "bytesCheckBox";
            this.bytesCheckBox.Size = new System.Drawing.Size(75, 17);
            this.bytesCheckBox.TabIndex = 57;
            this.bytesCheckBox.Text = "Show first ";
            this.toolTip1.SetToolTip(this.bytesCheckBox, resources.GetString("bytesCheckBox.ToolTip"));
            this.bytesCheckBox.UseVisualStyleBackColor = true;
            // 
            // tabControl1
            // 
            this.tabControl1.Controls.Add(this.methodsTab);
            this.tabControl1.Controls.Add(this.searchTab);
            this.tabControl1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tabControl1.Location = new System.Drawing.Point(0, 0);
            this.tabControl1.MinimumSize = new System.Drawing.Size(694, 310);
            this.tabControl1.Name = "tabControl1";
            this.tabControl1.SelectedIndex = 0;
            this.tabControl1.Size = new System.Drawing.Size(1058, 337);
            this.tabControl1.SizeMode = System.Windows.Forms.TabSizeMode.Fixed;
            this.tabControl1.TabIndex = 25;
            this.tabControl1.SelectedIndexChanged += new System.EventHandler(this.tabControl1_SelectedIndexChanged);
            // 
            // methodsTab
            // 
            this.methodsTab.BackColor = System.Drawing.Color.Transparent;
            this.methodsTab.Controls.Add(this.groupBox1);
            this.methodsTab.Location = new System.Drawing.Point(4, 22);
            this.methodsTab.Name = "methodsTab";
            this.methodsTab.Padding = new System.Windows.Forms.Padding(3);
            this.methodsTab.Size = new System.Drawing.Size(1050, 311);
            this.methodsTab.TabIndex = 0;
            this.methodsTab.Text = "Methods";
            // 
            // searchTab
            // 
            this.searchTab.BackColor = System.Drawing.Color.Transparent;
            this.searchTab.Controls.Add(this.saveZipAsFileCheckBox);
            this.searchTab.Controls.Add(this.zipCheckBox);
            this.searchTab.Controls.Add(this.includeRootCheckBox);
            this.searchTab.Controls.Add(this.label13);
            this.searchTab.Controls.Add(this.label12);
            this.searchTab.Controls.Add(this.label6);
            this.searchTab.Controls.Add(this.searchGroupsListBox);
            this.searchTab.Controls.Add(this.equalsRadio);
            this.searchTab.Controls.Add(this.containsRadio);
            this.searchTab.Controls.Add(this.endsWithRadio);
            this.searchTab.Controls.Add(this.startsWithRadio);
            this.searchTab.Controls.Add(this.ctypeListBox);
            this.searchTab.Controls.Add(this.xcodeListBox);
            this.searchTab.Controls.Add(this.label7);
            this.searchTab.Controls.Add(this.searchBox);
            this.searchTab.Controls.Add(this.extendResultsCheckBox);
            this.searchTab.Location = new System.Drawing.Point(4, 22);
            this.searchTab.Name = "searchTab";
            this.searchTab.Padding = new System.Windows.Forms.Padding(3);
            this.searchTab.Size = new System.Drawing.Size(1050, 311);
            this.searchTab.TabIndex = 1;
            this.searchTab.Text = "Search";
            // 
            // zipCheckBox
            // 
            this.zipCheckBox.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.zipCheckBox.AutoSize = true;
            this.zipCheckBox.Location = new System.Drawing.Point(950, 220);
            this.zipCheckBox.Margin = new System.Windows.Forms.Padding(2);
            this.zipCheckBox.Name = "zipCheckBox";
            this.zipCheckBox.Size = new System.Drawing.Size(74, 17);
            this.zipCheckBox.TabIndex = 78;
            this.zipCheckBox.Text = "Zip results";
            this.zipCheckBox.UseVisualStyleBackColor = true;
            this.zipCheckBox.CheckedChanged += new System.EventHandler(this.control_SelectedIndexChanged);
            // 
            // includeRootCheckBox
            // 
            this.includeRootCheckBox.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.includeRootCheckBox.AutoSize = true;
            this.includeRootCheckBox.Location = new System.Drawing.Point(950, 61);
            this.includeRootCheckBox.Margin = new System.Windows.Forms.Padding(2);
            this.includeRootCheckBox.Name = "includeRootCheckBox";
            this.includeRootCheckBox.Size = new System.Drawing.Size(85, 17);
            this.includeRootCheckBox.TabIndex = 77;
            this.includeRootCheckBox.Text = "Exclude root";
            this.includeRootCheckBox.UseVisualStyleBackColor = true;
            this.includeRootCheckBox.CheckedChanged += new System.EventHandler(this.control_SelectedIndexChanged);
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(11, 43);
            this.label6.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(76, 13);
            this.label6.TabIndex = 74;
            this.label6.Text = "Search groups";
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Location = new System.Drawing.Point(11, 10);
            this.label7.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(44, 13);
            this.label7.TabIndex = 59;
            this.label7.Text = "Search:";
            // 
            // searchBox
            // 
            this.searchBox.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.searchBox.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Suggest;
            this.searchBox.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.CustomSource;
            this.searchBox.Location = new System.Drawing.Point(60, 7);
            this.searchBox.Name = "searchBox";
            this.searchBox.Size = new System.Drawing.Size(981, 20);
            this.searchBox.TabIndex = 1;
            this.searchBox.TextChanged += new System.EventHandler(this.control_SelectedIndexChanged);
            // 
            // openFileDialog1
            // 
            this.openFileDialog1.FileName = "SimpleClientSettings.ejson";
            this.openFileDialog1.Filter = "Concatenated JSON strings|*.ejson";
            this.openFileDialog1.InitialDirectory = ".";
            // 
            // saveFileDialog1
            // 
            this.saveFileDialog1.FileName = "SimpleClientSettings.ejson";
            this.saveFileDialog1.Filter = "Concatenated JSON strings|*.ejson";
            this.saveFileDialog1.InitialDirectory = ".";
            // 
            // panel1
            // 
            this.panel1.Controls.Add(this.groupBox3);
            this.panel1.Controls.Add(this.baseUrlTextBox);
            this.panel1.Controls.Add(this.groupBox4);
            this.panel1.Controls.Add(this.groupBox2);
            this.panel1.Controls.Add(this.resultTextBox);
            this.panel1.Controls.Add(this.label1);
            this.panel1.Controls.Add(this.cancelButton);
            this.panel1.Controls.Add(this.listView1);
            this.panel1.Controls.Add(this.runButton);
            this.panel1.Controls.Add(this.button1);
            this.panel1.Controls.Add(this.label9);
            this.panel1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.panel1.Location = new System.Drawing.Point(0, 0);
            this.panel1.MinimumSize = new System.Drawing.Size(694, 285);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(1058, 351);
            this.panel1.TabIndex = 60;
            // 
            // groupBox3
            // 
            this.groupBox3.BackColor = System.Drawing.Color.Transparent;
            this.groupBox3.Controls.Add(this.clearCacheRadioButton);
            this.groupBox3.Controls.Add(this.csvRadioButton);
            this.groupBox3.Controls.Add(this.countRadioButton);
            this.groupBox3.Controls.Add(this.jsonRadioButton);
            this.groupBox3.Controls.Add(this.indentJsonCheckBox);
            this.groupBox3.Controls.Add(this.xmlRadioButton);
            this.groupBox3.Controls.Add(this.label3);
            this.groupBox3.Controls.Add(this.csvColumnsCheckBox);
            this.groupBox3.Controls.Add(this.delimiterTextBox);
            this.groupBox3.Controls.Add(this.helpRadioButton);
            this.groupBox3.Controls.Add(this.forceQuotesCheckBox);
            this.groupBox3.Controls.Add(this.listRadioButton);
            this.groupBox3.Location = new System.Drawing.Point(18, 97);
            this.groupBox3.Name = "groupBox3";
            this.groupBox3.Size = new System.Drawing.Size(406, 101);
            this.groupBox3.TabIndex = 25;
            this.groupBox3.TabStop = false;
            this.groupBox3.Text = "Output";
            // 
            // csvRadioButton
            // 
            this.csvRadioButton.AutoSize = true;
            this.csvRadioButton.Checked = true;
            this.csvRadioButton.Location = new System.Drawing.Point(5, 16);
            this.csvRadioButton.Margin = new System.Windows.Forms.Padding(2);
            this.csvRadioButton.Name = "csvRadioButton";
            this.csvRadioButton.Size = new System.Drawing.Size(46, 17);
            this.csvRadioButton.TabIndex = 16;
            this.csvRadioButton.TabStop = true;
            this.csvRadioButton.Text = "CSV";
            this.csvRadioButton.UseVisualStyleBackColor = true;
            this.csvRadioButton.CheckedChanged += new System.EventHandler(this.radioButton_CheckedChanged);
            // 
            // countRadioButton
            // 
            this.countRadioButton.AutoSize = true;
            this.countRadioButton.Location = new System.Drawing.Point(252, 79);
            this.countRadioButton.Margin = new System.Windows.Forms.Padding(2);
            this.countRadioButton.Name = "countRadioButton";
            this.countRadioButton.Size = new System.Drawing.Size(53, 17);
            this.countRadioButton.TabIndex = 25;
            this.countRadioButton.Text = "Count";
            this.countRadioButton.UseVisualStyleBackColor = true;
            this.countRadioButton.CheckedChanged += new System.EventHandler(this.radioButton_CheckedChanged);
            // 
            // jsonRadioButton
            // 
            this.jsonRadioButton.AutoSize = true;
            this.jsonRadioButton.Location = new System.Drawing.Point(159, 16);
            this.jsonRadioButton.Margin = new System.Windows.Forms.Padding(2);
            this.jsonRadioButton.Name = "jsonRadioButton";
            this.jsonRadioButton.Size = new System.Drawing.Size(53, 17);
            this.jsonRadioButton.TabIndex = 20;
            this.jsonRadioButton.Text = "JSON";
            this.jsonRadioButton.UseVisualStyleBackColor = true;
            this.jsonRadioButton.CheckedChanged += new System.EventHandler(this.radioButton_CheckedChanged);
            // 
            // indentJsonCheckBox
            // 
            this.indentJsonCheckBox.AutoSize = true;
            this.indentJsonCheckBox.Location = new System.Drawing.Point(179, 37);
            this.indentJsonCheckBox.Margin = new System.Windows.Forms.Padding(2);
            this.indentJsonCheckBox.Name = "indentJsonCheckBox";
            this.indentJsonCheckBox.Size = new System.Drawing.Size(56, 17);
            this.indentJsonCheckBox.TabIndex = 21;
            this.indentJsonCheckBox.Text = "Indent";
            this.indentJsonCheckBox.UseVisualStyleBackColor = true;
            this.indentJsonCheckBox.CheckedChanged += new System.EventHandler(this.textbox_TextChanged);
            // 
            // xmlRadioButton
            // 
            this.xmlRadioButton.AutoSize = true;
            this.xmlRadioButton.Location = new System.Drawing.Point(252, 16);
            this.xmlRadioButton.Margin = new System.Windows.Forms.Padding(2);
            this.xmlRadioButton.Name = "xmlRadioButton";
            this.xmlRadioButton.Size = new System.Drawing.Size(47, 17);
            this.xmlRadioButton.TabIndex = 22;
            this.xmlRadioButton.Text = "XML";
            this.xmlRadioButton.UseVisualStyleBackColor = true;
            this.xmlRadioButton.CheckedChanged += new System.EventHandler(this.radioButton_CheckedChanged);
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(39, 81);
            this.label3.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(47, 13);
            this.label3.TabIndex = 19;
            this.label3.Text = "Delimiter";
            // 
            // csvColumnsCheckBox
            // 
            this.csvColumnsCheckBox.AutoSize = true;
            this.csvColumnsCheckBox.Location = new System.Drawing.Point(23, 37);
            this.csvColumnsCheckBox.Margin = new System.Windows.Forms.Padding(2);
            this.csvColumnsCheckBox.Name = "csvColumnsCheckBox";
            this.csvColumnsCheckBox.Size = new System.Drawing.Size(132, 17);
            this.csvColumnsCheckBox.TabIndex = 17;
            this.csvColumnsCheckBox.Text = "Include column names";
            this.csvColumnsCheckBox.UseVisualStyleBackColor = true;
            this.csvColumnsCheckBox.CheckedChanged += new System.EventHandler(this.textbox_TextChanged);
            // 
            // delimiterTextBox
            // 
            this.delimiterTextBox.Location = new System.Drawing.Point(23, 78);
            this.delimiterTextBox.Margin = new System.Windows.Forms.Padding(2);
            this.delimiterTextBox.Name = "delimiterTextBox";
            this.delimiterTextBox.Size = new System.Drawing.Size(12, 20);
            this.delimiterTextBox.TabIndex = 52;
            this.delimiterTextBox.Text = ",";
            this.delimiterTextBox.TextChanged += new System.EventHandler(this.textbox_TextChanged);
            // 
            // helpRadioButton
            // 
            this.helpRadioButton.AutoSize = true;
            this.helpRadioButton.Location = new System.Drawing.Point(252, 37);
            this.helpRadioButton.Margin = new System.Windows.Forms.Padding(2);
            this.helpRadioButton.Name = "helpRadioButton";
            this.helpRadioButton.Size = new System.Drawing.Size(47, 17);
            this.helpRadioButton.TabIndex = 23;
            this.helpRadioButton.Text = "Help";
            this.helpRadioButton.UseVisualStyleBackColor = true;
            this.helpRadioButton.CheckedChanged += new System.EventHandler(this.radioButton_CheckedChanged);
            // 
            // forceQuotesCheckBox
            // 
            this.forceQuotesCheckBox.AutoSize = true;
            this.forceQuotesCheckBox.Location = new System.Drawing.Point(23, 58);
            this.forceQuotesCheckBox.Margin = new System.Windows.Forms.Padding(2);
            this.forceQuotesCheckBox.Name = "forceQuotesCheckBox";
            this.forceQuotesCheckBox.Size = new System.Drawing.Size(88, 17);
            this.forceQuotesCheckBox.TabIndex = 18;
            this.forceQuotesCheckBox.Text = "Force quotes";
            this.forceQuotesCheckBox.UseVisualStyleBackColor = true;
            this.forceQuotesCheckBox.CheckedChanged += new System.EventHandler(this.textbox_TextChanged);
            // 
            // listRadioButton
            // 
            this.listRadioButton.AutoSize = true;
            this.listRadioButton.Location = new System.Drawing.Point(252, 58);
            this.listRadioButton.Margin = new System.Windows.Forms.Padding(2);
            this.listRadioButton.Name = "listRadioButton";
            this.listRadioButton.Size = new System.Drawing.Size(41, 17);
            this.listRadioButton.TabIndex = 24;
            this.listRadioButton.Text = "List";
            this.listRadioButton.UseVisualStyleBackColor = true;
            this.listRadioButton.CheckedChanged += new System.EventHandler(this.radioButton_CheckedChanged);
            // 
            // baseUrlTextBox
            // 
            this.baseUrlTextBox.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.baseUrlTextBox.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.baseUrlTextBox.Location = new System.Drawing.Point(18, 16);
            this.baseUrlTextBox.Margin = new System.Windows.Forms.Padding(2);
            this.baseUrlTextBox.Name = "baseUrlTextBox";
            this.baseUrlTextBox.ReadOnly = true;
            this.baseUrlTextBox.Size = new System.Drawing.Size(914, 20);
            this.baseUrlTextBox.TabIndex = 28;
            // 
            // groupBox4
            // 
            this.groupBox4.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.groupBox4.Controls.Add(this.label2);
            this.groupBox4.Controls.Add(this.usernameComboBox);
            this.groupBox4.Controls.Add(this.stringLengthNumericUpDown);
            this.groupBox4.Controls.Add(this.passwordTextbox);
            this.groupBox4.Controls.Add(this.label5);
            this.groupBox4.Controls.Add(this.label15);
            this.groupBox4.Controls.Add(this.multiUserCheckBox);
            this.groupBox4.Controls.Add(this.bytesCheckBox);
            this.groupBox4.Controls.Add(this.label14);
            this.groupBox4.Controls.Add(this.iterationsNumericUpDown);
            this.groupBox4.Location = new System.Drawing.Point(18, 33);
            this.groupBox4.Name = "groupBox4";
            this.groupBox4.Size = new System.Drawing.Size(762, 63);
            this.groupBox4.TabIndex = 4;
            this.groupBox4.TabStop = false;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(5, 16);
            this.label2.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(29, 13);
            this.label2.TabIndex = 20;
            this.label2.Text = "User";
            // 
            // stringLengthNumericUpDown
            // 
            this.stringLengthNumericUpDown.Enabled = false;
            this.stringLengthNumericUpDown.Location = new System.Drawing.Point(594, 37);
            this.stringLengthNumericUpDown.Maximum = new decimal(new int[] {
            10000000,
            0,
            0,
            0});
            this.stringLengthNumericUpDown.Name = "stringLengthNumericUpDown";
            this.stringLengthNumericUpDown.Size = new System.Drawing.Size(57, 20);
            this.stringLengthNumericUpDown.TabIndex = 59;
            this.stringLengthNumericUpDown.Value = new decimal(new int[] {
            25,
            0,
            0,
            0});
            // 
            // passwordTextbox
            // 
            this.passwordTextbox.Location = new System.Drawing.Point(69, 37);
            this.passwordTextbox.Margin = new System.Windows.Forms.Padding(2);
            this.passwordTextbox.Name = "passwordTextbox";
            this.passwordTextbox.Size = new System.Drawing.Size(208, 20);
            this.passwordTextbox.TabIndex = 3;
            this.passwordTextbox.TextChanged += new System.EventHandler(this.passwordTextbox_TextChanged);
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(5, 40);
            this.label5.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(53, 13);
            this.label5.TabIndex = 46;
            this.label5.Text = "Password";
            // 
            // label15
            // 
            this.label15.AutoSize = true;
            this.label15.Location = new System.Drawing.Point(654, 40);
            this.label15.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label15.Name = "label15";
            this.label15.Size = new System.Drawing.Size(70, 13);
            this.label15.TabIndex = 58;
            this.label15.Text = "bytes loaded.";
            // 
            // label14
            // 
            this.label14.AutoSize = true;
            this.label14.Location = new System.Drawing.Point(305, 39);
            this.label14.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label14.Name = "label14";
            this.label14.Size = new System.Drawing.Size(140, 13);
            this.label14.TabIndex = 55;
            this.label14.Text = "Iterations in multi-user mode:";
            // 
            // iterationsNumericUpDown
            // 
            this.iterationsNumericUpDown.Enabled = false;
            this.iterationsNumericUpDown.Location = new System.Drawing.Point(451, 37);
            this.iterationsNumericUpDown.Maximum = new decimal(new int[] {
            10000000,
            0,
            0,
            0});
            this.iterationsNumericUpDown.Name = "iterationsNumericUpDown";
            this.iterationsNumericUpDown.Size = new System.Drawing.Size(57, 20);
            this.iterationsNumericUpDown.TabIndex = 15;
            this.iterationsNumericUpDown.Value = new decimal(new int[] {
            1,
            0,
            0,
            0});
            // 
            // groupBox2
            // 
            this.groupBox2.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.groupBox2.Controls.Add(this.usePagingCheckBox);
            this.groupBox2.Controls.Add(this.label17);
            this.groupBox2.Controls.Add(this.pageSizeNumericUpDown);
            this.groupBox2.Controls.Add(this.pageNumberNumericUpDown);
            this.groupBox2.Controls.Add(this.label18);
            this.groupBox2.Location = new System.Drawing.Point(786, 33);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(146, 63);
            this.groupBox2.TabIndex = 4;
            this.groupBox2.TabStop = false;
            // 
            // usePagingCheckBox
            // 
            this.usePagingCheckBox.AutoSize = true;
            this.usePagingCheckBox.Location = new System.Drawing.Point(6, 16);
            this.usePagingCheckBox.Name = "usePagingCheckBox";
            this.usePagingCheckBox.Size = new System.Drawing.Size(15, 14);
            this.usePagingCheckBox.TabIndex = 64;
            this.usePagingCheckBox.UseVisualStyleBackColor = true;
            this.usePagingCheckBox.CheckedChanged += new System.EventHandler(this.usePagingCheckBox_CheckedChanged);
            // 
            // label17
            // 
            this.label17.AutoSize = true;
            this.label17.Location = new System.Drawing.Point(26, 16);
            this.label17.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label17.Name = "label17";
            this.label17.Size = new System.Drawing.Size(49, 13);
            this.label17.TabIndex = 61;
            this.label17.Text = "Page №:";
            // 
            // pageSizeNumericUpDown
            // 
            this.pageSizeNumericUpDown.Enabled = false;
            this.pageSizeNumericUpDown.Location = new System.Drawing.Point(80, 39);
            this.pageSizeNumericUpDown.Maximum = new decimal(new int[] {
            10000000,
            0,
            0,
            0});
            this.pageSizeNumericUpDown.Name = "pageSizeNumericUpDown";
            this.pageSizeNumericUpDown.Size = new System.Drawing.Size(57, 20);
            this.pageSizeNumericUpDown.TabIndex = 62;
            this.pageSizeNumericUpDown.Value = new decimal(new int[] {
            50,
            0,
            0,
            0});
            this.pageSizeNumericUpDown.ValueChanged += new System.EventHandler(this.pageNumberNumericUpDown_ValueChanged);
            // 
            // pageNumberNumericUpDown
            // 
            this.pageNumberNumericUpDown.Enabled = false;
            this.pageNumberNumericUpDown.Location = new System.Drawing.Point(80, 14);
            this.pageNumberNumericUpDown.Maximum = new decimal(new int[] {
            10000000,
            0,
            0,
            0});
            this.pageNumberNumericUpDown.Name = "pageNumberNumericUpDown";
            this.pageNumberNumericUpDown.Size = new System.Drawing.Size(57, 20);
            this.pageNumberNumericUpDown.TabIndex = 60;
            this.pageNumberNumericUpDown.Value = new decimal(new int[] {
            1,
            0,
            0,
            0});
            this.pageNumberNumericUpDown.ValueChanged += new System.EventHandler(this.pageNumberNumericUpDown_ValueChanged);
            // 
            // label18
            // 
            this.label18.AutoSize = true;
            this.label18.Location = new System.Drawing.Point(26, 41);
            this.label18.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label18.Name = "label18";
            this.label18.Size = new System.Drawing.Size(56, 13);
            this.label18.TabIndex = 63;
            this.label18.Text = "Page size:";
            // 
            // resultTextBox
            // 
            this.resultTextBox.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.resultTextBox.ForeColor = System.Drawing.Color.Gray;
            this.resultTextBox.Location = new System.Drawing.Point(18, 203);
            this.resultTextBox.Margin = new System.Windows.Forms.Padding(2);
            this.resultTextBox.Multiline = true;
            this.resultTextBox.Name = "resultTextBox";
            this.resultTextBox.ScrollBars = System.Windows.Forms.ScrollBars.Both;
            this.resultTextBox.Size = new System.Drawing.Size(1027, 145);
            this.resultTextBox.TabIndex = 30;
            this.resultTextBox.TabStop = false;
            this.resultTextBox.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.resultTextBox_KeyPress);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(15, 1);
            this.label1.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(76, 13);
            this.label1.TabIndex = 1;
            this.label1.Text = "Resulting URL";
            // 
            // cancelButton
            // 
            this.cancelButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.cancelButton.BackColor = System.Drawing.Color.Silver;
            this.cancelButton.Location = new System.Drawing.Point(970, 44);
            this.cancelButton.Margin = new System.Windows.Forms.Padding(2);
            this.cancelButton.Name = "cancelButton";
            this.cancelButton.Size = new System.Drawing.Size(75, 24);
            this.cancelButton.TabIndex = 56;
            this.cancelButton.Text = "Cancel";
            this.cancelButton.UseVisualStyleBackColor = false;
            this.cancelButton.Visible = false;
            this.cancelButton.Click += new System.EventHandler(this.cancelButton_Click);
            // 
            // runButton
            // 
            this.runButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.runButton.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(192)))), ((int)(((byte)(255)))), ((int)(((byte)(192)))));
            this.runButton.Location = new System.Drawing.Point(970, 15);
            this.runButton.Margin = new System.Windows.Forms.Padding(2);
            this.runButton.Name = "runButton";
            this.runButton.Size = new System.Drawing.Size(75, 24);
            this.runButton.TabIndex = 27;
            this.runButton.Text = "Run";
            this.runButton.UseVisualStyleBackColor = false;
            this.runButton.Click += new System.EventHandler(this.runButton_Click);
            // 
            // label9
            // 
            this.label9.AutoSize = true;
            this.label9.Location = new System.Drawing.Point(429, 97);
            this.label9.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(50, 13);
            this.label9.TabIndex = 51;
            this.label9.Text = "Browsers";
            // 
            // statusStrip1
            // 
            this.statusStrip1.Location = new System.Drawing.Point(0, 692);
            this.statusStrip1.Name = "statusStrip1";
            this.statusStrip1.Padding = new System.Windows.Forms.Padding(1, 0, 10, 0);
            this.statusStrip1.Size = new System.Drawing.Size(1058, 22);
            this.statusStrip1.TabIndex = 23;
            this.statusStrip1.Text = "statusStrip1";
            // 
            // splitContainer1
            // 
            this.splitContainer1.BackColor = System.Drawing.Color.DarkSeaGreen;
            this.splitContainer1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.splitContainer1.Location = new System.Drawing.Point(0, 0);
            this.splitContainer1.Name = "splitContainer1";
            this.splitContainer1.Orientation = System.Windows.Forms.Orientation.Horizontal;
            // 
            // splitContainer1.Panel1
            // 
            this.splitContainer1.Panel1.BackColor = System.Drawing.SystemColors.Control;
            this.splitContainer1.Panel1.Controls.Add(this.tabControl1);
            // 
            // splitContainer1.Panel2
            // 
            this.splitContainer1.Panel2.BackColor = System.Drawing.SystemColors.Control;
            this.splitContainer1.Panel2.Controls.Add(this.panel1);
            this.splitContainer1.Size = new System.Drawing.Size(1058, 692);
            this.splitContainer1.SplitterDistance = 337;
            this.splitContainer1.TabIndex = 61;
            // 
            // saveZipAsFileCheckBox
            // 
            this.saveZipAsFileCheckBox.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.saveZipAsFileCheckBox.AutoSize = true;
            this.saveZipAsFileCheckBox.Enabled = false;
            this.saveZipAsFileCheckBox.Location = new System.Drawing.Point(965, 241);
            this.saveZipAsFileCheckBox.Margin = new System.Windows.Forms.Padding(2);
            this.saveZipAsFileCheckBox.Name = "saveZipAsFileCheckBox";
            this.saveZipAsFileCheckBox.Size = new System.Drawing.Size(51, 17);
            this.saveZipAsFileCheckBox.TabIndex = 79;
            this.saveZipAsFileCheckBox.Text = "to file";
            this.saveZipAsFileCheckBox.UseVisualStyleBackColor = true;
            // 
            // clearCacheRadioButton
            // 
            this.clearCacheRadioButton.AutoSize = true;
            this.clearCacheRadioButton.Location = new System.Drawing.Point(325, 16);
            this.clearCacheRadioButton.Margin = new System.Windows.Forms.Padding(2);
            this.clearCacheRadioButton.Name = "clearCacheRadioButton";
            this.clearCacheRadioButton.Size = new System.Drawing.Size(82, 17);
            this.clearCacheRadioButton.TabIndex = 53;
            this.clearCacheRadioButton.Text = "Clear cache";
            this.toolTip1.SetToolTip(this.clearCacheRadioButton, "Provided user must be administrator.");
            this.clearCacheRadioButton.UseVisualStyleBackColor = true;
            this.clearCacheRadioButton.CheckedChanged += new System.EventHandler(this.radioButton_CheckedChanged);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1058, 714);
            this.Controls.Add(this.splitContainer1);
            this.Controls.Add(this.statusStrip1);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Margin = new System.Windows.Forms.Padding(2);
            this.MinimumSize = new System.Drawing.Size(710, 660);
            this.Name = "Form1";
            this.Text = "Simple Client";
            this.Activated += new System.EventHandler(this.Form1_Activated);
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.paramsTabControl.ResumeLayout(false);
            this.tabPage1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).EndInit();
            this.tabControl1.ResumeLayout(false);
            this.methodsTab.ResumeLayout(false);
            this.searchTab.ResumeLayout(false);
            this.searchTab.PerformLayout();
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            this.groupBox3.ResumeLayout(false);
            this.groupBox3.PerformLayout();
            this.groupBox4.ResumeLayout(false);
            this.groupBox4.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.stringLengthNumericUpDown)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.iterationsNumericUpDown)).EndInit();
            this.groupBox2.ResumeLayout(false);
            this.groupBox2.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pageSizeNumericUpDown)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.pageNumberNumericUpDown)).EndInit();
            this.splitContainer1.Panel1.ResumeLayout(false);
            this.splitContainer1.Panel2.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.splitContainer1)).EndInit();
            this.splitContainer1.ResumeLayout(false);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private ComboBox spNameComboBox;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.ToolTip toolTip1;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.CheckBox userMethodsCheckBox;
          private System.Windows.Forms.CheckBox extendResultsCheckBox;
          private System.Windows.Forms.ImageList imageList1;
          private System.Windows.Forms.TabControl tabControl1;
          private System.Windows.Forms.TabPage methodsTab;
          private System.Windows.Forms.TabPage searchTab;
          private System.Windows.Forms.Label label7;
          private System.Windows.Forms.TextBox searchBox;
          private System.Windows.Forms.ListBox ctypeListBox;
          private System.Windows.Forms.ListBox xcodeListBox;
          private System.Windows.Forms.RadioButton equalsRadio;
          private System.Windows.Forms.RadioButton containsRadio;
          private System.Windows.Forms.RadioButton endsWithRadio;
          private System.Windows.Forms.RadioButton startsWithRadio;
          private System.Windows.Forms.ListBox searchGroupsListBox;
          private System.Windows.Forms.Label label13;
          private System.Windows.Forms.Label label12;
          private System.Windows.Forms.Label label6;
          private Button button3;
          private Button button2;
          private OpenFileDialog openFileDialog1;
          private SaveFileDialog saveFileDialog1;
          private Label label16;
          private ComboBox dbComboBox;
          private Panel panel1;
          private NumericUpDown stringLengthNumericUpDown;
          private Label label1;
          private Label label15;
          private TextBox resultTextBox;
          private CheckBox bytesCheckBox;
          private TextBox baseUrlTextBox;
          private Button cancelButton;
          private ListView listView1;
          private NumericUpDown iterationsNumericUpDown;
          private Label label2;
          private Label label14;
          private Button runButton;
          private CheckBox multiUserCheckBox;
          private Label label5;
          private Button button1;
          private TextBox passwordTextbox;
          private ComboBox usernameComboBox;
          private Label label9;
          private GroupBox groupBox3;
          private RadioButton csvRadioButton;
          private RadioButton countRadioButton;
          private RadioButton jsonRadioButton;
          private CheckBox indentJsonCheckBox;
          private RadioButton xmlRadioButton;
          private Label label3;
          private CheckBox csvColumnsCheckBox;
          private TextBox delimiterTextBox;
          private RadioButton helpRadioButton;
          private CheckBox forceQuotesCheckBox;
          private RadioButton listRadioButton;
          private StatusStrip statusStrip1;
          private TabControl paramsTabControl;
          private TabPage tabPage1;
          private DataGridView dataGridView1;
          private Button loadOutputButton;
          private SplitContainer splitContainer1;
          private DataGridViewTextBoxColumn ParameterCol;
          private DataGridViewTextBoxColumn ValueCol;
          private NumericUpDown pageSizeNumericUpDown;
          private Label label18;
          private NumericUpDown pageNumberNumericUpDown;
          private Label label17;
          private CheckBox usePagingCheckBox;
          private GroupBox groupBox4;
          private GroupBox groupBox2;
        private CheckBox includeRootCheckBox;
        private CheckBox zipCheckBox;
        private CheckBox saveZipAsFileCheckBox;
        private RadioButton clearCacheRadioButton;
    }
}

