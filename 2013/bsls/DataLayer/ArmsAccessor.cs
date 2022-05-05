#region Copyright (C) 1994-2009, Johnson & Johnson PRD, LLC.
//---------------------------------------------------------------------------*
//
//    ArmsAccessor.cs: The entry point for BSLS, where authorization take place.
//                      Data layer also created here.
//
//---
//
//    Copyright (C) 1994-2009, Johnson & Johnson PRD, LLC.
//    All Rights Reserved.
//
//    Vitaly Chupaev, 06/2010
//
//---------------------------------------------------------------------------*/
#endregion

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Jnj.ThirdDimension.Lims.Core;
using Jnj.ThirdDimension.Arms.Model;
using System.Data.Objects;
using Jnj.ThirdDimension.Utils.BarcodeSeries;
using Jnj.ThirdDimension.Lims.Interface;
using System.Linq.Expressions;
using Jnj.ThirdDimension.Base;
using System.Reflection;
using System.Collections;

namespace Jnj.ThirdDimension.Data.BarcodeSeries
{
   public class ArmsAccessor
   {
      private static ArmsAccessor instance;
      private LimsAuthorizationService service;

      private ArmsAccessor ()
      {
         service = new LimsAuthorizationService();
      }

      public static ArmsAccessor Instance
      {
         get
         {
            if (instance == null)
            {
               instance = new ArmsAccessor();
            }
            return instance;
         }
      }

      public ILimsAuthorization Service
      {
         get { return service;}
      }

      /// <summary>
      /// Returns PersonID list for users found by specified parameters.
      /// </summary>
      /// <param name="firstNameLike"></param>
      /// <param name="lastNameLike"></param>
      /// <param name="userNameLike"></param>
      /// <param name="wwid"></param>
      /// <returns></returns>
      public List<decimal> GetPersonIds(string firstNameLike, string lastNameLike, string userNameLike, decimal? wwid)
      {
         using (service.Provider.OpenContext())
         {
            service.Provider.MergeOption = MergeOption.OverwriteChanges;
            Expression<Func<UserV, bool>> filter = GetExpressionFilter(firstNameLike, lastNameLike, userNameLike,
                                                                       wwid);

            var query = service.Provider.GetEntitySet<UserV>().Where(filter).Select(it => it.PersonId);
            return query.ToList();
         }
      }

      /// <summary>
      /// Returns application by application ID.
      /// </summary>
      /// <param name="appId"></param>
      /// <returns></returns>
      private Jnj.ThirdDimension.Arms.Model.Application GetApplication(decimal appId)
      {
         return service.GetApplication(appId);
      }

      /// <summary>
      /// Gets the connection string.
      /// </summary>
      /// <param name="app">The app.</param>
      /// <param name="user">The user.</param>
      /// <param name="pt">The pt.</param>
      /// <param name="system">The system.</param>
      /// <returns></returns>
      private string GetConnectionString(Application app, UserV user, ProviderType pt, string system)
      {
         return service.GetConnectionString(app, user, pt, system);
      }


      /// <summary>
      /// Returns person.
      /// </summary>
      /// <param name="username"></param>
      /// <param name="domain"></param>
      /// <returns></returns>
      private UserV GetPerson(string username, string domain)
      {
         return service.GetPerson(username, domain);
      }

      /// <summary>
      /// Gets default resource account name for the user application role  
      /// </summary>
      /// <param name="app">Application</param>
      /// <param name="user">User</param>
      /// <param name="system">Resource system name</param>
      /// <returns>
      /// DB Account name or throws an exception if user application role for the resource system was not found
      /// </returns>
      private string GetUserAppRoleResource(Application app, UserV user, string system)
      {
         if (app == null) throw new ArgumentNullException("app");
         if (user == null) throw new ArgumentNullException("user");

         decimal personId = user.PersonId;
         decimal appId = app.Id;

         using (service.Provider.OpenContext())
         {
            service.Provider.MergeOption = MergeOption.NoTracking;
            var query = from it in service.Provider.GetEntitySet<UserAppRoleResourceV>()
                        where it.PersonId == personId &&
                              it.ResourceSystemName == system &&
                              it.ApplicationId == appId
                        select it;
            var list = query.ToList();
            if (list.Count > 0)
            {
               return list.First().AccountName;
            }
         }
         return string.Empty;
      }

      /// <summary>
      /// Obtains person information using WWID.
      /// </summary>
      /// <param name="wwid">The user's WWID.</param>
      /// <returns>A read only person object.</returns>
      public List<ResourceSystem> GetResources()
      {
         using (service.Provider.OpenContext())
         {
            service.Provider.MergeOption = MergeOption.OverwriteChanges;

            var query = from res in service.Provider.GetEntitySet<ResourceSystem>()
                        select res;

            var list = query.ToList();
            list.ForEach(x => service.Provider.LoadProperty(x, r => r.ResourceSystemAccess));
            list.ForEach(x => service.Provider.LoadProperty(x, r => r.ResourceSystemType));
            return list;
         }
      }

      /// <summary>
      /// Gets list of sites.
      /// </summary>
      /// <returns>A read only person object.</returns>
      public List<OrgSite> GetSites()
      {
         using (service.Provider.OpenContext())
         {
            service.Provider.MergeOption = MergeOption.OverwriteChanges;
            return service.Provider.GetEntitySet<OrgSite>().ToList();
         }
      }

      /// <summary>
      /// Gets list of sites.
      /// </summary>
      /// <returns>A read only person object.</returns>
      public string GetSite(string userName, string domain)
      {
         if (userName.IsEmpty())
         {
            throw new Exception("GetSites(userName, domain): User name cannot be empty.");
         }

         UserV user = GetPerson(userName, domain);
         decimal pid = user.PersonId;
         
         Expression<Func<PersonOrgSite, bool>> filter = null;
         filter = c => c.PersonId.Equals(pid);

         decimal siteId = decimal.MinValue;
         using (service.Provider.OpenContext())
         {
            service.Provider.MergeOption = MergeOption.OverwriteChanges;
            siteId = service.Provider.GetEntitySet<PersonOrgSite>().Where(filter).First().Id;
         }
         
         if (siteId > decimal.MinValue)
         {
            foreach (OrgSite s in GetSites())
            {
               if (s.Id == siteId)
                  return s.Name;
            }
         }
         return string.Empty;
      }

      #region Private methods

      /// <summary>
      /// Creates filter for LINQ according to user input.
      /// </summary>
      /// <param name="firstNameLike"></param>
      /// <param name="lastNameLike"></param>
      /// <param name="userNameLike"></param>
      /// <param name="wwid"></param>
      /// <returns></returns>
      private Expression<Func<UserV, bool>> GetExpressionFilter(string firstNameLike, string lastNameLike, string userNameLike, decimal? wwid)
      {
         Expression<Func<UserV, bool>> filter = null;

         if (!firstNameLike.IsEmpty())
         {
            AddCondition(c => c.FirstName.ToLower().StartsWith(firstNameLike.ToLower()), ref filter);
         }
         if (!lastNameLike.IsEmpty())
         {
            AddCondition(c => c.LastName.ToLower().StartsWith(lastNameLike.ToLower()), ref filter);
         }
         if (!userNameLike.IsEmpty())
         {
            AddCondition(c => c.LastName.ToLower().StartsWith(userNameLike.ToLower()), ref filter);
         }
         if (wwid != null)
         {
            AddCondition(c => c.Wwid == wwid, ref filter);
         }

         return filter;
      }

      /// <summary>
      /// Adds a new condition to the filter with null check.
      /// </summary>
      /// <param name="condition"></param>
      /// <param name="filter"></param>
      private void AddCondition(Expression<Func<UserV, bool>> condition, ref Expression<Func<UserV, bool>> filter)
      {
         filter = (filter == null) ? condition : filter.And(condition);
      }

      #endregion

      /// <summary>
      /// Authorizes the specified username.
      /// </summary>
      /// <param name="username">The username.</param>
      /// <param name="domain">The domain.</param>
      /// <param name="password">The password.</param>
      /// <param name="encrypted"></param>
      /// <param name="appId">The app id.</param>
      /// <param name="user">The user.</param>
      /// <param name="app">The app.</param>
      public void Authenticate(string username, string domain, string password, bool encrypted)
      {
         // exception is thrown when authentication did not pass
         Service.Authenticate(username, domain, password, encrypted);
      }

      /// <summary>
      /// Authorizes the specified username.
      /// </summary>
      /// <param name="wwid">The wwid.</param>
      /// <param name="password">The password.</param>
      /// <param name="encrypted"></param>
      public void Authenticate(decimal wwid, string password, bool encrypted)
      {
         // exception is thrown when authentication did not pass
         Service.Authenticate(wwid, password, encrypted);
      }

      /// <summary>
      /// Authorizes the specified wwid.
      /// </summary>
      /// <param name="wwid">The wwid.</param>
      /// <param name="appId">The app id.</param>
      /// <param name="resourceSystem">The resource system.</param>
      /// <param name="rights">The user rights.</param>
      /// <returns></returns>
      public SeriesDataLayer Authorize(decimal wwid, decimal appId, string resourceSystem, ulong rights)
      {
         UserV user = Service.GetPerson(wwid);
         Jnj.ThirdDimension.Arms.Model.Application app = GetApplication(appId);
         return Authorize(user, app, resourceSystem, rights);
      }

      /// <summary>
      /// Authorizes the specified wwid.
      /// </summary>
      /// <param name="wwid">The wwid.</param>
      /// <param name="appId">The app id.</param>
      /// <param name="resourceSystem">The resource system.</param>
      /// <param name="rights">The user rights.</param>
      /// <returns></returns>
      public SeriesDataLayer Authorize(decimal wwid, decimal appId, string resourceSystem, ulong rights, out UserV user, out Jnj.ThirdDimension.Arms.Model.Application app)
      {
         user = Service.GetPerson(wwid);
         app = GetApplication(appId);
         return Authorize(user, app, resourceSystem, rights);
      }

      /// <summary>
      /// Authorizes the specified username.
      /// </summary>
      /// <param name="username">The username.</param>
      /// <param name="domain">The domain.</param>
      /// <param name="appId">The app id.</param>
      /// <param name="resourceSystem">The resource system.</param>
      /// <param name="rights">The required rights.</param>
      /// <returns></returns>
      public SeriesDataLayer Authorize(string username, string domain, decimal appId, string resourceSystem, ulong rights)
      {
         UserV user = Service.GetPerson(username, domain);
         Jnj.ThirdDimension.Arms.Model.Application app = GetApplication(appId);
         return Authorize(user, app, resourceSystem, rights);
      }

      /// <summary>
      /// Authorizes the specified username.
      /// </summary>
      /// <param name="username">The username.</param>
      /// <param name="domain">The domain.</param>
      /// <param name="appId">The app id.</param>
      /// <param name="resourceSystem">The resource system.</param>
      /// <param name="rights">The required rights.</param>
      /// <returns></returns>
      public SeriesDataLayer Authorize(string username, string domain, decimal appId, string resourceSystem, ulong rights, out UserV user, out Jnj.ThirdDimension.Arms.Model.Application app)
      {
         user = Service.GetPerson(username, domain);
         app = GetApplication(appId);
         return Authorize(user, app, resourceSystem, rights);
      }

      /// <summary>
      /// Authorizes the user and creates the data layer.
      /// </summary>
      /// <param name="username">The username.</param>
      /// <param name="domain">The domain.</param>
      /// <param name="appId">The app id.</param>
      /// <param name="resourceSystem">The resource system.</param>
      /// <param name="rights">The user rights.</param>
      /// <returns></returns>
      private SeriesDataLayer Authorize(UserV user, Jnj.ThirdDimension.Arms.Model.Application app, string resourceSystem, ulong rights)
      {
         if (app == null || user == null) return null;

         BitArray r = new BitArray(new[] { (int)rights });
         bool authorized = Service.IsAuthorized(app, user, r);
         if (!authorized) return null;
         string connString = GetConnectionString(app, user, ProviderType.Odp, resourceSystem);

         DbConnectionInfo connInfo = InstantDbAccess.PrepareDBConnectionInfo(connString, DataProviderType.ODP);

         SeriesDataLayer dl = new SeriesDataLayer(connInfo);
         dl.SecurityContext.Application = app;
         dl.SecurityContext.User.FullName = user.Fullname;
         dl.SecurityContext.User.OrgSiteId = user.OrgSiteId ?? 0;
         dl.SecurityContext.User.OrgSite = user.OrgSite;
         dl.SecurityContext.User.PersonID = user.PersonId;
         dl.SecurityContext.User.WWID = user.Wwid ?? 0;
         dl.SecurityContext.User.UserRights = rights;
         dl.SecurityContext.ConnectionString = connString;
         dl.SecurityContext.ResourceSystemName = resourceSystem;
         dl.SecurityContext.AccountName = GetUserAppRoleResource(app, user, resourceSystem);

         dl.SecurityContext.IsAuthorized = true;

         return dl;
      }

      /// <summary>
      /// Authorizes user against application.
      /// </summary>
      /// <param name="user">The user.</param>
      /// <param name="app">The app.</param>
      /// <param name="rights">The rights.</param>
      public bool IsAuthorized(UserV user, Jnj.ThirdDimension.Arms.Model.Application app, ulong rights)
      {
         return Service.IsAuthorized(app, user, new BitArray(new[] { (int)rights }));
      }
   }
}
