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

namespace Jnj.ThirdDimension.Utils.BarcodeSeries
{
   /// <summary>
   /// Contains current user data.
   /// </summary>
   public class User
   {
      //public static string DBPassword;
      //public static string DBUser;
      //public static string Domain;
      //public static string Email;
      public static string FullName;
      //public static string UserName;
      public static decimal PersonID;
      public static decimal OrgSiteId;
      public static UInt64 UserRights;
      public static decimal WWID;
      public static string ConnectionString;
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
