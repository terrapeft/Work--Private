namespace Jnj.ThirdDimension.Controls.BarcodeSeries
{
   partial class MapTableToDataTableDialog : IMapTableToDataTableDialog
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
         System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(MapTableToDataTableDialog));
         this.grp3DX = new System.Windows.Forms.Panel();
         this.selectedCheckBox = new System.Windows.Forms.CheckBox();
         this.panel1 = new System.Windows.Forms.Panel();
         this.cmb3DXTables = new System.Windows.Forms.ComboBox();
         this.label2 = new System.Windows.Forms.Label();
         this.label1 = new System.Windows.Forms.Label();
         this.dgvMapping = new System.Windows.Forms.DataGridView();
         this.colDestination = new System.Windows.Forms.DataGridViewTextBoxColumn();
         this.col3DX = new System.Windows.Forms.DataGridViewComboBoxColumn();
         this.colDefault = new System.Windows.Forms.DataGridViewTextBoxColumn();
         this.grpFile = new System.Windows.Forms.Panel();
         this.txtFile = new System.Windows.Forms.TextBox();
         this.btnBrowse = new System.Windows.Forms.Button();
         this.btnOK = new System.Windows.Forms.Button();
         this.btnCancel = new System.Windows.Forms.Button();
         this.rb3DX = new System.Windows.Forms.RadioButton();
         this.rbFile = new System.Windows.Forms.RadioButton();
         this.openFileDialog1 = new System.Windows.Forms.OpenFileDialog();
         this.groupBox1 = new System.Windows.Forms.GroupBox();
         this.xpToolBar1 = new Syncfusion.Windows.Forms.Tools.XPMenus.XPToolBar();
         this.loadBarItem = new Syncfusion.Windows.Forms.Tools.XPMenus.BarItem();
         this.imageList1 = new System.Windows.Forms.ImageList(this.components);
         this.saveBarItem = new Syncfusion.Windows.Forms.Tools.XPMenus.BarItem();
         this.clearBarItem = new Syncfusion.Windows.Forms.Tools.XPMenus.BarItem();
         this.saveFileDialog1 = new System.Windows.Forms.SaveFileDialog();
         this.openFileDialog2 = new System.Windows.Forms.OpenFileDialog();
         this.grp3DX.SuspendLayout();
         this.panel1.SuspendLayout();
         ((System.ComponentModel.ISupportInitialize)(this.dgvMapping)).BeginInit();
         this.grpFile.SuspendLayout();
         this.SuspendLayout();
         // 
         // grp3DX
         // 
         this.grp3DX.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                     | System.Windows.Forms.AnchorStyles.Left)
                     | System.Windows.Forms.AnchorStyles.Right)));
         this.grp3DX.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
         this.grp3DX.Controls.Add(this.selectedCheckBox);
         this.grp3DX.Controls.Add(this.panel1);
         this.grp3DX.Controls.Add(this.label2);
         this.grp3DX.Controls.Add(this.label1);
         this.grp3DX.Controls.Add(this.dgvMapping);
         this.grp3DX.Enabled = false;
         this.grp3DX.Location = new System.Drawing.Point(12, 75);
         this.grp3DX.Name = "grp3DX";
         this.grp3DX.Size = new System.Drawing.Size(426, 416);
         this.grp3DX.TabIndex = 8;
         // 
         // selectedCheckBox
         // 
         this.selectedCheckBox.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
         this.selectedCheckBox.AutoSize = true;
         this.selectedCheckBox.Location = new System.Drawing.Point(273, 19);
         this.selectedCheckBox.Name = "selectedCheckBox";
         this.selectedCheckBox.Size = new System.Drawing.Size(145, 17);
         this.selectedCheckBox.TabIndex = 10;
         this.selectedCheckBox.Text = "Import selected rows only";
         this.selectedCheckBox.UseVisualStyleBackColor = true;
         // 
         // panel1
         // 
         this.panel1.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left)
                     | System.Windows.Forms.AnchorStyles.Right)));
         this.panel1.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
         this.panel1.Controls.Add(this.cmb3DXTables);
         this.panel1.Location = new System.Drawing.Point(27, 49);
         this.panel1.Name = "panel1";
         this.panel1.Size = new System.Drawing.Size(391, 21);
         this.panel1.TabIndex = 9;
         // 
         // cmb3DXTables
         // 
         this.cmb3DXTables.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left)
                     | System.Windows.Forms.AnchorStyles.Right)));
         this.cmb3DXTables.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
         this.cmb3DXTables.FormattingEnabled = true;
         this.cmb3DXTables.Location = new System.Drawing.Point(-1, -1);
         this.cmb3DXTables.Name = "cmb3DXTables";
         this.cmb3DXTables.Size = new System.Drawing.Size(391, 21);
         this.cmb3DXTables.TabIndex = 6;
         this.cmb3DXTables.SelectedIndexChanged += new System.EventHandler(this.cmb3DXTables_SelectedIndexChanged);
         // 
         // label2
         // 
         this.label2.AutoSize = true;
         this.label2.Location = new System.Drawing.Point(26, 73);
         this.label2.Name = "label2";
         this.label2.Size = new System.Drawing.Size(73, 13);
         this.label2.TabIndex = 7;
         this.label2.Text = "Map columns:";
         // 
         // label1
         // 
         this.label1.AutoSize = true;
         this.label1.Location = new System.Drawing.Point(26, 20);
         this.label1.Name = "label1";
         this.label1.Size = new System.Drawing.Size(105, 13);
         this.label1.TabIndex = 5;
         this.label1.Text = "Available 3DX &tables";
         // 
         // dgvMapping
         // 
         this.dgvMapping.AllowUserToAddRows = false;
         this.dgvMapping.AllowUserToDeleteRows = false;
         this.dgvMapping.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                     | System.Windows.Forms.AnchorStyles.Left)
                     | System.Windows.Forms.AnchorStyles.Right)));
         this.dgvMapping.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill;
         this.dgvMapping.ColumnHeadersBorderStyle = System.Windows.Forms.DataGridViewHeaderBorderStyle.None;
         this.dgvMapping.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
         this.dgvMapping.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.colDestination,
            this.col3DX,
            this.colDefault});
         this.dgvMapping.EnableHeadersVisualStyles = false;
         this.dgvMapping.Location = new System.Drawing.Point(27, 90);
         this.dgvMapping.Name = "dgvMapping";
         this.dgvMapping.RowHeadersBorderStyle = System.Windows.Forms.DataGridViewHeaderBorderStyle.Single;
         this.dgvMapping.Size = new System.Drawing.Size(391, 318);
         this.dgvMapping.TabIndex = 8;
         this.dgvMapping.CellValueChanged += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgvMapping_CellValueChanged);
         this.dgvMapping.DataError += new System.Windows.Forms.DataGridViewDataErrorEventHandler(this.dgvMapping_DataError);
         // 
         // colDestination
         // 
         this.colDestination.DataPropertyName = "DestinationName";
         this.colDestination.HeaderText = "Destination";
         this.colDestination.Name = "colDestination";
         this.colDestination.ReadOnly = true;
         // 
         // col3DX
         // 
         this.col3DX.DataPropertyName = "SourceName";
         this.col3DX.HeaderText = "3DX";
         this.col3DX.Name = "col3DX";
         // 
         // colDefault
         // 
         this.colDefault.DataPropertyName = "DefaultValue";
         this.colDefault.HeaderText = "Default values";
         this.colDefault.Name = "colDefault";
         // 
         // grpFile
         // 
         this.grpFile.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left)
                     | System.Windows.Forms.AnchorStyles.Right)));
         this.grpFile.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
         this.grpFile.Controls.Add(this.txtFile);
         this.grpFile.Controls.Add(this.btnBrowse);
         this.grpFile.Location = new System.Drawing.Point(12, 15);
         this.grpFile.Name = "grpFile";
         this.grpFile.Size = new System.Drawing.Size(426, 45);
         this.grpFile.TabIndex = 9;
         // 
         // txtFile
         // 
         this.txtFile.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left)
                     | System.Windows.Forms.AnchorStyles.Right)));
         this.txtFile.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
         this.txtFile.Location = new System.Drawing.Point(27, 14);
         this.txtFile.Name = "txtFile";
         this.txtFile.Size = new System.Drawing.Size(310, 20);
         this.txtFile.TabIndex = 2;
         this.txtFile.TextChanged += new System.EventHandler(this.txtFile_TextChanged);
         // 
         // btnBrowse
         // 
         this.btnBrowse.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
         this.btnBrowse.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
         this.btnBrowse.Location = new System.Drawing.Point(343, 12);
         this.btnBrowse.Name = "btnBrowse";
         this.btnBrowse.Size = new System.Drawing.Size(75, 23);
         this.btnBrowse.TabIndex = 3;
         this.btnBrowse.Text = "Browse";
         this.btnBrowse.UseVisualStyleBackColor = true;
         this.btnBrowse.Click += new System.EventHandler(this.btnBrowse_Click);
         // 
         // btnOK
         // 
         this.btnOK.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
         this.btnOK.DialogResult = System.Windows.Forms.DialogResult.OK;
         this.btnOK.Enabled = false;
         this.btnOK.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
         this.btnOK.Location = new System.Drawing.Point(282, 515);
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
         this.btnCancel.Location = new System.Drawing.Point(363, 515);
         this.btnCancel.Name = "btnCancel";
         this.btnCancel.Size = new System.Drawing.Size(75, 23);
         this.btnCancel.TabIndex = 10;
         this.btnCancel.Text = "Cancel";
         this.btnCancel.UseVisualStyleBackColor = true;
         // 
         // rb3DX
         // 
         this.rb3DX.AutoSize = true;
         this.rb3DX.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
         this.rb3DX.Location = new System.Drawing.Point(20, 67);
         this.rb3DX.Name = "rb3DX";
         this.rb3DX.Size = new System.Drawing.Size(106, 17);
         this.rb3DX.TabIndex = 4;
         this.rb3DX.Text = "Import from 3DX :";
         this.rb3DX.UseVisualStyleBackColor = true;
         this.rb3DX.CheckedChanged += new System.EventHandler(this.rb3DX_CheckedChanged);
         // 
         // rbFile
         // 
         this.rbFile.AutoSize = true;
         this.rbFile.Checked = true;
         this.rbFile.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
         this.rbFile.Location = new System.Drawing.Point(20, 7);
         this.rbFile.Name = "rbFile";
         this.rbFile.Size = new System.Drawing.Size(95, 17);
         this.rbFile.TabIndex = 1;
         this.rbFile.TabStop = true;
         this.rbFile.Text = "Import from file:";
         this.rbFile.UseVisualStyleBackColor = true;
         this.rbFile.CheckedChanged += new System.EventHandler(this.rbFile_CheckedChanged);
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
         this.groupBox1.Location = new System.Drawing.Point(-4, 502);
         this.groupBox1.Name = "groupBox1";
         this.groupBox1.Size = new System.Drawing.Size(464, 3);
         this.groupBox1.TabIndex = 1091;
         this.groupBox1.TabStop = false;
         // 
         // xpToolBar1
         // 
         this.xpToolBar1.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
         this.xpToolBar1.BackColor = System.Drawing.SystemColors.Control;
         // 
         // 
         // 
         this.xpToolBar1.Bar.BarName = "";
         this.xpToolBar1.Bar.Items.AddRange(new Syncfusion.Windows.Forms.Tools.XPMenus.BarItem[] {
            this.loadBarItem,
            this.saveBarItem,
            this.clearBarItem});
         this.xpToolBar1.Bar.Manager = null;
         this.xpToolBar1.Location = new System.Drawing.Point(12, 518);
         this.xpToolBar1.Name = "xpToolBar1";
         this.xpToolBar1.Size = new System.Drawing.Size(100, 25);
         this.xpToolBar1.TabIndex = 1095;
         this.xpToolBar1.Text = "xpToolBar1";
         // 
         // loadBarItem
         // 
         this.loadBarItem.Enabled = false;
         this.loadBarItem.ImageIndex = 0;
         this.loadBarItem.ImageList = this.imageList1;
         this.loadBarItem.Tooltip = "Open mapping template.";
         this.loadBarItem.Click += new System.EventHandler(this.loadBarItem_Click);
         // 
         // imageList1
         // 
         this.imageList1.ImageStream = ((System.Windows.Forms.ImageListStreamer)(resources.GetObject("imageList1.ImageStream")));
         this.imageList1.TransparentColor = System.Drawing.Color.Transparent;
         this.imageList1.Images.SetKeyName(0, "FileOpen.png");
         this.imageList1.Images.SetKeyName(1, "FileSave.png");
         this.imageList1.Images.SetKeyName(2, "SaveToFavorites.png");
         this.imageList1.Images.SetKeyName(3, "ViewDetails.png");
         this.imageList1.Images.SetKeyName(4, "Reset.png");
         this.imageList1.Images.SetKeyName(5, "Help.png");
         this.imageList1.Images.SetKeyName(6, "WithoutPostProcess.png");
         this.imageList1.Images.SetKeyName(7, "PostProcess.png");
         this.imageList1.Images.SetKeyName(8, "WithoutLayout.png");
         this.imageList1.Images.SetKeyName(9, "AttachLayout.png");
         // 
         // saveBarItem
         // 
         this.saveBarItem.Enabled = false;
         this.saveBarItem.ImageIndex = 1;
         this.saveBarItem.ImageList = this.imageList1;
         this.saveBarItem.Tooltip = "Save mapping template.";
         this.saveBarItem.Click += new System.EventHandler(this.saveBarItem_Click);
         // 
         // clearBarItem
         // 
         this.clearBarItem.Enabled = false;
         this.clearBarItem.ImageIndex = 4;
         this.clearBarItem.ImageList = this.imageList1;
         this.clearBarItem.Tooltip = "Clean all mappings.";
         this.clearBarItem.Click += new System.EventHandler(this.clearBarItem_Click);
         // 
         // saveFileDialog1
         // 
         this.saveFileDialog1.DefaultExt = "xml";
         this.saveFileDialog1.Filter = "XML|*.xml";
         this.saveFileDialog1.Title = "Save mapping template";
         // 
         // openFileDialog2
         // 
         this.openFileDialog2.Filter = "XML|*.xml";
         this.openFileDialog2.Title = "Open mapping template";
         // 
         // MapTableToDataTableDialog
         // 
         this.AcceptButton = this.btnOK;
         this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
         this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
         this.CancelButton = this.btnCancel;
         this.ClientSize = new System.Drawing.Size(450, 553);
         this.Controls.Add(this.xpToolBar1);
         this.Controls.Add(this.groupBox1);
         this.Controls.Add(this.rbFile);
         this.Controls.Add(this.rb3DX);
         this.Controls.Add(this.btnCancel);
         this.Controls.Add(this.btnOK);
         this.Controls.Add(this.grpFile);
         this.Controls.Add(this.grp3DX);
         this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
         this.MaximizeBox = false;
         this.MinimizeBox = false;
         this.MinimumSize = new System.Drawing.Size(458, 587);
         this.Name = "MapTableToDataTableDialog";
         this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
         this.Text = "Mapping Columns";
         this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.MapTableToDataTableDialog_FormClosing);
         this.grp3DX.ResumeLayout(false);
         this.grp3DX.PerformLayout();
         this.panel1.ResumeLayout(false);
         ((System.ComponentModel.ISupportInitialize)(this.dgvMapping)).EndInit();
         this.grpFile.ResumeLayout(false);
         this.grpFile.PerformLayout();
         this.ResumeLayout(false);
         this.PerformLayout();

      }

      #endregion

      private System.Windows.Forms.Panel grp3DX;
      private System.Windows.Forms.DataGridView dgvMapping;
      private System.Windows.Forms.Panel grpFile;
      private System.Windows.Forms.TextBox txtFile;
      private System.Windows.Forms.Button btnBrowse;
      private System.Windows.Forms.Label label2;
      private System.Windows.Forms.Label label1;
      private System.Windows.Forms.ComboBox cmb3DXTables;
      private System.Windows.Forms.Button btnOK;
      private System.Windows.Forms.Button btnCancel;
      private System.Windows.Forms.RadioButton rb3DX;
      private System.Windows.Forms.RadioButton rbFile;
      private System.Windows.Forms.OpenFileDialog openFileDialog1;
      private System.Windows.Forms.DataGridViewTextBoxColumn colDestination;
      private System.Windows.Forms.DataGridViewComboBoxColumn col3DX;
      private System.Windows.Forms.DataGridViewTextBoxColumn colDefault;
      private System.Windows.Forms.GroupBox groupBox1;
      private System.Windows.Forms.Panel panel1;
      private Syncfusion.Windows.Forms.Tools.XPMenus.XPToolBar xpToolBar1;
      private System.Windows.Forms.ImageList imageList1;
      private Syncfusion.Windows.Forms.Tools.XPMenus.BarItem loadBarItem;
      private Syncfusion.Windows.Forms.Tools.XPMenus.BarItem saveBarItem;
      private System.Windows.Forms.SaveFileDialog saveFileDialog1;
      private System.Windows.Forms.OpenFileDialog openFileDialog2;
      private Syncfusion.Windows.Forms.Tools.XPMenus.BarItem clearBarItem;
      private System.Windows.Forms.CheckBox selectedCheckBox;
   }
}