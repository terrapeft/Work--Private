//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace TDUmbracoMembership
{
    using System;
    using System.Collections.Generic;
    
    public partial class SiteConfig
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Value { get; set; }
        public string Description { get; set; }
        public int ResourceTypeId { get; set; }
    
        public virtual ResourceType ResourceType { get; set; }
    }
}
