using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Windows.Forms;
using Syncfusion.Windows.Forms.Tools;

namespace Jnj.ThirdDimension.Utils.BarcodeSeries
{
   /// <summary>
   /// Shows an wait dialog on a separate thread if the action takes longer than 500ms.
   /// Usage:
   /// using (AsynchronousWaitDialog.ShowWaitDialog("title")) {
   ///   long_running_action();
   /// }
   /// or:
   /// using (IProgressMonitor monitor = AsynchronousWaitDialog.ShowWaitDialog("title")) {
   ///   long_running_action(monitor);
   /// }
   /// </summary>
   public sealed class AsynchronousWaitDialog : IProgressMonitor, IDisposable
   {
      /// <summary>
      /// Delay until the wait dialog becomes visible, in ms.
      /// </summary>
      public const int ShowWaitDialogDelay = 500;

      readonly object lockObject = new object();
      bool disposed;
      bool locked = false;   // indicates if execution is currently in a lock section
      private Thread currentThread;   // working thread
      volatile int totalWork;
      volatile string titleName;
      volatile string taskName;
      volatile int workDone;
      volatile bool cancelled;
      volatile bool allowCancel;

      AsynchronousWaitDialogForm dlg;

      [ThreadStatic]
      private static AsynchronousWaitDialog dialog;

      [ThreadStatic]
      static int disposeCounter = 0;

      /// <summary>
      /// Shows a wait dialog.
      /// </summary>
      /// <param name="titleName">Title of the wait dialog</param>
      /// <returns>WaitHandle object - you can use it to access the wait dialog's properties.
      /// To close the wait dialog, call Dispose() on the WaitHandle</returns>
      public static AsynchronousWaitDialog ShowWaitDialog(string titleName)
      {
         return ShowWaitDialog(titleName, true);
      }

      public static AsynchronousWaitDialog ShowWaitDialog(string titleName, bool allowCancel)
      {
         return ShowWaitDialog(titleName, "Please wait...", allowCancel);
      }

      public static AsynchronousWaitDialog ShowWaitDialog(string titleName, string taskName, bool allowCancel)
      {
         if (titleName == null)
            throw new ArgumentNullException("titleName");

         Application.DoEvents();

         if (dialog == null)
         {
            AsynchronousWaitDialog h = new AsynchronousWaitDialog(titleName, allowCancel);
            dialog = h;
            h.Start();
            return h;
         }
         else
         {
            disposeCounter++;
            dialog.BeginTask(taskName, 0, allowCancel);
            return dialog;
         }
      }

      public static AsynchronousWaitDialog CurrentWaitDialog
      {
         get { return dialog; }
      }

      private AsynchronousWaitDialog(string titleName, bool allowCancel)
      {
         this.titleName = titleName;
         this.allowCancel = allowCancel;
         //showingDialog = false;
         Done(); // set default values for titleName
      }

      #region Start waiting thread

      /// <summary>
      /// Start waiting thread
      /// </summary>
      internal void Start()
      {
         currentThread = new Thread(Run);
         currentThread.Name = "AsynchronousWaitDialog thread";
         currentThread.Start();

         Thread.Sleep(0); // allow new thread to start
      }

      [STAThread]
      void Run()
      {
         Thread.Sleep(ShowWaitDialogDelay);

         if (disposed)
            return;

         lock (lockObject)
         {
            locked = true;

            dlg = new AsynchronousWaitDialogForm();
            dlg.Text = titleName;
            dlg.cancelButton.Click += delegate { cancelled = true; };
            dlg.CreateControl();
            IntPtr h = dlg.Handle; // force handle creation
            UpdateTask();

            showingDialog = true;
            locked = false;
         }

         Application.Run(dlg);
      }

      #endregion

      /// <summary>
      /// Closes the wait dialog.
      /// </summary>
      public void Dispose()
      {
         if (disposeCounter > 0)
         {
            disposeCounter--;
            return;
         }

         if (locked)
         {
            locked = false;

            // prevents from occasional deadlocks
            currentThread.Abort();
         }

         lock (lockObject)
         {
            if (disposed) return;
            disposed = true;
            dialog = null;
            if (dlg != null)
            {
               dlg.BeginInvoke(new MethodInvoker(DisposeInvoked));
            }
         }
      }

      void DisposeInvoked()
      {
         dlg.Dispose();
         //dialog = null;
         Application.ExitThread();
      }

      public int WorkDone
      {
         get
         {
            return workDone;
         }
         set
         {
            if (workDone != value)
            {
               lock (lockObject)
               {
                  workDone = value;
                  if (dlg != null && disposed == false)
                  {
                     dlg.BeginInvoke(new MethodInvoker(UpdateProgress));
                  }
               }
            }
         }
      }

      public string TaskName
      {
         get
         {
            lock (lockObject)
            {
               return taskName;
            }
         }
         set
         {
            if (taskName != value)
            {
               lock (lockObject)
               {
                  taskName = value;
                  if (dlg != null && disposed == false)
                  {
                     dlg.BeginInvoke(new MethodInvoker(UpdateTask));
                  }
               }
            }
         }
      }

      public string TitleName
      {
         get
         {
            lock (lockObject)
            {
               return titleName;
            }
         }
         set
         {
            if (titleName != value)
            {
               lock (lockObject)
               {
                  titleName = value;
                  if (dlg != null && disposed == false)
                  {
                     dlg.BeginInvoke(new MethodInvoker(UpdateTask));
                  }
               }
            }
         }
      }

      /// <summary>
      /// Begins a new task with the specified name and total amount of work.
      /// </summary>
      /// <param name="name">Name of the task. Use null to display "please wait..." message</param>
      /// <param name="totalWork">Total amount of work in work units. Use 0 for unknown amount of work.</param>
      public void BeginTask(string name, int totalWork, bool allowCancel)
      {
         if (name == null)
            name = "Please wait...";
         if (totalWork < 0)
            totalWork = 0;

         lock (lockObject)
         {
            this.allowCancel = allowCancel;
            this.totalWork = totalWork;
            this.taskName = name;
            if (dlg != null && disposed == false)
            {
               dlg.BeginInvoke(new MethodInvoker(UpdateTask));
            }
         }
      }
      /// <summary>
      /// Resets the task to a generic "please wait" with marquee progress bar.
      /// </summary>
      public void Done()
      {
         workDone = 0;
         BeginTask(null, 0, allowCancel);
      }

      void UpdateTask()
      {
         int totalWork = this.totalWork;

         dlg.taskLabel.Text = taskName;
         if (allowCancel)
         {
            dlg.cancelButton.Enabled = true;
            dlg.cancelButton.Visible = true;
            dlg.UpdateProgressBarLocation();
         }
         else
         {
            dlg.cancelButton.Enabled = false;
            dlg.cancelButton.Visible = false;
            dlg.UpdateProgressBarLocation();
         }

         if (totalWork > 0)
         {
            if (dlg.progressBar.Value > totalWork)
            {
               dlg.progressBar.Value = 0;
            }
            dlg.progressBar.Maximum = totalWork + 1;
            dlg.progressBar.ProgressStyle = ProgressBarStyles.System;
         }
         else
         {
            dlg.progressBar.ProgressStyle = ProgressBarStyles.WaitingGradient;
         }
         UpdateProgress();
      }

      void UpdateProgress()
      {
         int workDone = this.workDone;
         if (workDone < 0) workDone = 0;
         if (workDone > dlg.progressBar.Maximum)
            workDone = dlg.progressBar.Maximum;
         dlg.progressBar.Value = workDone;
      }

      bool showingDialog;

      public bool ShowingDialog
      {
         get { return showingDialog; }
         set
         {
            if (showingDialog != value)
            {
               showingDialog = value;
               lock (lockObject)
               {
                  if (dlg != null && disposed == false)
                  {
                     if (!value)
                     {
                        dlg.BeginInvoke(new MethodInvoker(dlg.Hide));
                     }
                     else
                     {
                        dlg.BeginInvoke(new MethodInvoker(delegate
                        {
                           Thread.Sleep(100);
                           if (showingDialog)
                           {
                              dlg.ShowDialog();
                           }
                        }));
                     }
                  }
               }
            }
         }
      }

      public bool IsCancelled
      {
         get
         {
            return cancelled;
         }
      }
   }
}
