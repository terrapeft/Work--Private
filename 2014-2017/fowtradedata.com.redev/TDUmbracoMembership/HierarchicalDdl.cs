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
    
    public partial class HierarchicalDdl
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public HierarchicalDdl()
        {
            this.Children = new HashSet<HierarchicalDdl>();
        }
    
        public int HierarchyId { get; set; }
        public Nullable<int> ParentId { get; set; }
        public int OptionId { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<HierarchicalDdl> Children { get; set; }
        public virtual HierarchicalDdl Parent { get; set; }
        public virtual DdlOption DdlOption { get; set; }
    }
}