#region Copyright (C) 1994-2009, Johnson & Johnson PRD, LLC.
//---------------------------------------------------------------------------*
//
//    MessagesHelper.cs: Wrapper for user messages dialogs.
//
//---
//
//    Copyright (C) 1994-2008, Johnson & Johnson PRD, LLC.
//    All Rights Reserved.
//
//    Vitaly Chupaev, 11/2008
//
//---------------------------------------------------------------------------*/
#endregion

using System.Windows.Forms;
using System;
using Jnj.ThirdDimension.Util.UsageLog;
using Jnj.ThirdDimension.Base;

namespace Jnj.ThirdDimension.Utils.BarcodeSeries
{
   /// <summary>
   /// Wrapper for user messages dialogs.
   /// </summary>
   public class MessagesHelper
   {
      /// <summary>
      /// Shows information.
      /// </summary>
      /// <param name="text"></param>
      /// <param name="caption"></param>
      /// <returns></returns>
      public static DialogResult ShowInformation(string text, string caption)
      {
         CloseProgressDialog();
         return MessageBox.Show(text, caption, MessageBoxButtons.OK, MessageBoxIcon.Information);
      }

      /// <summary>
      /// Shows warning.
      /// </summary>
      /// <param name="text"></param>
      /// <param name="caption"></param>
      /// <returns></returns>
      public static DialogResult ShowWarning(string text, string caption)
      {
         CloseProgressDialog();
         return MessageBox.Show(text, caption, MessageBoxButtons.OK, MessageBoxIcon.Warning);
      }

      /// <summary>
      /// Shows error.
      /// </summary>
      /// <param name="text"></param>
      /// <param name="caption"></param>
      /// <returns></returns>
      public static DialogResult ShowError(string text, string caption)
      {
         CloseProgressDialog();
         return MessageBox.Show(text, caption, MessageBoxButtons.OK, MessageBoxIcon.Error);
      }

      /// <summary>
      /// Reports error via Reporter.
      /// </summary>
      /// <param name="message"></param>
      public static void ReportError(string message)
      {
         CloseProgressDialog();
         Reporter.ReportError(message);
      }

      /// <summary>
      /// Reports error via Reporter.
      /// </summary>
      /// <param name="ex"></param>
      public static void ReportError(Exception ex)
      {
         CloseProgressDialog();
         ReportError(ex, false);
      }

      /// <summary>
      /// Reports error via Reporter.
      /// </summary>
      /// <param name="ex"></param>
      /// <param name="showMessageBox"></param>
      public static void ReportError(Exception ex, bool showMessageBox)
      {
         CloseProgressDialog();
         Reporter.ReportError(ex, showMessageBox);
      }

      /// <summary>
      /// Reports error via Reporter.
      /// </summary>
      /// <param name="ex"></param>
      /// <param name="showMessageBox"></param>
      public static void ReportErrorKindly(Exception ex, bool showMessageBox)
      {
         CloseProgressDialog();
         Reporter.ReportError(ex, false);
         if (showMessageBox)
         {
            MessagesHelper.ShowError(ex.Message, "Error");
         }
      }

      /// <summary>
      /// Shows question.
      /// </summary>
      /// <param name="text"></param>
      /// <param name="caption"></param>
      /// <param name="buttons"></param>
      /// <returns></returns>
      public static DialogResult ShowQuestion(string text, string caption, MessageBoxButtons buttons)
      {
         CloseProgressDialog();
         return MessageBox.Show(text, caption, buttons, MessageBoxIcon.Question);
      }

      /// <summary>
      /// Shows question.
      /// </summary>
      /// <param name="text"></param>
      /// <param name="caption"></param>
      /// <param name="buttons"></param>
      /// <param name="defaultButton"></param>
      /// <returns></returns>
      public static DialogResult ShowQuestion(string text, string caption, MessageBoxButtons buttons, MessageBoxDefaultButton defaultButton)
      {
         CloseProgressDialog();
         return MessageBox.Show(text, caption, buttons, MessageBoxIcon.Question, defaultButton);
      }

      /// <summary>
      /// Shows warning with possibilty to choose an action.
      /// </summary>
      /// <param name="text"></param>
      /// <param name="caption"></param>
      /// <param name="buttons"></param>
      /// <returns></returns>
      public static DialogResult ShowWarningQuestion(string text, string caption, MessageBoxButtons buttons)
      {
         CloseProgressDialog();
         return MessageBox.Show(text, caption, buttons, MessageBoxIcon.Warning);
      }
      
      /// <summary>
      /// Shows warning with possibilty to choose an action.
      /// </summary>
      /// <param name="text"></param>
      /// <param name="caption"></param>
      /// <param name="buttons"></param>
      /// <returns></returns>
      public static DialogResult ShowWarningQuestion(string text, string caption, MessageBoxButtons buttons, MessageBoxDefaultButton defaultButton)
      {
         CloseProgressDialog();
         return MessageBox.Show(text, caption, buttons, MessageBoxIcon.Warning, defaultButton);
      }

      /// <summary>
      /// Shows warning
      /// </summary>
      /// <param name="text"></param>
      /// <param name="caption"></param>
      /// <param name="args"></param>
      /// <returns></returns>
      public static DialogResult ShowWarningFormat(string text, string caption, params object[] args)
      {
         CloseProgressDialog();
         string txt = string.Format(text, args);
         return MessageBox.Show(txt, caption, MessageBoxButtons.OK, MessageBoxIcon.Warning);
      }

      /// <summary>
      /// Shows the warning with details.
      /// </summary>
      /// <param name="text">The text.</param>
      /// <param name="caption">The caption.</param>
      /// <param name="detailText">The detail text.</param>
      public static void ShowWarningWithDetails(string text, string caption, string detailText)
      {
         CloseProgressDialog();
         ConfirmationDialog.ShowWithDetails(text, caption, MessageBoxButtons.OK, MessageBoxIcon.Warning, detailText);
      }


      #region Internal methods
      /// <summary>
      /// Closes the current progress dialog.
      /// </summary>
      internal static void CloseProgressDialog()
      {
         if (AsynchronousWaitDialog.CurrentWaitDialog != null)
         {
            AsynchronousWaitDialog.CurrentWaitDialog.Dispose();
         }
      }
      #endregion
   }
}
