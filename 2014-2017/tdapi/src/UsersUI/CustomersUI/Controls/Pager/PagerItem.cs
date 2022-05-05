namespace CustomersUI.Controls.Pager
{

    /// <summary>
    /// Page class containing the information used to create a paging control
    /// </summary>
    public class PagerItem
    {
        /// <summary>
        /// Gets or sets the title.
        /// </summary>
        /// <value>The title.</value>
        public string Text { get; set; }

        /// <summary>
        /// Gets or sets the page number.
        /// </summary>
        /// <value>The page num.</value>
        public int PageNum { get; set; }

        /// <summary>
        /// Gets or sets the pager button class.
        /// </summary>
        /// <value>
        /// The class.
        /// </value>
        public string Class { get; set; }
    }
}