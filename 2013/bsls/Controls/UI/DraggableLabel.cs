#region Copyright (C) 1994-2009, Johnson & Johnson PRD, LLC.
//---------------------------------------------------------------------------*
//
//    DraggableLabel.cs: Label for dragging.
//
//---
//
//    Copyright (C) 1994-2009, Johnson & Johnson PRD, LLC.
//    All Rights Reserved.
//
//    Vitaly Chupaev, 11/2009
//
//---------------------------------------------------------------------------*/
#endregion

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace Jnj.ThirdDimension.Controls.BarcodeSeries
{
   /// <summary>
   /// Label for dragging.
   /// </summary>
   public class DraggableLabel : UserControl
   {
      private PictureBox pictureBox1;
      private ToolTip toolTip1;
      private System.ComponentModel.IContainer components;
      private Label label1;
   
      public DraggableLabel()
      {
         InitializeComponent();
      }

      #region Properties

      public string LabelText
      {
         get
         {
            return label1.Text;
         }
         set
         {
            label1.Text = value;
         }
      }

      #endregion

      #region Initialize

      private void InitializeComponent()
      {
         this.components = new System.ComponentModel.Container();
         System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(DraggableLabel));
         this.label1 = new System.Windows.Forms.Label();
         this.pictureBox1 = new System.Windows.Forms.PictureBox();
         this.toolTip1 = new System.Windows.Forms.ToolTip(this.components);
         ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
         this.SuspendLayout();
         // 
         // label1
         // 
         this.label1.AutoSize = true;
         this.label1.Font = new System.Drawing.Font("Verdana", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Pixel, ((byte)(204)));
         this.label1.Location = new System.Drawing.Point(14, 2);
         this.label1.Name = "label1";
         this.label1.Size = new System.Drawing.Size(39, 12);
         this.label1.TabIndex = 0;
         this.label1.Text = "label1";
         this.toolTip1.SetToolTip(this.label1, "Double Click");
         this.label1.DoubleClick += new System.EventHandler(this.label1_DoubleClick);
         // 
         // pictureBox1
         // 
         this.pictureBox1.Image = ((System.Drawing.Image)(resources.GetObject("pictureBox1.Image")));
         this.pictureBox1.Location = new System.Drawing.Point(3, 3);
         this.pictureBox1.Name = "pictureBox1";
         this.pictureBox1.Size = new System.Drawing.Size(11, 11);
         this.pictureBox1.TabIndex = 1;
         this.pictureBox1.TabStop = false;
         this.toolTip1.SetToolTip(this.pictureBox1, "Drag-n-Drop");
         this.pictureBox1.MouseLeave += new System.EventHandler(this.pictureBox1_MouseLeave);
         this.pictureBox1.MouseDown += new System.Windows.Forms.MouseEventHandler(this.pictureBox1_MouseDown);
         this.pictureBox1.MouseEnter += new System.EventHandler(this.pictureBox1_MouseEnter);
         // 
         // DraggableLabel
         // 
         this.Controls.Add(this.pictureBox1);
         this.Controls.Add(this.label1);
         this.Name = "DraggableLabel";
         this.Size = new System.Drawing.Size(211, 17);
         ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
         this.ResumeLayout(false);
         this.PerformLayout();

      }
      
      #endregion

      #region Few methods

      protected virtual void OnLabelDoubleClick(EventArgs e)
      {
         if (LabelDoubleClick != null)
         {
            LabelDoubleClick(this, e);
         }
      }

      #endregion

      #region Event handlers

      private void pictureBox1_MouseDown(object sender, MouseEventArgs e)
      {
         this.DoDragDrop(this.Tag, DragDropEffects.Copy);
         base.OnMouseDown(e);
      }

      private void pictureBox1_MouseEnter(object sender, EventArgs e)
      {
         pictureBox1.Cursor = Cursors.Hand;
      }

      private void pictureBox1_MouseLeave(object sender, EventArgs e)
      {
         pictureBox1.Cursor = Cursors.Default;
      }

      private void label1_DoubleClick(object sender, EventArgs e)
      {
         OnLabelDoubleClick(e);
      }

      #endregion

      #region Custom events

      /// <summary>
      /// Occures on double click on label.
      /// </summary>
      public event EventHandler LabelDoubleClick;

      #endregion
   }
}
