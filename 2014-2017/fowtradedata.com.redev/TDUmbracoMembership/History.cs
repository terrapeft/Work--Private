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
    
    public partial class History
    {
        public int HistoryId { get; set; }
        public Nullable<int> MemberId { get; set; }
        public string Username { get; set; }
        public System.DateTime TimestampUtc { get; set; }
        public string Action { get; set; }
        public string Message { get; set; }
    }
}
