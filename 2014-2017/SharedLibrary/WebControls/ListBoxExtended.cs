using System.ComponentModel;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SharedLibrary.WebControls
{

    /// <summary>
    /// ListBox allows to keep attributes in ViewState.
    /// This is not implemented in the standard ListBox and all attributes disappear after postback.
    /// </summary>
    [DefaultProperty("Text")]
    [ToolboxData("<{0}:ListBoxExtended1 runat=server></{0}:ListBoxExtended1>")]
    public class ListBoxExtended : ListBox
    {
        [Bindable(true)]
        [Category("Appearance")]
        [DefaultValue("")]
        [Localizable(true)]

        protected override object SaveViewState()
        {
            // create object array for Item count + 1
            var allStates = new object[this.Items.Count + 1];

            // the +1 is to hold the base info
            var baseState = base.SaveViewState();
            allStates[0] = baseState;

            var i = 1;
            // now loop through and save each Style attribute for the List
            foreach (ListItem li in this.Items)
            {
                var j = 0;
                var attributes = new string[li.Attributes.Count][];
                foreach (string attribute in li.Attributes.Keys)
                {
                    attributes[j++] = new string[] { attribute, li.Attributes[attribute] };
                }

                allStates[i++] = attributes;
            }

            return allStates;
        }

        protected override void LoadViewState(object savedState)
        {
            if (savedState != null)
            {
                var myState = (object[])savedState;

                // restore base first
                if (myState[0] != null)
                    base.LoadViewState(myState[0]);

                var i = 1;
                foreach (ListItem li in this.Items)
                {
                    // loop through and restore each style attribute
                    foreach (var attribute in (string[][])myState[i++])
                    {
                        li.Attributes[attribute[0]] = attribute[1];
                    }
                }
            }
        }
    }
}