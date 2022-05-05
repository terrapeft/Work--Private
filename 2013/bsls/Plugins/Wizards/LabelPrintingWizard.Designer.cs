

using Jnj.ThirdDimension.Controls.BarcodeSeries;
namespace Jnj.ThirdDimension.Explorer.BarcodeSeries
{
   partial class LabelPrintingWizard : BaseWizard
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
         System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(LabelPrintingWizard));
         this.groupBox1 = new System.Windows.Forms.GroupBox();
         this.printButton = new System.Windows.Forms.Button();
         this.panel1 = new System.Windows.Forms.Panel();
         this.generateBarcodesButton = new System.Windows.Forms.Button();
         this.xpToolBar1 = new Syncfusion.Windows.Forms.Tools.XPMenus.XPToolBar();
         this.barItemLoad = new Syncfusion.Windows.Forms.Tools.XPMenus.BarItem();
         this.imageList1 = new System.Windows.Forms.ImageList(this.components);
         this.barItemSave = new Syncfusion.Windows.Forms.Tools.XPMenus.BarItem();
         this.barItemReset = new Syncfusion.Windows.Forms.Tools.XPMenus.BarItem();
         this.barItemHelp = new Syncfusion.Windows.Forms.Tools.XPMenus.BarItem();
         this.cancelButton = new System.Windows.Forms.Button();
         this.exitButton = new System.Windows.Forms.Button();
         this.wizardTitle1 = new Jnj.ThirdDimension.Explorer.BarcodeSeries.WizardTitle();
         this.universalPrinting1 = new Jnj.ThirdDimension.Controls.BarcodeSeries.LabelPrinting();
         this.query = new System.Windows.Forms.Button();
         this.button3 = new System.Windows.Forms.Button();
         this.button2 = new System.Windows.Forms.Button();
         this.panel1.SuspendLayout();
         this.SuspendLayout();
         // 
         // groupBox1
         // 
         this.groupBox1.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)
                     | System.Windows.Forms.AnchorStyles.Right)));
         this.groupBox1.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
         this.groupBox1.Location = new System.Drawing.Point(-10, 613);
         this.groupBox1.Name = "groupBox1";
         this.groupBox1.Size = new System.Drawing.Size(870, 3);
         this.groupBox1.TabIndex = 1094;
         this.groupBox1.TabStop = false;
         // 
         // printButton
         // 
         this.printButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
         this.printButton.DialogResult = System.Windows.Forms.DialogResult.OK;
         this.printButton.Enabled = false;
         this.printButton.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
         this.printButton.Font = new System.Drawing.Font("Verdana", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Pixel);
         this.printButton.Location = new System.Drawing.Point(627, 20);
         this.printButton.Name = "printButton";
         this.printButton.Size = new System.Drawing.Size(75, 25);
         this.printButton.TabIndex = 1093;
         this.printButton.Text = "Print";
         this.printButton.UseVisualStyleBackColor = true;
         this.printButton.Click += new System.EventHandler(this.printButton_Click);
         // 
         // panel1
         // 
         this.panel1.Controls.Add(this.generateBarcodesButton);
         this.panel1.Controls.Add(this.xpToolBar1);
         this.panel1.Controls.Add(this.cancelButton);
         this.panel1.Controls.Add(this.printButton);
         this.panel1.Dock = System.Windows.Forms.DockStyle.Bottom;
         this.panel1.Location = new System.Drawing.Point(0, 615);
         this.panel1.Name = "panel1";
         this.panel1.Size = new System.Drawing.Size(822, 65);
         this.panel1.TabIndex = 1095;
         // 
         // generateBarcodesButton
         // 
         this.generateBarcodesButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
         this.generateBarcodesButton.DialogResult = System.Windows.Forms.DialogResult.OK;
         this.generateBarcodesButton.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
         this.generateBarcodesButton.Font = new System.Drawing.Font("Verdana", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Pixel);
         this.generateBarcodesButton.Location = new System.Drawing.Point(508, 20);
         this.generateBarcodesButton.Name = "generateBarcodesButton";
         this.generateBarcodesButton.Size = new System.Drawing.Size(113, 25);
         this.generateBarcodesButton.TabIndex = 1100;
         this.generateBarcodesButton.Text = "Get Series...";
         this.generateBarcodesButton.UseVisualStyleBackColor = true;
         this.generateBarcodesButton.Click += new System.EventHandler(this.generateBarcodesButton_Click);
         // 
         // xpToolBar1
         // 
         // 
         // 
         // 
         this.xpToolBar1.Bar.BarName = "";
         this.xpToolBar1.Bar.Items.AddRange(new Syncfusion.Windows.Forms.Tools.XPMenus.BarItem[] {
            this.barItemLoad,
            this.barItemSave,
            this.barItemReset,
            this.barItemHelp});
         this.xpToolBar1.Bar.Manager = null;
         this.xpToolBar1.Location = new System.Drawing.Point(20, 20);
         this.xpToolBar1.Name = "xpToolBar1";
         this.xpToolBar1.Size = new System.Drawing.Size(118, 25);
         this.xpToolBar1.TabIndex = 1097;
         this.xpToolBar1.Text = "xpToolBar1";
         // 
         // barItemLoad
         // 
         this.barItemLoad.ID = "Load";
         this.barItemLoad.ImageIndex = 0;
         this.barItemLoad.ImageList = this.imageList1;
         this.barItemLoad.Tooltip = "Imports source information.";
         this.barItemLoad.Click += new System.EventHandler(this.barItemLoad_Click);
         // 
         // imageList1
         // 
         this.imageList1.ImageStream = ((System.Windows.Forms.ImageListStreamer)(resources.GetObject("imageList1.ImageStream")));
         this.imageList1.TransparentColor = System.Drawing.Color.Transparent;
         this.imageList1.Images.SetKeyName(0, "FileOpen.png");
         this.imageList1.Images.SetKeyName(1, "FileSave.png");
         this.imageList1.Images.SetKeyName(2, "Reset.png");
         this.imageList1.Images.SetKeyName(3, "Help.png");
         this.imageList1.Images.SetKeyName(4, "");
         // 
         // barItemSave
         // 
         this.barItemSave.ID = "Save";
         this.barItemSave.ImageIndex = 1;
         this.barItemSave.ImageList = this.imageList1;
         this.barItemSave.Tooltip = "Exports information contained on the tab into a comma separated file.";
         this.barItemSave.Click += new System.EventHandler(this.barItemSave_Click);
         // 
         // barItemReset
         // 
         this.barItemReset.ID = "Reset";
         this.barItemReset.ImageIndex = 2;
         this.barItemReset.ImageList = this.imageList1;
         this.barItemReset.Tooltip = "Resets the current tab values (if possible).";
         this.barItemReset.Click += new System.EventHandler(this.barItemReset_Click);
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
         this.cancelButton.Location = new System.Drawing.Point(735, 20);
         this.cancelButton.Name = "cancelButton";
         this.cancelButton.Size = new System.Drawing.Size(75, 25);
         this.cancelButton.TabIndex = 1095;
         this.cancelButton.Text = "Cancel";
         this.cancelButton.UseVisualStyleBackColor = true;
         this.cancelButton.Click += new System.EventHandler(this.cancelButton_Click);
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
         // wizardTitle1
         // 
         this.wizardTitle1.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left)
                     | System.Windows.Forms.AnchorStyles.Right)));
         this.wizardTitle1.Location = new System.Drawing.Point(12, 12);
         this.wizardTitle1.Name = "wizardTitle1";
         this.wizardTitle1.PrimaryText = "Tools |";
         this.wizardTitle1.SecondaryText = "Label Printing Wizard";
         this.wizardTitle1.Size = new System.Drawing.Size(790, 66);
         this.wizardTitle1.TabIndex = 1097;
         // 
         // universalPrinting1
         // 
         this.universalPrinting1.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                     | System.Windows.Forms.AnchorStyles.Left)
                     | System.Windows.Forms.AnchorStyles.Right)));
         this.universalPrinting1.EnableTemplates = false;
         this.universalPrinting1.HelpUrl = null;
         this.universalPrinting1.Location = new System.Drawing.Point(12, 96);
         this.universalPrinting1.Name = "universalPrinting1";
         this.universalPrinting1.Size = new System.Drawing.Size(798, 514);
         this.universalPrinting1.TabIndex = 1098;
         // 
         // query
         // 
         this.query.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
         this.query.DialogResult = System.Windows.Forms.DialogResult.OK;
         this.query.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
         this.query.Font = new System.Drawing.Font("Verdana", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Pixel);
         this.query.Location = new System.Drawing.Point(184, 20);
         this.query.Name = "query";
         this.query.Size = new System.Drawing.Size(136, 25);
         this.query.TabIndex = 1098;
         this.query.Text = "Query Containers";
         this.query.UseVisualStyleBackColor = true;
         // 
         // button3
         // 
         this.button3.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
         this.button3.DialogResult = System.Windows.Forms.DialogResult.OK;
         this.button3.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
         this.button3.Font = new System.Drawing.Font("Verdana", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Pixel);
         this.button3.Location = new System.Drawing.Point(498, 20);
         this.button3.Name = "button3";
         this.button3.Size = new System.Drawing.Size(150, 25);
         this.button3.TabIndex = 1100;
         this.button3.Text = "Generate barcodes";
         this.button3.UseVisualStyleBackColor = true;
         // 
         // button2
         // 
         this.button2.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
         this.button2.DialogResult = System.Windows.Forms.DialogResult.OK;
         this.button2.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
         this.button2.Font = new System.Drawing.Font("Verdana", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Pixel);
         this.button2.Location = new System.Drawing.Point(326, 20);
         this.button2.Name = "button2";
         this.button2.Size = new System.Drawing.Size(127, 25);
         this.button2.TabIndex = 1099;
         this.button2.Text = "Query Locations";
         this.button2.UseVisualStyleBackColor = true;
         // 
         // LabelPrintingWizard
         // 
         this.AcceptButton = this.printButton;
         this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
         this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
         this.CancelButton = this.cancelButton;
         this.ClientSize = new System.Drawing.Size(822, 680);
         this.Controls.Add(this.universalPrinting1);
         this.Controls.Add(this.wizardTitle1);
         this.Controls.Add(this.groupBox1);
         this.Controls.Add(this.panel1);
         this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
         this.MinimumSize = new System.Drawing.Size(830, 630);
         this.Name = "LabelPrintingWizard";
         this.Text = "Universal Printing Wizard";
         this.panel1.ResumeLayout(false);
         this.ResumeLayout(false);

      }

      #endregion

      private System.Windows.Forms.GroupBox groupBox1;
      private System.Windows.Forms.Panel panel1;
      private System.Windows.Forms.Button cancelButton;
      private System.Windows.Forms.Button exitButton;
      private Syncfusion.Windows.Forms.Tools.XPMenus.XPToolBar xpToolBar1;
      private Syncfusion.Windows.Forms.Tools.XPMenus.BarItem barItemLoad;
      private Syncfusion.Windows.Forms.Tools.XPMenus.BarItem barItemSave;
      private Syncfusion.Windows.Forms.Tools.XPMenus.BarItem barItemReset;
      private Syncfusion.Windows.Forms.Tools.XPMenus.BarItem barItemHelp;
      private WizardTitle wizardTitle1;
      private System.Windows.Forms.ImageList imageList1;
      private System.Windows.Forms.Button printButton;
      private Jnj.ThirdDimension.Controls.BarcodeSeries.LabelPrinting universalPrinting1;
      private System.Windows.Forms.Button generateBarcodesButton;
      private System.Windows.Forms.Button query;
      private System.Windows.Forms.Button button3;
      private System.Windows.Forms.Button button2;
   }
}