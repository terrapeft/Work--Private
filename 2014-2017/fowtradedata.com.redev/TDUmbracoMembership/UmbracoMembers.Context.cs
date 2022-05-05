﻿//------------------------------------------------------------------------------
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
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    using System.Data.Entity.Core.Objects;
    using System.Linq;
    
    public partial class UmbracoMembersEntities : DbContext
    {
        public UmbracoMembersEntities()
            : base("name=UmbracoMembersEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<Company> Companies { get; set; }
        public virtual DbSet<Member> Members { get; set; }
        public virtual DbSet<History> Histories { get; set; }
        public virtual DbSet<MemberView> MemberViews { get; set; }
        public virtual DbSet<SupportRequestsHistory> SupportRequestsHistories { get; set; }
        public virtual DbSet<vwHistory> vwHistories { get; set; }
        public virtual DbSet<HierarchicalDdl> HierarchicalDdls { get; set; }
        public virtual DbSet<Ddl> Ddls { get; set; }
        public virtual DbSet<DdlOption> DdlOptions { get; set; }
        public virtual DbSet<vwHierarchy> vwHierarchies { get; set; }
        public virtual DbSet<vwDropDownListOption> vwDropDownListOptions { get; set; }
        public virtual DbSet<ResourceType> ResourceTypes { get; set; }
        public virtual DbSet<SiteConfig> SiteConfigs { get; set; }
        public virtual DbSet<SalesforceFieldsMapping> SalesforceFieldsMappings { get; set; }
    
        public virtual int spOpenPasswordsKey()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("spOpenPasswordsKey");
        }
    
        public virtual int spMemberDelete(Nullable<int> memberId)
        {
            var memberIdParameter = memberId.HasValue ?
                new ObjectParameter("memberId", memberId) :
                new ObjectParameter("memberId", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("spMemberDelete", memberIdParameter);
        }
    
        public virtual int spMemberInsert(Nullable<int> companyId, string firstName, string lastName, string userName, string password)
        {
            var companyIdParameter = companyId.HasValue ?
                new ObjectParameter("companyId", companyId) :
                new ObjectParameter("companyId", typeof(int));
    
            var firstNameParameter = firstName != null ?
                new ObjectParameter("firstName", firstName) :
                new ObjectParameter("firstName", typeof(string));
    
            var lastNameParameter = lastName != null ?
                new ObjectParameter("lastName", lastName) :
                new ObjectParameter("lastName", typeof(string));
    
            var userNameParameter = userName != null ?
                new ObjectParameter("userName", userName) :
                new ObjectParameter("userName", typeof(string));
    
            var passwordParameter = password != null ?
                new ObjectParameter("password", password) :
                new ObjectParameter("password", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("spMemberInsert", companyIdParameter, firstNameParameter, lastNameParameter, userNameParameter, passwordParameter);
        }
    
        public virtual int spMemberUpdate(Nullable<int> memberId, Nullable<int> companyId, string firstName, string lastName, string userName, string password)
        {
            var memberIdParameter = memberId.HasValue ?
                new ObjectParameter("memberId", memberId) :
                new ObjectParameter("memberId", typeof(int));
    
            var companyIdParameter = companyId.HasValue ?
                new ObjectParameter("companyId", companyId) :
                new ObjectParameter("companyId", typeof(int));
    
            var firstNameParameter = firstName != null ?
                new ObjectParameter("firstName", firstName) :
                new ObjectParameter("firstName", typeof(string));
    
            var lastNameParameter = lastName != null ?
                new ObjectParameter("lastName", lastName) :
                new ObjectParameter("lastName", typeof(string));
    
            var userNameParameter = userName != null ?
                new ObjectParameter("userName", userName) :
                new ObjectParameter("userName", typeof(string));
    
            var passwordParameter = password != null ?
                new ObjectParameter("password", password) :
                new ObjectParameter("password", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("spMemberUpdate", memberIdParameter, companyIdParameter, firstNameParameter, lastNameParameter, userNameParameter, passwordParameter);
        }
    }
}
