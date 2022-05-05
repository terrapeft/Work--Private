namespace Jnj.ThirdDimension.Explorer.BarcodeSeries
{
   partial class WizardTitle
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
         System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(WizardTitle));
         this.pictureBox1 = new System.Windows.Forms.PictureBox();
         this.primaryTextLabel = new System.Windows.Forms.Label();
         this.secondaryTextLabel = new System.Windows.Forms.Label();
         ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
         this.SuspendLayout();
         // 
         // pictureBox1
         // 
         this.pictureBox1.Image = ((System.Drawing.Image)(resources.GetObject("pictureBox1.Image")));
         this.pictureBox1.Location = new System.Drawing.Point(-1, -3);
         this.pictureBox1.Name = "pictureBox1";
         this.pictureBox1.Size = new System.Drawing.Size(70, 70);
         this.pictureBox1.TabIndex = 0;
         this.pictureBox1.TabStop = false;
         // 
         // primaryTextLabel
         // 
         this.primaryTextLabel.AutoSize = true;
         this.primaryTextLabel.Font = new System.Drawing.Font("Tahoma", 23F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Pixel);
         this.primaryTextLabel.Location = new System.Drawing.Point(71, 16);
         this.primaryTextLabel.Name = "primaryTextLabel";
         this.primaryTextLabel.Size = new System.Drawing.Size(213, 28);
         this.primaryTextLabel.TabIndex = 1;
         this.primaryTextLabel.Text = "Category Name |";
         this.primaryTextLabel.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
         this.primaryTextLabel.SizeChanged += new System.EventHandler(this.primaryTextLabel_SizeChanged);
         // 
         // secondaryTextLabel
         // 
         this.secondaryTextLabel.AutoSize = true;
         this.secondaryTextLabel.Font = new System.Drawing.Font("Tahoma", 23F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Pixel);
         this.secondaryTextLabel.Location = new System.Drawing.Point(298, 18);
         this.secondaryTextLabel.Name = "secondaryTextLabel";
         this.secondaryTextLabel.Size = new System.Drawing.Size(144, 28);
         this.secondaryTextLabel.TabIndex = 2;
         this.secondaryTextLabel.Text = "Wizard name";
         // 
         // WizardTitle
         // 
         this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
         this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
         this.Controls.Add(this.secondaryTextLabel);
         this.Controls.Add(this.primaryTextLabel);
         this.Controls.Add(this.pictureBox1);
         this.Name = "WizardTitle";
         this.Size = new System.Drawing.Size(624, 66);
         this.Load += new System.EventHandler(this.WizardTitle_Load);
         ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
         this.ResumeLayout(false);
         this.PerformLayout();

      }

      #endregion

      private System.Windows.Forms.PictureBox pictureBox1;
      private System.Windows.Forms.Label primaryTextLabel;
      private System.Windows.Forms.Label secondaryTextLabel;
   }
}
