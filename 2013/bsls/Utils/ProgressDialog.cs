using System;
using System.ComponentModel;
using System.Drawing;
using System.Windows.Forms;
using Syncfusion.Windows.Forms.Tools;

namespace Jnj.ThirdDimension.Utils.BarcodeSeries
{
   internal sealed class AsynchronousWaitDialogForm : Form
   {
      internal AsynchronousWaitDialogForm()
      {
         InitializeComponent();
         cancelButton.Text = "Cancel";
         taskLabel.Text = "Please wait...";
         this.ShowInTaskbar = false;
      }

      void CancelButtonClick(object sender, System.EventArgs e)
      {
         cancelButton.Enabled = false;
      }

      private Panel panel1;

      /// <summary>
		/// Designer variable used to keep track of non-visual components.
		/// </summary>
		private System.ComponentModel.IContainer components = null;
		
		/// <summary>
		/// Disposes resources used by the form.
		/// </summary>
		/// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
		protected override void Dispose(bool disposing)
		{
			if (disposing) {
				if (components != null) {
					components.Dispose();
				}
			}
			base.Dispose(disposing);
		}

      internal void UpdateProgressBarLocation()
      {
         Rectangle progressBounds = progressBar.Bounds;
         if (cancelButton.Visible)
         {
            Rectangle cancelBounds = cancelButton.Bounds;
            progressBounds.Width = cancelBounds.Left - 2 * progressBounds.Left;
            Application.DoEvents();
         }
         else
         {
            Rectangle clientR = ClientRectangle;
            progressBounds.Width = clientR.Width - 2 * progressBounds.Left;
         }
         progressBar.Bounds = progressBounds;
      }
		
		/// <summary>
		/// This method is required for Windows Forms designer support.
		/// Do not change the method contents inside the source code editor. The Forms designer might
		/// not be able to load this method if it was changed manually.
		/// </summary>
		private void InitializeComponent()
		{
         this.taskLabel = new System.Windows.Forms.Label();
         this.cancelButton = new System.Windows.Forms.Button();
         this.progressBar = new Syncfusion.Windows.Forms.Tools.ProgressBarAdv();
         this.panel1 = new System.Windows.Forms.Panel();
         ((System.ComponentModel.ISupportInitialize)(this.progressBar)).BeginInit();
         this.panel1.SuspendLayout();
         this.SuspendLayout();
         // 
         // taskLabel
         // 
         this.taskLabel.Location = new System.Drawing.Point(12, 8);
         this.taskLabel.Name = "taskLabel";
         this.taskLabel.Size = new System.Drawing.Size(311, 46);
         this.taskLabel.TabIndex = 0;
         this.taskLabel.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
         // 
         // cancelButton
         // 
         this.cancelButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
         this.cancelButton.DialogResult = System.Windows.Forms.DialogResult.Cancel;
         this.cancelButton.Location = new System.Drawing.Point(253, 57);
         this.cancelButton.Name = "cancelButton";
         this.cancelButton.Size = new System.Drawing.Size(75, 23);
         this.cancelButton.TabIndex = 2;
         this.cancelButton.UseVisualStyleBackColor = true;
         this.cancelButton.Click += new System.EventHandler(this.CancelButtonClick);
         // 
         // progressBar
         // 
         this.progressBar.BackGradientEndColor = System.Drawing.Color.White;
         this.progressBar.BackGradientStartColor = System.Drawing.Color.LightGray;
         this.progressBar.BackgroundStyle = Syncfusion.Windows.Forms.Tools.ProgressBarBackgroundStyles.Gradient;
         this.progressBar.BackMultipleColors = new System.Drawing.Color[0];
         this.progressBar.BackSegments = false;
         this.progressBar.BackTubeEndColor = System.Drawing.Color.White;
         this.progressBar.BackTubeStartColor = System.Drawing.Color.LightGray;
         this.progressBar.Border3DStyle = System.Windows.Forms.Border3DStyle.Flat;
         this.progressBar.BorderColor = System.Drawing.Color.Brown;
         this.progressBar.CustomText = null;
         this.progressBar.CustomWaitingRender = false;
         this.progressBar.FontColor = System.Drawing.Color.LightSteelBlue;
         this.progressBar.ForegroundImage = null;
         this.progressBar.ForeSegments = false;
         this.progressBar.GradientEndColor = System.Drawing.Color.Lime;
         this.progressBar.GradientStartColor = System.Drawing.Color.White;
         this.progressBar.Location = new System.Drawing.Point(8, 57);
         this.progressBar.MultipleColors = new System.Drawing.Color[0];
         this.progressBar.Name = "progressBar";
         this.progressBar.ProgressFallbackStyle = Syncfusion.Windows.Forms.Tools.ProgressBarStyles.WaitingGradient;
         this.progressBar.ProgressStyle = Syncfusion.Windows.Forms.Tools.ProgressBarStyles.WaitingGradient;
         this.progressBar.SegmentWidth = 0;
         this.progressBar.Size = new System.Drawing.Size(236, 23);
         this.progressBar.TabIndex = 16;
         this.progressBar.TextVisible = false;
         this.progressBar.ThemesEnabled = false;
         this.progressBar.TubeEndColor = System.Drawing.Color.Black;
         this.progressBar.TubeStartColor = System.Drawing.Color.Red;
         this.progressBar.Value = 75;
         this.progressBar.WaitingGradientEnabled = true;
         this.progressBar.WaitingGradientInterval = 50;
         this.progressBar.WaitingGradientWidth = 20;
         // 
         // panel1
         // 
         this.panel1.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
         this.panel1.Controls.Add(this.progressBar);
         this.panel1.Controls.Add(this.taskLabel);
         this.panel1.Controls.Add(this.cancelButton);
         this.panel1.Dock = System.Windows.Forms.DockStyle.Fill;
         this.panel1.Location = new System.Drawing.Point(0, 0);
         this.panel1.Name = "panel1";
         this.panel1.Size = new System.Drawing.Size(336, 87);
         this.panel1.TabIndex = 18;
         // 
         // AsynchronousWaitDialogForm
         // 
         this.CancelButton = this.cancelButton;
         this.ClientSize = new System.Drawing.Size(336, 87);
         this.Controls.Add(this.panel1);
         this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None;
         this.MaximizeBox = false;
         this.MinimizeBox = false;
         this.Name = "AsynchronousWaitDialogForm";
         this.ShowIcon = false;
         this.ShowInTaskbar = false;
         this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
         this.Text = "AsynchronousWaitDialog";
         this.TopMost = true;
         ((System.ComponentModel.ISupportInitialize)(this.progressBar)).EndInit();
         this.panel1.ResumeLayout(false);
         this.ResumeLayout(false);

		}
      internal System.Windows.Forms.Button cancelButton;
		internal System.Windows.Forms.Label taskLabel;
      internal Syncfusion.Windows.Forms.Tools.ProgressBarAdv progressBar;
	}

   /// <summary>
   /// This is a basic interface to a "progress bar" type of
   /// control.
   /// </summary>
   public interface IProgressMonitor
   {
      /// <summary>
      /// Begins a new task with the specified name and total amount of work.
      /// </summary>
      /// <param name="name">Name of the task. Use null to display a default message</param>
      /// <param name="totalWork">Total amount of work in work units. Use 0 for unknown amount of work.</param>
      /// <param name="allowCancel">Specifies whether the task can be cancelled.</param>
      void BeginTask(string name, int totalWork, bool allowCancel);

      /// <summary>
      /// Gets/Sets the amount of work already done
      /// </summary>
      int WorkDone
      {
         get;
         set;
      }

      /// <summary>
      /// Marks the current task as Done.
      /// </summary>
      void Done();

      /// <summary>
      /// Gets/Sets the current task name.
      /// </summary>
      string TaskName
      {
         get;
         set;
      }

      /// <summary>
      /// Gets/sets if the task current shows a modal dialog. Set this property to true to make progress dialogs windows
      /// temporarily invisible while your modal dialog is showing.
      /// </summary>
      bool ShowingDialog
      {
         get;
         set;
      }

      /// <summary>
      /// Gets whether the user has cancelled the operation.
      /// </summary>
      bool IsCancelled
      {
         get;
      }
   }


}