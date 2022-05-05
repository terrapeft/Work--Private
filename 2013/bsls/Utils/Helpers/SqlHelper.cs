using System;
using System.Collections.Generic;
using System.Text;

namespace Jnj.ThirdDimension.Utils.BarcodeSeries
{
   public class SqlHelper
   {
      /// <summary>
      /// Gets text from the supplied sql starting from the FROM clause and returns query like
      /// "select count(*) FROM ...".
      /// </summary>
      /// <param name="sql">The SQL.</param>
      /// <returns></returns>
      public static string SelectCount(string sql)
      {
         string q = "select count(*) ";
         q += sql.Substring(sql.ToLower().IndexOf("from"));
         return q;
      }

      /// <summary>
      /// Gets text from the supplied sql starting from the FROM clause and returns query like
      /// "select count(*) FROM ...".
      /// </summary>
      /// <param name="p"></param>
      /// <returns></returns>
      public static string SelectCount(string sql, string filter)
      {
         string q = "select count(*) ";
         q += sql.Substring(sql.ToLower().IndexOf("from"));

         if (q.ToLower().IndexOf("where") > -1)
         {
            q += " and " + filter;
         }
         else
         {
            q += " where " + filter;
         }

         return q;
      }

      /// <summary>
      /// Returns query like "select max(Field) from Table where Field = x".
      /// </summary>
      /// <param name="query">The delimited query like: "select /Field/ from /Table</param>
      /// <returns></returns>
      public static string SelectMax(string query)
      {
         if (string.IsNullOrEmpty(query))
            return string.Empty;

         string sql = "select max({0}) from {1}";

         string[] parts = query.Split(new string[] { Constants.QUERY_DELIMITER }, StringSplitOptions.RemoveEmptyEntries);
         if (parts.Length > 3)
         {
            sql = string.Format(sql, parts[1], parts[3]);
         }

         return sql;
      }

      /// <summary>
      /// Returns field from the sql query.
      /// </summary>
      /// <param name="query">The query.</param>
      /// <returns></returns>
      public static string GetField(string query)
      {
         if (string.IsNullOrEmpty(query))
            return string.Empty;

         string[] parts = query.Split(new string[] { Constants.QUERY_DELIMITER }, StringSplitOptions.RemoveEmptyEntries);

         if (parts.Length > 3)
         {
            return parts[1];
         }

         return string.Empty;
      }

      /// <summary>
      /// Returns table name from the sql query.
      /// </summary>
      /// <param name="query">The query.</param>
      /// <returns></returns>
      public static string GetTable(string query)
      {
         if (string.IsNullOrEmpty(query))
            return string.Empty;

         string[] parts = GetFullTableName(query).Split('.');
         return parts.Length == 0 ? string.Empty : parts.Length == 1 ? parts[0] : parts[1];
      }

      /// <summary>
      /// Returns table owner from the sql query.
      /// </summary>
      /// <param name="query">The query.</param>
      /// <returns></returns>
      public static string GetSchema(string query)
      {
         if (string.IsNullOrEmpty(query))
            return string.Empty;

         string[] parts = GetFullTableName(query).Split('.');
         return parts.Length < 2 ? string.Empty : parts[0];
      }

      /// <summary>
      /// Returns table with owner from the sql query.
      /// </summary>
      /// <param name="query">The query.</param>
      /// <returns></returns>
      public static string GetFullTableName(string query)
      {
         if (string.IsNullOrEmpty(query))
            return string.Empty;

         string s = query.Substring(query.ToLower().IndexOf("from "));
         string[] parts = s.Split(new string[] { Constants.QUERY_DELIMITER }, StringSplitOptions.RemoveEmptyEntries);

         if (parts.Length > 0)
         {
            return parts[1];
         }

         return string.Empty;
      }

      /// <summary>
      /// Returns field from the sql query.
      /// </summary>
      /// <param name="query">The query.</param>
      /// <returns></returns>
      public static string GetFilter(string query)
      {
         if (string.IsNullOrEmpty(query))
            return string.Empty;

         if (query.ToLower().IndexOf("where ") > -1)
         {
            return query.Substring(query.ToLower().IndexOf("where ") + 6);
         }

         return string.Empty;
      }

      /// <summary>
      /// Joins the specified select statement with filter taking care of keyword "where".
      /// </summary>
      /// <param name="selectStatement">The select statement.</param>
      /// <param name="filter">The filter.</param>
      /// <returns></returns>
      public static string Join(string selectStatement, string filter)
      {
         if (selectStatement.ToLower().Contains("where"))
         {
            if (filter.ToLower().Contains("where"))
            {
               return string.Format("{0} {1}", selectStatement, filter.Replace("where", "and"));
            }

            return string.Format("{0} and {1}", selectStatement, filter);
         }

         if (filter.ToLower().Contains("where"))
         {
            return string.Format("{0} {1}", selectStatement, filter);
         }

         return string.Format("{0} where {1}", selectStatement, filter);
      }

      /// <summary>
      /// Removes illegal symbols from the sequence name.
      /// Everything except letters, digits and underscores will be removed.
      /// First digit will be forestalled with underscore, whitespaces replaced with underscores.
      /// </summary>
      /// <param name="proposedValue"></param>
      /// <returns></returns>
      public static string EnsureSequenceName(string proposedValue)
      {
         return EnsureSequenceName(proposedValue, string.Empty);
      }

      /// <summary>
      /// Removes illegal symbols from the sequence name.
      /// Everything except letters, digits and '_', '#', '$' will be removed.
      /// First digit will be preceded with 'a_', whitespaces replaced with underscores.
      /// Length is limited with 30 symbols.
      /// </summary>
      /// <param name="proposedValue">The proposed value.</param>
      /// <param name="concat">The concat.</param>
      /// <returns></returns>
      public static string EnsureSequenceName(string proposedValue, string concat)
      {
         List<char> allowedSymblos = new List<char>(new [] {'_', '#', '$'});
         StringBuilder seqName = new StringBuilder();

         // replace whitespaces
         proposedValue = proposedValue.Replace(" ", "_");

         // remove garbage
         foreach (char symbol in proposedValue)
         {
            if (Char.IsLetterOrDigit(symbol) || allowedSymblos.Contains(symbol))
            {
               seqName.Append(symbol);
            }
         }

         if (seqName.Length == 0) throw new ArgumentOutOfRangeException("Sequence name cannot be empty.");

         // sequence name cannot start with digit
         if (Char.IsDigit(seqName[0]))
         {
            seqName.Insert(0, "a_");
         }

         // check length taking into account a concatination string.
         // 30 is the maximum size for the sequence name in Oracle
         if (concat.Length > 28)
         {
            // leave a space for possible preceding prefix 'a_'
            concat = concat.Substring(0, 28);
         }

         int maxLength = ((seqName.Length + concat.Length) <= 30) ? seqName.Length : 30 - concat.Length;
         string cutStr = seqName.ToString(0, maxLength) + concat;

         return cutStr;
      }
   }
}
