﻿namespace Jnj.ThirdDimension.Controls.BarcodeSeries
{
   partial class ChooseColumn
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
         System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(ChooseColumn));
         this.label1 = new System.Windows.Forms.Label();
         this.okButton = new System.Windows.Forms.Button();
         this.groupBox1 = new System.Windows.Forms.GroupBox();
         this.columnComboBox = new System.Windows.Forms.ComboBox();
         this.framePanel = new System.Windows.Forms.Panel();
         this.framePanel.SuspendLayout();
         this.SuspendLayout();
         // 
         // label1
         // 
         this.label1.AutoSize = true;
         this.label1.Location = new System.Drawing.Point(12, 16);
         this.label1.Name = "label1";
         this.label1.Size = new System.Drawing.Size(164, 13);
         this.label1.TabIndex = 0;
         this.label1.Text = "Choose a column for new values:";
         // 
         // okButton
         // 
         this.okButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
         this.okButton.DialogResult = System.Windows.Forms.DialogResult.OK;
         this.okButton.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
         this.okButton.Location = new System.Drawing.Point(215, 83);
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
         this.groupBox1.Location = new System.Drawing.Point(-12, 70);
         this.groupBox1.Name = "groupBox1";
         this.groupBox1.Size = new System.Drawing.Size(427, 3);
         this.groupBox1.TabIndex = 1092;
         this.groupBox1.TabStop = false;
         // 
         // columnComboBox
         // 
         this.columnComboBox.Dock = System.Windows.Forms.DockStyle.Fill;
         this.columnComboBox.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
         this.columnComboBox.FormattingEnabled = true;
         this.columnComboBox.Location = new System.Drawing.Point(0, 0);
         this.columnComboBox.Name = "columnComboBox";
         this.columnComboBox.Size = new System.Drawing.Size(276, 21);
         this.columnComboBox.TabIndex = 1094;
         // 
         // framePanel
         // 
         this.framePanel.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left)
                     | System.Windows.Forms.AnchorStyles.Right)));
         this.framePanel.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
         this.framePanel.Controls.Add(this.columnComboBox);
         this.framePanel.Location = new System.Drawing.Point(12, 37);
         this.framePanel.Name = "framePanel";
         this.framePanel.Size = new System.Drawing.Size(278, 23);
         this.framePanel.TabIndex = 1095;
         // 
         // ChooseColumn
         // 
         this.AcceptButton = this.okButton;
         this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
         this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
         this.ClientSize = new System.Drawing.Size(302, 118);
         this.Controls.Add(this.framePanel);
         this.Controls.Add(this.groupBox1);
         this.Controls.Add(this.okButton);
         this.Controls.Add(this.label1);
         this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
         this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
         this.Name = "ChooseColumn";
         this.ShowIcon = false;
         this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
         this.Text = "Choose Column";
         this.framePanel.ResumeLayout(false);
         this.ResumeLayout(false);
         this.PerformLayout();

      }

      #endregion

      private System.Windows.Forms.Label label1;
      private System.Windows.Forms.Button okButton;
      private System.Windows.Forms.GroupBox groupBox1;
      private System.Windows.Forms.ComboBox columnComboBox;
      private System.Windows.Forms.Panel framePanel;
   }
}