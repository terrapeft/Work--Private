using Jnj.ThirdDimension.Controls.BarcodeSeries;
namespace Jnj.ThirdDimension.Explorer.BarcodeSeries
{
   partial class SeriesManagerWizard
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
         System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(SeriesManagerWizard));
         this.groupBox1 = new System.Windows.Forms.GroupBox();
         this.submitButton = new System.Windows.Forms.Button();
         this.panel1 = new System.Windows.Forms.Panel();
         this.xpToolBar1 = new Syncfusion.Windows.Forms.Tools.XPMenus.XPToolBar();
         this.barItemReset = new Syncfusion.Windows.Forms.Tools.XPMenus.BarItem();
         this.imageList1 = new System.Windows.Forms.ImageList(this.components);
         this.barItemHelp = new Syncfusion.Windows.Forms.Tools.XPMenus.BarItem();
         this.cancelButton = new System.Windows.Forms.Button();
         this.exitButton = new System.Windows.Forms.Button();
         this.seriesManager = new Jnj.ThirdDimension.Controls.BarcodeSeries.SeriesManager();
         this.wizardTitle1 = new Jnj.ThirdDimension.Explorer.BarcodeSeries.WizardTitle();
         this.panel1.SuspendLayout();
         this.SuspendLayout();
         // 
         // groupBox1
         // 
         this.groupBox1.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)
                     | System.Windows.Forms.AnchorStyles.Right)));
         this.groupBox1.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
         this.groupBox1.Location = new System.Drawing.Point(-10, 656);
         this.groupBox1.Name = "groupBox1";
         this.groupBox1.Size = new System.Drawing.Size(840, 3);
         this.groupBox1.TabIndex = 1094;
         this.groupBox1.TabStop = false;
         // 
         // submitButton
         // 
         this.submitButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
         this.submitButton.DialogResult = System.Windows.Forms.DialogResult.OK;
         this.submitButton.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
         this.submitButton.Font = new System.Drawing.Font("Verdana", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Pixel);
         this.submitButton.Location = new System.Drawing.Point(616, 20);
         this.submitButton.Name = "submitButton";
         this.submitButton.Size = new System.Drawing.Size(75, 25);
         this.submitButton.TabIndex = 1093;
         this.submitButton.Text = "Save";
         this.submitButton.UseVisualStyleBackColor = true;
         this.submitButton.Click += new System.EventHandler(this.submitButton_Click);
         // 
         // panel1
         // 
         this.panel1.Controls.Add(this.xpToolBar1);
         this.panel1.Controls.Add(this.cancelButton);
         this.panel1.Controls.Add(this.submitButton);
         this.panel1.Dock = System.Windows.Forms.DockStyle.Bottom;
         this.panel1.Location = new System.Drawing.Point(0, 658);
         this.panel1.Name = "panel1";
         this.panel1.Size = new System.Drawing.Size(792, 65);
         this.panel1.TabIndex = 1095;
         // 
         // xpToolBar1
         // 
         // 
         // 
         // 
         this.xpToolBar1.Bar.BarName = "";
         this.xpToolBar1.Bar.Items.AddRange(new Syncfusion.Windows.Forms.Tools.XPMenus.BarItem[] {
            this.barItemReset,
            this.barItemHelp});
         this.xpToolBar1.Bar.Manager = null;
         this.xpToolBar1.Location = new System.Drawing.Point(20, 20);
         this.xpToolBar1.Name = "xpToolBar1";
         this.xpToolBar1.Size = new System.Drawing.Size(67, 25);
         this.xpToolBar1.TabIndex = 1097;
         this.xpToolBar1.Text = "xpToolBar1";
         // 
         // barItemReset
         // 
         this.barItemReset.ID = "Reset";
         this.barItemReset.ImageIndex = 2;
         this.barItemReset.ImageList = this.imageList1;
         this.barItemReset.Tooltip = "Resets the current tab values (if possible).";
         this.barItemReset.Click += new System.EventHandler(this.barItemReset_Click);
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
         // barItemHelp
         // 
         this.barItemHelp.ID = "Help";
         this.barItemHelp.ImageIndex = 3;
         this.barItemHelp.ImageList = this.imageList1;
         this.barItemHelp.Tooltip = "Displays help information about component.";
         this.barItemHelp.Click += new System.EventHandler(this.barItemHelp_Click);
         // 
         // cancelButton
         // 
         this.cancelButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
         this.cancelButton.DialogResult = System.Windows.Forms.DialogResult.Cancel;
         this.cancelButton.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
         this.cancelButton.Font = new System.Drawing.Font("Verdana", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Pixel);
         this.cancelButton.Location = new System.Drawing.Point(697, 20);
         this.cancelButton.Name = "cancelButton";
         this.cancelButton.Size = new System.Drawing.Size(75, 25);
         this.cancelButton.TabIndex = 1095;
         this.cancelButton.Text = "Cancel";
         this.cancelButton.UseVisualStyleBackColor = true;
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
         // seriesManager
         // 
         this.seriesManager.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                     | System.Windows.Forms.AnchorStyles.Left)
                     | System.Windows.Forms.AnchorStyles.Right)));
         this.seriesManager.DataLayer = null;
         this.seriesManager.Day = false;
         this.seriesManager.EditMode = false;
         this.seriesManager.HelpUrl = null;
         this.seriesManager.Location = new System.Drawing.Point(12, 89);
         this.seriesManager.MinimumSize = new System.Drawing.Size(671, 563);
         this.seriesManager.Month = false;
         this.seriesManager.Name = "seriesManager";
         this.seriesManager.Never = true;
         this.seriesManager.RangeName = "";
         this.seriesManager.RangeStart = ((long)(1));
         this.seriesManager.Size = new System.Drawing.Size(768, 563);
         this.seriesManager.TabIndex = 1096;
         this.seriesManager.Week = false;
         this.seriesManager.Year = false;
         // 
         // wizardTitle1
         // 
         this.wizardTitle1.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left)
                     | System.Windows.Forms.AnchorStyles.Right)));
         this.wizardTitle1.Location = new System.Drawing.Point(12, 12);
         this.wizardTitle1.Name = "wizardTitle1";
         this.wizardTitle1.PrimaryText = "Tools |";
         this.wizardTitle1.SecondaryText = "Series Manager";
         this.wizardTitle1.Size = new System.Drawing.Size(720, 66);
         this.wizardTitle1.TabIndex = 1097;
         // 
         // SeriesManagerWizard
         // 
         this.AcceptButton = this.submitButton;
         this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
         this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
         this.CancelButton = this.cancelButton;
         this.ClientSize = new System.Drawing.Size(792, 723);
         this.Controls.Add(this.wizardTitle1);
         this.Controls.Add(this.seriesManager);
         this.Controls.Add(this.groupBox1);
         this.Controls.Add(this.panel1);
         this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
         this.MinimumSize = new System.Drawing.Size(800, 747);
         this.Name = "SeriesManagerWizard";
         this.Text = "Series Manager";
         this.panel1.ResumeLayout(false);
         this.ResumeLayout(false);

      }

      #endregion

      private System.Windows.Forms.GroupBox groupBox1;
      private System.Windows.Forms.Button submitButton;
      private System.Windows.Forms.Panel panel1;
      private System.Windows.Forms.Button cancelButton;
      private System.Windows.Forms.Button exitButton;
      private Syncfusion.Windows.Forms.Tools.XPMenus.XPToolBar xpToolBar1;
      private Syncfusion.Windows.Forms.Tools.XPMenus.BarItem barItemReset;
      private Syncfusion.Windows.Forms.Tools.XPMenus.BarItem barItemHelp;


      private SeriesManager seriesManager;
      private WizardTitle wizardTitle1;
      private System.Windows.Forms.ImageList imageList1;
   }
}