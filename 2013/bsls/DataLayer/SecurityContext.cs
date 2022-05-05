#region Copyright (C) 1994-2009, Johnson & Johnson PRD, LLC.
//---------------------------------------------------------------------------*
//
//    User.cs: Represents a user.
//
//---
//
//    Copyright (C) 1994-2008, Johnson & Johnson PRD, LLC.
//    All Rights Reserved.
//
//    Vitaly Chupaev, 11/2008
//
//---------------------------------------------------------------------------*/
#endregion

using System;
using System.Collections.Generic;
using System.Text;
using Jnj.ThirdDimension.Arms.Model;

namespace Jnj.ThirdDimension.Data.BarcodeSeries
{
   /// <summary>
   /// Contains current user data.
   /// </summary>
   public class SecurityContext
   {
      public Application Application;
      public bool IsAuthorized = false;
      public string ConnectionString;
      public UserData User = new UserData();
      public string ResourceSystemName;
      public string AccountName;

      public class UserData
      {
         public string FullName;
         public decimal PersonID;
         public decimal OrgSiteId;
         public string OrgSite;
         public UInt64 UserRights;
         public decimal WWID;
      }

   }

   [Flags]
   public enum UserRights
   {
      ManageSeries = 1,
      GenerateSeries = 2,
      PrintLabels = 4,
      ReserveSeries = 8
   }
}
