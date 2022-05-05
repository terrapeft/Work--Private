using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http.Formatting;
using System.Web;
using System.Web.Security;
using umbraco.BusinessLogic.Actions;
using Umbraco.Core;
using Umbraco.Core.Security;
using Umbraco.Web.Models.Trees;
using Umbraco.Web.Mvc;
using Umbraco.Web.Trees;

namespace Umbraco.Web.Trees
{
    [PluginController("TDMembers")]
    [Umbraco.Web.Trees.Tree("TDMembers", "TDMembersTree", "Salesforce settings", iconClosed: "icon-user-glasses")]
    public class TDMembersTreeController : TreeController
    {
        public TDMembersTreeController()
        {
            _provider = MembershipProviderExtensions.GetMembersMembershipProvider();
            _isUmbracoProvider = _provider.IsUmbracoMembershipProvider();
        }

        private readonly MembershipProvider _provider;
        private readonly bool _isUmbracoProvider;


        protected override TreeNodeCollection GetTreeNodes(string id, FormDataCollection queryStrings)
        {
            var nodes = new TreeNodeCollection();

            nodes.Add(CreateTreeNode("td-members", id, queryStrings, "Members", "icon-users", false,
                queryStrings.GetValue<string>("application") + TreeAlias.EnsureStartsWith('/') + "/edit/" + "TDMembers"));

            nodes.Add(CreateTreeNode("td-members", id, queryStrings, "Companies", "icon-company", false,
                queryStrings.GetValue<string>("application") + TreeAlias.EnsureStartsWith('/') + "/edit/" + "TDCompanies"));

            nodes.Add(CreateTreeNode("td-members", id, queryStrings, "SalesForce Options", "icon-tools", false,
                queryStrings.GetValue<string>("application") + TreeAlias.EnsureStartsWith('/') + "/edit/" + "TDSalesForce"));

            nodes.Add(CreateTreeNode("td-members", id, queryStrings, "Support Requests", "icon-operator", false,
                queryStrings.GetValue<string>("application") + TreeAlias.EnsureStartsWith('/') + "/edit/" + "TDSupportRequests"));

            nodes.Add(CreateTreeNode("td-members", id, queryStrings, "Configuration & Resources", "icon-settings", false,
                queryStrings.GetValue<string>("application") + TreeAlias.EnsureStartsWith('/') + "/edit/" + "TDSiteConfig"));

            nodes.Add(CreateTreeNode("td-members", id, queryStrings, "Errors Log", "icon-application-error", false,
                queryStrings.GetValue<string>("application") + TreeAlias.EnsureStartsWith('/') + "/edit/" + "TDErrors"));

            return nodes;
        }

        protected override MenuItemCollection GetMenuForNode(string id, FormDataCollection queryStrings)
        {
            /*
                        var menu = new MenuItemCollection();
                        menu.DefaultMenuAlias = ActionNew.Instance.Alias;
                        menu.Items.Add<ActionNew>("Create");
                        return menu;
            */
            // Do not need sub menu? Return null.
            return null;
        }
    }
}