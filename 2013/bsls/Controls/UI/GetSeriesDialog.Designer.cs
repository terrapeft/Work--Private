namespace Jnj.ThirdDimension.Controls.BarcodeSeries
{
   partial class GetSeriesDialog
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
         System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(GetSeriesDialog));
         this.label1 = new System.Windows.Forms.Label();
         this.okButton = new System.Windows.Forms.Button();
         this.groupBox1 = new System.Windows.Forms.GroupBox();
         this.panel1 = new System.Windows.Forms.Panel();
         this.cancelButton = new System.Windows.Forms.Button();
         this.columnPanel = new System.Windows.Forms.Panel();
         this.columnComboBox = new Syncfusion.Windows.Forms.Tools.ComboBoxAdv();
         this.numberPanel = new System.Windows.Forms.Panel();
         this.integerTextBox1 = new Syncfusion.Windows.Forms.Tools.IntegerTextBox();
         this.label2 = new System.Windows.Forms.Label();
         this.panel3 = new System.Windows.Forms.Panel();
         this.findButton = new System.Windows.Forms.Button();
         this.rangeTextBox = new System.Windows.Forms.TextBox();
         this.label3 = new System.Windows.Forms.Label();
         this.panel1.SuspendLayout();
         this.columnPanel.SuspendLayout();
         ((System.ComponentModel.ISupportInitialize)(this.columnComboBox)).BeginInit();
         this.numberPanel.SuspendLayout();
         ((System.ComponentModel.ISupportInitialize)(this.integerTextBox1)).BeginInit();
         this.panel3.SuspendLayout();
         this.SuspendLayout();
         // 
         // label1
         // 
         this.label1.AutoSize = true;
         this.label1.Location = new System.Drawing.Point(15, 4);
         this.label1.Name = "label1";
         this.label1.Size = new System.Drawing.Size(101, 13);
         this.label1.TabIndex = 0;
         this.label1.Text = "Destination Column:";
         // 
         // okButton
         // 
         this.okButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
         this.okButton.DialogResult = System.Windows.Forms.DialogResult.OK;
         this.okButton.Enabled = false;
         this.okButton.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
         this.okButton.Location = new System.Drawing.Point(245, 18);
         this.okButton.Name = "okButton";
         this.okButton.Size = new System.Drawing.Size(75, 23);
         this.okButton.TabIndex = 2;
         this.okButton.Text = "OK";
         this.okButton.UseVisualStyleBackColor = true;
         // 
         // groupBox1
         // 
         this.groupBox1.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)
                     | System.Windows.Forms.AnchorStyles.Right)));
         this.groupBox1.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
         this.groupBox1.Location = new System.Drawing.Point(-11, 3);
         this.groupBox1.Name = "groupBox1";
         this.groupBox1.Size = new System.Drawing.Size(535, 3);
         this.groupBox1.TabIndex = 1092;
         this.groupBox1.TabStop = false;
         // 
         // panel1
         // 
         this.panel1.Controls.Add(this.cancelButton);
         this.panel1.Controls.Add(this.okButton);
         this.panel1.Controls.Add(this.groupBox1);
         this.panel1.Dock = System.Windows.Forms.DockStyle.Bottom;
         this.panel1.Location = new System.Drawing.Point(0, 99);
         this.panel1.Name = "panel1";
         this.panel1.Size = new System.Drawing.Size(413, 53);
         this.panel1.TabIndex = 1096;
         // 
         // cancelButton
         // 
         this.cancelButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
         this.cancelButton.DialogResult = System.Windows.Forms.DialogResult.Cancel;
         this.cancelButton.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
         this.cancelButton.Location = new System.Drawing.Point(326, 18);
         this.cancelButton.Name = "cancelButton";
         this.cancelButton.Size = new System.Drawing.Size(75, 23);
         this.cancelButton.TabIndex = 1093;
         this.cancelButton.Text = "Cancel";
         this.cancelButton.UseVisualStyleBackColor = true;
         // 
         // columnPanel
         // 
         this.columnPanel.Controls.Add(this.columnComboBox);
         this.columnPanel.Controls.Add(this.label1);
         this.columnPanel.Location = new System.Drawing.Point(0, 40);
         this.columnPanel.Name = "columnPanel";
         this.columnPanel.Padding = new System.Windows.Forms.Padding(10);
         this.columnPanel.Size = new System.Drawing.Size(413, 25);
         this.columnPanel.TabIndex = 1097;
         // 
         // columnComboBox
         // 
         this.columnComboBox.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left)
                     | System.Windows.Forms.AnchorStyles.Right)));
         this.columnComboBox.Border3DStyle = System.Windows.Forms.Border3DStyle.Flat;
         this.columnComboBox.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
         this.columnComboBox.FlatBorderColor = System.Drawing.Color.Black;
         this.columnComboBox.FlatStyle = Syncfusion.Windows.Forms.Tools.ComboFlatStyle.Flat;
         this.columnComboBox.Location = new System.Drawing.Point(122, 1);
         this.columnComboBox.Name = "columnComboBox";
         this.columnComboBox.Size = new System.Drawing.Size(250, 21);
         this.columnComboBox.Style = Syncfusion.Windows.Forms.VisualStyle.OfficeXP;
         this.columnComboBox.TabIndex = 3;
         // 
         // numberPanel
         // 
         this.numberPanel.Controls.Add(this.integerTextBox1);
         this.numberPanel.Controls.Add(this.label2);
         this.numberPanel.Enabled = false;
         this.numberPanel.Location = new System.Drawing.Point(0, 69);
         this.numberPanel.Name = "numberPanel";
         this.numberPanel.Padding = new System.Windows.Forms.Padding(10);
         this.numberPanel.Size = new System.Drawing.Size(413, 38);
         this.numberPanel.TabIndex = 1099;
         // 
         // integerTextBox1
         // 
         this.integerTextBox1.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
         this.integerTextBox1.IntegerValue = ((long)(1));
         this.integerTextBox1.Location = new System.Drawing.Point(122, 0);
         this.integerTextBox1.MinValue = ((long)(1));
         this.integerTextBox1.Name = "integerTextBox1";
         this.integerTextBox1.NullString = "0";
         this.integerTextBox1.Size = new System.Drawing.Size(50, 20);
         this.integerTextBox1.TabIndex = 1;
         // 
         // label2
         // 
         this.label2.AutoSize = true;
         this.label2.Location = new System.Drawing.Point(55, 2);
         this.label2.Name = "label2";
         this.label2.Size = new System.Drawing.Size(61, 13);
         this.label2.TabIndex = 0;
         this.label2.Text = "How Many:";
         // 
         // panel3
         // 
         this.panel3.Controls.Add(this.findButton);
         this.panel3.Controls.Add(this.rangeTextBox);
         this.panel3.Controls.Add(this.label3);
         this.panel3.Dock = System.Windows.Forms.DockStyle.Top;
         this.panel3.Location = new System.Drawing.Point(0, 0);
         this.panel3.Name = "panel3";
         this.panel3.Padding = new System.Windows.Forms.Padding(10);
         this.panel3.Size = new System.Drawing.Size(413, 35);
         this.panel3.TabIndex = 1098;
         // 
         // findButton
         // 
         this.findButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
         this.findButton.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
         this.findButton.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F);
         this.findButton.Image = ((System.Drawing.Image)(resources.GetObject("findButton.Image")));
         this.findButton.Location = new System.Drawing.Point(378, 12);
         this.findButton.Name = "findButton";
         this.findButton.Size = new System.Drawing.Size(23, 23);
         this.findButton.TabIndex = 1082;
         this.findButton.TextAlign = System.Drawing.ContentAlignment.TopCenter;
         this.findButton.UseVisualStyleBackColor = true;
         this.findButton.Click += new System.EventHandler(this.findButton_Click);
         // 
         // rangeTextBox
         // 
         this.rangeTextBox.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left)
                     | System.Windows.Forms.AnchorStyles.Right)));
         this.rangeTextBox.BackColor = System.Drawing.SystemColors.Window;
         this.rangeTextBox.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
         this.rangeTextBox.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F);
         this.rangeTextBox.Location = new System.Drawing.Point(122, 13);
         this.rangeTextBox.Name = "rangeTextBox";
         this.rangeTextBox.ReadOnly = true;
         this.rangeTextBox.Size = new System.Drawing.Size(250, 20);
         this.rangeTextBox.TabIndex = 1081;
         // 
         // label3
         // 
         this.label3.AutoSize = true;
         this.label3.Location = new System.Drawing.Point(9, 17);
         this.label3.Name = "label3";
         this.label3.Size = new System.Drawing.Size(107, 13);
         this.label3.TabIndex = 1080;
         this.label3.Text = "Choose Label Series:";
         // 
         // GetSeriesDialog
         // 
         this.AcceptButton = this.okButton;
         this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
         this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
         this.CancelButton = this.cancelButton;
         this.ClientSize = new System.Drawing.Size(413, 152);
         this.Controls.Add(this.panel3);
         this.Controls.Add(this.panel1);
         this.Controls.Add(this.numberPanel);
         this.Controls.Add(this.columnPanel);
         this.ForeColor = System.Drawing.SystemColors.ControlText;
         this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
         this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
         this.Name = "GetSeriesDialog";
         this.ShowIcon = false;
         this.ShowInTaskbar = false;
         this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
         this.Text = "Get Series";
         this.panel1.ResumeLayout(false);
         this.columnPanel.ResumeLayout(false);
         this.columnPanel.PerformLayout();
         ((System.ComponentModel.ISupportInitialize)(this.columnComboBox)).EndInit();
         this.numberPanel.ResumeLayout(false);
         this.numberPanel.PerformLayout();
         ((System.ComponentModel.ISupportInitialize)(this.integerTextBox1)).EndInit();
         this.panel3.ResumeLayout(false);
         this.panel3.PerformLayout();
         this.ResumeLayout(false);

      }

      #endregion

      private System.Windows.Forms.Label label1;
      private System.Windows.Forms.Button okButton;
      private System.Windows.Forms.GroupBox groupBox1;
      private System.Windows.Forms.Panel panel1;
      private System.Windows.Forms.Panel columnPanel;
      private System.Windows.Forms.Panel panel3;
      private System.Windows.Forms.TextBox rangeTextBox;
      private System.Windows.Forms.Label label3;
      private System.Windows.Forms.Button findButton;
      private System.Windows.Forms.Panel numberPanel;
      private Syncfusion.Windows.Forms.Tools.IntegerTextBox integerTextBox1;
      private System.Windows.Forms.Label label2;
      private Syncfusion.Windows.Forms.Tools.ComboBoxAdv columnComboBox;
      private System.Windows.Forms.Button cancelButton;
   }
}