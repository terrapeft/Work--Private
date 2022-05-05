namespace Jnj.ThirdDimension.Controls.BarcodeSeries
{
   partial class MappingDialog
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
         System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(MappingDialog));
         this.btnOK = new System.Windows.Forms.Button();
         this.btnCancel = new System.Windows.Forms.Button();
         this.openFileDialog1 = new System.Windows.Forms.OpenFileDialog();
         this.groupBox1 = new System.Windows.Forms.GroupBox();
         this.label2 = new System.Windows.Forms.Label();
         this.dgvMapping = new System.Windows.Forms.DataGridView();
         this.colDestination = new System.Windows.Forms.DataGridViewTextBoxColumn();
         this.col3DX = new System.Windows.Forms.DataGridViewComboBoxColumn();
         ((System.ComponentModel.ISupportInitialize)(this.dgvMapping)).BeginInit();
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
            this.col3DX});
         this.dgvMapping.EnableHeadersVisualStyles = false;
         this.dgvMapping.Location = new System.Drawing.Point(12, 28);
         this.dgvMapping.Name = "dgvMapping";
         this.dgvMapping.RowHeadersBorderStyle = System.Windows.Forms.DataGridViewHeaderBorderStyle.Single;
         this.dgvMapping.Size = new System.Drawing.Size(381, 404);
         this.dgvMapping.TabIndex = 1098;
         this.dgvMapping.CellValueChanged += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgvMapping_CellValueChanged);
         // 
         // colDestination
         // 
         this.colDestination.DataPropertyName = "DestinationName";
         this.colDestination.HeaderText = "Template";
         this.colDestination.Name = "colDestination";
         this.colDestination.ReadOnly = true;
         // 
         // col3DX
         // 
         this.col3DX.DataPropertyName = "SourceName";
         this.col3DX.HeaderText = "Grid";
         this.col3DX.Name = "col3DX";
         // 
         // MapTemplateDialog
         // 
         this.AcceptButton = this.btnOK;
         this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
         this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
         this.CancelButton = this.btnCancel;
         this.ClientSize = new System.Drawing.Size(405, 497);
         this.Controls.Add(this.label2);
         this.Controls.Add(this.dgvMapping);
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
         ((System.ComponentModel.ISupportInitialize)(this.dgvMapping)).EndInit();
         this.ResumeLayout(false);
         this.PerformLayout();

      }

      #endregion

      private System.Windows.Forms.Button btnOK;
      private System.Windows.Forms.Button btnCancel;
      private System.Windows.Forms.OpenFileDialog openFileDialog1;
      private System.Windows.Forms.GroupBox groupBox1;
      private System.Windows.Forms.Label label2;
      private System.Windows.Forms.DataGridView dgvMapping;
      private System.Windows.Forms.DataGridViewTextBoxColumn colDestination;
      private System.Windows.Forms.DataGridViewComboBoxColumn col3DX;
   }
}