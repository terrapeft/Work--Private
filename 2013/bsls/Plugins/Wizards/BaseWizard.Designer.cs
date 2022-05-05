using Jnj.ThirdDimension.Controls.BarcodeSeries;
namespace Jnj.ThirdDimension.Explorer.BarcodeSeries
{
   partial class BaseWizard
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
         System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(BaseWizard));
         this.imageList1 = new System.Windows.Forms.ImageList(this.components);
         this.exitButton = new System.Windows.Forms.Button();
         this.SuspendLayout();
         // 
         // imageList1
         // 
         this.imageList1.ImageStream = ((System.Windows.Forms.ImageListStreamer)(resources.GetObject("imageList1.ImageStream")));
         this.imageList1.TransparentColor = System.Drawing.Color.Transparent;
         this.imageList1.Images.SetKeyName(0, "FileOpen.png");
         this.imageList1.Images.SetKeyName(1, "FileSave.png");
         this.imageList1.Images.SetKeyName(2, "Reset.png");
         this.imageList1.Images.SetKeyName(3, "Help.png");
         this.imageList1.Images.SetKeyName(4, "print.bmp");
         // 
         // exitButton
         // 
         this.exitButton.Location = new System.Drawing.Point(0, 0);
         this.exitButton.Name = "exitButton";
         this.exitButton.Size = new System.Drawing.Size(75, 25);
         this.exitButton.TabIndex = 1095;
         this.exitButton.Text = "Exit";
         this.exitButton.UseVisualStyleBackColor = true;
         // 
         // BaseWizard
         // 
         this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
         this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
         this.ClientSize = new System.Drawing.Size(346, 235);
         this.Name = "BaseWizard";
         this.Text = "Base Wizard";
         this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.Wizard_FormClosing);
         this.ResumeLayout(false);

      }

      #endregion

      private System.Windows.Forms.Button exitButton;
      private System.Windows.Forms.ImageList imageList1;
   }
}