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
    
    public partial class DdlOption
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public DdlOption()
        {
            this.Children = new HashSet<HierarchicalDdl>();
        }
    
        public int OptionId { get; set; }
        public int DropDownListId { get; set; }
        public string Name { get; set; }
        public string Value { get; set; }
        public Nullable<bool> IsDefault { get; set; }
        public Nullable<int> OrderBy { get; set; }
    
        public virtual Ddl Parent { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<HierarchicalDdl> Children { get; set; }
    }
}
