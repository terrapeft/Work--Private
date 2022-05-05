#region Copyright (C) 1994-2009, Johnson & Johnson PRD, LLC.

//---------------------------------------------------------------------------*
//
//    WizardTitle.cs: Common header for any 3DX wizards
//
//---
//
//    Copyright (C) 1994-2009, Johnson & Johnson PRD, LLC.
//    All Rights Reserved.
//
//    Pavel Tupitsin, 08/2009
//
//---------------------------------------------------------------------------*/

#endregion


using System;
using System.Windows.Forms;


namespace Jnj.ThirdDimension.Explorer.BarcodeSeries
{
   /// <summary>
   /// Common header for any 3DX wizards
   /// </summary>
   public partial class WizardTitle : UserControl
   {
      #region Constructors

      /// <summary>
      /// Initializes a new instance of the <see cref="WizardTitle"/> class.
      /// </summary>
      public WizardTitle()
      {
         InitializeComponent();
      }

      #endregion


      #region Public properties and indexers

      /// <summary>
      /// Gets or sets the primary text (left part, bold)
      /// </summary>
      /// <value>The primary text</value>
      public string PrimaryText
      {
         get { return primaryTextLabel.Text; }
         set { primaryTextLabel.Text = value; }
      }

      /// <summary>
      /// Gets or sets the secondary text (right part)
      /// </summary>
      /// <value>The secondary text</value>
      public string SecondaryText
      {
         get { return secondaryTextLabel.Text; }
         set { secondaryTextLabel.Text = value; }
      }

      #endregion


      #region Private and protected methods

      /// <summary>
      /// Aligns the labels.
      /// </summary>
      private void AlignLabels()
      {
         secondaryTextLabel.Left = primaryTextLabel.Right;
      }

      #endregion


      #region Event handlers

      /// <summary>
      /// Handles the SizeChanged event of the primaryTextLabel control.
      /// </summary>
      /// <param name="sender">The source of the event.</param>
      /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
      private void primaryTextLabel_SizeChanged(object sender, EventArgs e)
      {
         AlignLabels();
      }


      /// <summary>
      /// Handles the Load event of the WizardTitle control.
      /// </summary>
      /// <param name="sender">The source of the event.</param>
      /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
      private void WizardTitle_Load(object sender, EventArgs e)
      {
         AlignLabels();
      }

      #endregion
   }
}