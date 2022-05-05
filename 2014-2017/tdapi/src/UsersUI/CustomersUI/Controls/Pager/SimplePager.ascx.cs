using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CustomersUI.Controls.Pager
{
    public partial class SimplePager : UserControl
    {
        private int currentPage = 1;
        private int buttonsInLine = 5;

        #region Public properties

        public int NumberOfButtons
        {
            get { return buttonsInLine; }
            set { buttonsInLine = value; }
        }

        public int TotalPages
        {
            get
            {
                return Convert.ToInt32(totalPagesField.Value ?? "-1");
            }
            set
            {
                totalPagesField.Value = value.ToString();
            }
        }

        public int CurrentPage
        {
            get
            {
                return currentPage;
            }
            set
            {
                currentPage = value;
            }
        }

        #endregion


        #region Events declaration

        public event CommandEventHandler PageChanging;

        #endregion


        #region Event handlers

        /// <summary>
        /// Handles the ItemCommand event of the pagerRepeater control.
        /// </summary>
        /// <param name="source">The source of the event.</param>
        /// <param name="e">The <see cref="RepeaterCommandEventArgs"/> instance containing the event data.</param>
        protected void pagerRepeater_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            var src = (LinkButton)e.CommandSource;
            button_OnCommand(this, new CommandEventArgs(e.CommandName, src.CommandArgument));
        }

        /// <summary>
        /// Handles the OnCommand event of the button control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="CommandEventArgs"/> instance containing the event data.</param>
        /// <exception cref="System.NotImplementedException"></exception>
        protected void button_OnCommand(object sender, CommandEventArgs e)
        {
            var arg = Convert.ToInt32(e.CommandArgument);
            var cmd = e.CommandName;

            if (arg >= TotalPages)
            {
                arg = TotalPages - 1;
            }

            if (arg < 0)
            {
                arg = 0;
            }

            if (PageChanging != null)
            {
                PageChanging(this, new CommandEventArgs(cmd, arg));
            }
        }

        #endregion


        #region Overridden methods

        /// <summary>
        /// Binds a data source to the invoked server control and all its child controls.
        /// </summary>
        public override void DataBind()
        {
            if (TotalPages == 1)
            {
                this.Visible = false;
                return;
            }

            this.Visible = true;

            lastButton.CommandArgument = (TotalPages - 1).ToString();
            prevButton.CommandArgument = (CurrentPage - 1).ToString();
            nextButton.CommandArgument = (CurrentPage + 1).ToString();
            prevButton.Enabled = (currentPage != 0);
            firstButton.Enabled = (currentPage != 0);
            nextButton.Enabled = (currentPage != TotalPages - 1);
            lastButton.Enabled = (currentPage != TotalPages - 1);

            var list = new List<PagerItem>();
            var buttonsSet = (int)Math.Ceiling((decimal)(CurrentPage + 1) / buttonsInLine);
            var minValue = (buttonsSet == 0 ? buttonsSet : (buttonsSet - 1)) * buttonsInLine + 1;
            var maxValue = (buttonsSet == 0 ? (buttonsSet + 1) : buttonsSet) * buttonsInLine;

            if (CurrentPage >= buttonsInLine)
            {
                list.Add(new PagerItem { Class = "page", Text = "...", PageNum = minValue - buttonsInLine - 1 });
            }

            for (var k = minValue; k <= Math.Min(maxValue, TotalPages); k++)
            {
                list.Add(CurrentPage == k - 1
                    ? new PagerItem { Class = "page active", Text = k.ToString() }
                    : new PagerItem { Class = "page", Text = k.ToString(), PageNum = k - 1 });
            }

            if (maxValue < TotalPages)
            {
                list.Add(new PagerItem { Class = "page", Text = "...", PageNum = minValue + buttonsInLine - 1 });
            }

            pagerRepeater.DataSource = list;
            pagerRepeater.DataBind();
        }

        #endregion
    }
}