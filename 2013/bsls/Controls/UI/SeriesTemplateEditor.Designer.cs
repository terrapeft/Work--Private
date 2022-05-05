namespace Jnj.ThirdDimension.Controls.BarcodeSeries
{
   partial class SeriesTemplateEditor
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
         System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(SeriesTemplateEditor));
         this.desktopOuterPanel = new System.Windows.Forms.Panel();
         this.label1 = new System.Windows.Forms.Label();
         this.refreshButton = new System.Windows.Forms.Button();
         this.label14 = new System.Windows.Forms.Label();
         this.label4 = new System.Windows.Forms.Label();
         this.examplePanel = new System.Windows.Forms.Panel();
         this.exampleRichTextBox = new System.Windows.Forms.RichTextBox();
         this.desktopPanel = new System.Windows.Forms.Panel();
         this.toolPanel = new System.Windows.Forms.Panel();
         this.basketImage = new System.Windows.Forms.PictureBox();
         this.textDragLabel = new Jnj.ThirdDimension.Controls.BarcodeSeries.DraggableLabel();
         this.yearDragLabel = new Jnj.ThirdDimension.Controls.BarcodeSeries.DraggableLabel();
         this.monthDragLabel = new Jnj.ThirdDimension.Controls.BarcodeSeries.DraggableLabel();
         this.seriesDragLabel = new Jnj.ThirdDimension.Controls.BarcodeSeries.DraggableLabel();
         this.dayDragLabel = new Jnj.ThirdDimension.Controls.BarcodeSeries.DraggableLabel();
         this.weekDragLabel = new Jnj.ThirdDimension.Controls.BarcodeSeries.DraggableLabel();
         this.desktopOuterPanel.SuspendLayout();
         this.examplePanel.SuspendLayout();
         this.toolPanel.SuspendLayout();
         ((System.ComponentModel.ISupportInitialize)(this.basketImage)).BeginInit();
         this.SuspendLayout();
         // 
         // desktopOuterPanel
         // 
         this.desktopOuterPanel.AllowDrop = true;
         this.desktopOuterPanel.Controls.Add(this.basketImage);
         this.desktopOuterPanel.Controls.Add(this.label1);
         this.desktopOuterPanel.Controls.Add(this.refreshButton);
         this.desktopOuterPanel.Controls.Add(this.label14);
         this.desktopOuterPanel.Controls.Add(this.label4);
         this.desktopOuterPanel.Controls.Add(this.examplePanel);
         this.desktopOuterPanel.Controls.Add(this.desktopPanel);
         this.desktopOuterPanel.Controls.Add(this.toolPanel);
         this.desktopOuterPanel.Dock = System.Windows.Forms.DockStyle.Fill;
         this.desktopOuterPanel.Location = new System.Drawing.Point(0, 0);
         this.desktopOuterPanel.Name = "desktopOuterPanel";
         this.desktopOuterPanel.Size = new System.Drawing.Size(586, 198);
         this.desktopOuterPanel.TabIndex = 36;
         this.desktopOuterPanel.DragDrop += new System.Windows.Forms.DragEventHandler(this.desktopOuterPanel_DragDrop);
         this.desktopOuterPanel.DragLeave += new System.EventHandler(this.desktopOuterPanel_DragLeave);
         this.desktopOuterPanel.DragEnter += new System.Windows.Forms.DragEventHandler(this.desktopOuterPanel_DragEnter);
         // 
         // label1
         // 
         this.label1.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left)
                     | System.Windows.Forms.AnchorStyles.Right)));
         this.label1.BackColor = System.Drawing.SystemColors.Info;
         this.label1.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
         this.label1.Location = new System.Drawing.Point(101, 3);
         this.label1.Name = "label1";
         this.label1.Size = new System.Drawing.Size(373, 23);
         this.label1.TabIndex = 1080;
         this.label1.Text = "Double click on text or drag and drop an icon to start with template. Drag contro" +
             "l out to delete.";
         this.label1.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
         // 
         // refreshButton
         // 
         this.refreshButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
         this.refreshButton.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
         this.refreshButton.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F);
         this.refreshButton.Image = ((System.Drawing.Image)(resources.GetObject("refreshButton.Image")));
         this.refreshButton.Location = new System.Drawing.Point(497, 50);
         this.refreshButton.Name = "refreshButton";
         this.refreshButton.Size = new System.Drawing.Size(23, 23);
         this.refreshButton.TabIndex = 11;
         this.refreshButton.TextAlign = System.Drawing.ContentAlignment.TopCenter;
         this.refreshButton.UseVisualStyleBackColor = true;
         this.refreshButton.Click += new System.EventHandler(this.refreshButton_Click);
         // 
         // label14
         // 
         this.label14.AutoSize = true;
         this.label14.Location = new System.Drawing.Point(9, 32);
         this.label14.Name = "label14";
         this.label14.Size = new System.Drawing.Size(87, 13);
         this.label14.TabIndex = 34;
         this.label14.Text = "Add template for:";
         // 
         // label4
         // 
         this.label4.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
         this.label4.AutoSize = true;
         this.label4.Location = new System.Drawing.Point(46, 170);
         this.label4.Name = "label4";
         this.label4.Size = new System.Drawing.Size(50, 13);
         this.label4.TabIndex = 7;
         this.label4.Text = "Example:";
         // 
         // examplePanel
         // 
         this.examplePanel.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)
                     | System.Windows.Forms.AnchorStyles.Right)));
         this.examplePanel.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
         this.examplePanel.Controls.Add(this.exampleRichTextBox);
         this.examplePanel.Location = new System.Drawing.Point(102, 166);
         this.examplePanel.Name = "examplePanel";
         this.examplePanel.Padding = new System.Windows.Forms.Padding(2);
         this.examplePanel.Size = new System.Drawing.Size(372, 26);
         this.examplePanel.TabIndex = 17;
         // 
         // exampleRichTextBox
         // 
         this.exampleRichTextBox.BackColor = System.Drawing.SystemColors.Control;
         this.exampleRichTextBox.BorderStyle = System.Windows.Forms.BorderStyle.None;
         this.exampleRichTextBox.Dock = System.Windows.Forms.DockStyle.Fill;
         this.exampleRichTextBox.Font = new System.Drawing.Font("Tahoma", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
         this.exampleRichTextBox.Location = new System.Drawing.Point(2, 2);
         this.exampleRichTextBox.Multiline = false;
         this.exampleRichTextBox.Name = "exampleRichTextBox";
         this.exampleRichTextBox.ScrollBars = System.Windows.Forms.RichTextBoxScrollBars.None;
         this.exampleRichTextBox.Size = new System.Drawing.Size(366, 20);
         this.exampleRichTextBox.TabIndex = 12;
         this.exampleRichTextBox.Text = "";
         // 
         // desktopPanel
         // 
         this.desktopPanel.AllowDrop = true;
         this.desktopPanel.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                     | System.Windows.Forms.AnchorStyles.Left)
                     | System.Windows.Forms.AnchorStyles.Right)));
         this.desktopPanel.BackColor = System.Drawing.Color.WhiteSmoke;
         this.desktopPanel.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
         this.desktopPanel.Location = new System.Drawing.Point(102, 50);
         this.desktopPanel.Name = "desktopPanel";
         this.desktopPanel.Size = new System.Drawing.Size(372, 110);
         this.desktopPanel.TabIndex = 10;
         this.desktopPanel.DragDrop += new System.Windows.Forms.DragEventHandler(this.desktopPanel_DragDrop);
         this.desktopPanel.DragEnter += new System.Windows.Forms.DragEventHandler(this.desktopPanel_DragEnter);
         // 
         // toolPanel
         // 
         this.toolPanel.Controls.Add(this.textDragLabel);
         this.toolPanel.Controls.Add(this.yearDragLabel);
         this.toolPanel.Controls.Add(this.monthDragLabel);
         this.toolPanel.Controls.Add(this.seriesDragLabel);
         this.toolPanel.Controls.Add(this.dayDragLabel);
         this.toolPanel.Controls.Add(this.weekDragLabel);
         this.toolPanel.Location = new System.Drawing.Point(97, 29);
         this.toolPanel.Name = "toolPanel";
         this.toolPanel.Size = new System.Drawing.Size(381, 22);
         this.toolPanel.TabIndex = 1079;
         // 
         // basketImage
         // 
         this.basketImage.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
         this.basketImage.Image = ((System.Drawing.Image)(resources.GetObject("basketImage.Image")));
         this.basketImage.Location = new System.Drawing.Point(562, 3);
         this.basketImage.Name = "basketImage";
         this.basketImage.Size = new System.Drawing.Size(21, 21);
         this.basketImage.SizeMode = System.Windows.Forms.PictureBoxSizeMode.AutoSize;
         this.basketImage.TabIndex = 1081;
         this.basketImage.TabStop = false;
         this.basketImage.Visible = false;
         // 
         // textDragLabel
         // 
         this.textDragLabel.AutoSize = true;
         this.textDragLabel.Font = new System.Drawing.Font("Verdana", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Pixel);
         this.textDragLabel.LabelText = "TEXT";
         this.textDragLabel.Location = new System.Drawing.Point(3, 3);
         this.textDragLabel.Name = "textDragLabel";
         this.textDragLabel.Size = new System.Drawing.Size(49, 17);
         this.textDragLabel.TabIndex = 23;
         this.textDragLabel.LabelDoubleClick += new System.EventHandler(this.dragLabel_DoubleClick);
         // 
         // yearDragLabel
         // 
         this.yearDragLabel.AutoSize = true;
         this.yearDragLabel.Font = new System.Drawing.Font("Verdana", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Pixel);
         this.yearDragLabel.LabelText = "YEAR";
         this.yearDragLabel.Location = new System.Drawing.Point(140, 3);
         this.yearDragLabel.Name = "yearDragLabel";
         this.yearDragLabel.Size = new System.Drawing.Size(54, 17);
         this.yearDragLabel.TabIndex = 27;
         this.yearDragLabel.LabelDoubleClick += new System.EventHandler(this.dragLabel_DoubleClick);
         // 
         // monthDragLabel
         // 
         this.monthDragLabel.AutoSize = true;
         this.monthDragLabel.Font = new System.Drawing.Font("Verdana", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Pixel);
         this.monthDragLabel.LabelText = "MONTH";
         this.monthDragLabel.Location = new System.Drawing.Point(200, 3);
         this.monthDragLabel.Name = "monthDragLabel";
         this.monthDragLabel.Size = new System.Drawing.Size(62, 17);
         this.monthDragLabel.TabIndex = 29;
         this.monthDragLabel.LabelDoubleClick += new System.EventHandler(this.dragLabel_DoubleClick);
         // 
         // seriesDragLabel
         // 
         this.seriesDragLabel.AutoSize = true;
         this.seriesDragLabel.Font = new System.Drawing.Font("Verdana", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Pixel);
         this.seriesDragLabel.LabelText = "SERIES #";
         this.seriesDragLabel.Location = new System.Drawing.Point(58, 3);
         this.seriesDragLabel.Name = "seriesDragLabel";
         this.seriesDragLabel.Size = new System.Drawing.Size(76, 17);
         this.seriesDragLabel.TabIndex = 24;
         this.seriesDragLabel.LabelDoubleClick += new System.EventHandler(this.dragLabel_DoubleClick);
         // 
         // dayDragLabel
         // 
         this.dayDragLabel.AutoSize = true;
         this.dayDragLabel.Font = new System.Drawing.Font("Verdana", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Pixel);
         this.dayDragLabel.LabelText = "DAY";
         this.dayDragLabel.Location = new System.Drawing.Point(330, 3);
         this.dayDragLabel.Name = "dayDragLabel";
         this.dayDragLabel.Size = new System.Drawing.Size(48, 17);
         this.dayDragLabel.TabIndex = 33;
         this.dayDragLabel.LabelDoubleClick += new System.EventHandler(this.dragLabel_DoubleClick);
         // 
         // weekDragLabel
         // 
         this.weekDragLabel.AutoSize = true;
         this.weekDragLabel.Font = new System.Drawing.Font("Verdana", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Pixel);
         this.weekDragLabel.LabelText = "WEEK";
         this.weekDragLabel.Location = new System.Drawing.Point(268, 3);
         this.weekDragLabel.Name = "weekDragLabel";
         this.weekDragLabel.Size = new System.Drawing.Size(56, 17);
         this.weekDragLabel.TabIndex = 31;
         this.weekDragLabel.LabelDoubleClick += new System.EventHandler(this.dragLabel_DoubleClick);
         // 
         // SeriesTemplateEditor
         // 
         this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
         this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
         this.Controls.Add(this.desktopOuterPanel);
         this.MinimumSize = new System.Drawing.Size(586, 198);
         this.Name = "SeriesTemplateEditor";
         this.Size = new System.Drawing.Size(586, 198);
         this.desktopOuterPanel.ResumeLayout(false);
         this.desktopOuterPanel.PerformLayout();
         this.examplePanel.ResumeLayout(false);
         this.toolPanel.ResumeLayout(false);
         this.toolPanel.PerformLayout();
         ((System.ComponentModel.ISupportInitialize)(this.basketImage)).EndInit();
         this.ResumeLayout(false);

      }

      #endregion

      private System.Windows.Forms.Panel desktopOuterPanel;
      private System.Windows.Forms.Button refreshButton;
      private System.Windows.Forms.Label label14;
      private System.Windows.Forms.Label label4;
      private System.Windows.Forms.Panel examplePanel;
      private System.Windows.Forms.RichTextBox exampleRichTextBox;
      private System.Windows.Forms.Panel desktopPanel;
      private System.Windows.Forms.Panel toolPanel;
      private DraggableLabel textDragLabel;
      private DraggableLabel yearDragLabel;
      private DraggableLabel monthDragLabel;
      private DraggableLabel seriesDragLabel;
      private DraggableLabel dayDragLabel;
      private DraggableLabel weekDragLabel;
      private System.Windows.Forms.Label label1;
      private System.Windows.Forms.PictureBox basketImage;
   }
}
