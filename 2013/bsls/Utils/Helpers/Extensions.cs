using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Jnj.ThirdDimension.Utils.BarcodeSeries.Helpers;
using System.Linq.Expressions;
using System.Data;


namespace Jnj.ThirdDimension.Utils.BarcodeSeries
{
   public static class Extensions
   {

      #region For strings

      public delegate bool TryParseDelegate<T>(string data, out T output);

      /// <summary>
      /// Changes single quote to two single quotes to make string oracle compliant.
      /// </summary>
      /// <param name="data"></param>
      /// <returns></returns>
      public static string OracleEscaped(this string data)
      {
         return data.Replace("'", "''");
      }

      public static bool ContainsDigitsOnly (this string data)
      {
         foreach (char ch in data)
         {
            if (!char.IsDigit(ch))
               return false;
         }
         return true;
      }

      /// <summary>
      /// Tries convert the string to nullable type.
      /// </summary>
      /// <typeparam name="T"></typeparam>
      /// <param name="data"></param>
      /// <param name="func"></param>
      /// <returns></returns>
      public static T? ToNullablePrimitive<T>(this string data, TryParseDelegate<T> func) where T : struct
      {
         if (string.IsNullOrEmpty(data)) return null;

         T output;

         if (func(data, out output))
         {
            return (T?) output;
         }

         return null;
      }

      /// <summary>
      /// Gets first column and puts it to the list.
      /// </summary>
      /// <param name="dt">The dt.</param>
      /// <returns></returns>
      public static List<string> RowsToList(this DataTable dt)
      {
         List<string> l = new List<string>();
         foreach (DataRow row in dt.Rows)
         {
            if (row[0] != DBNull.Value)
            {
               l.Add(row[0].ToString());
            }
         }

         return l;
      }

      #endregion


      #region For Expressions

      /// <summary>
      /// Composes lambda expressions without using invoke.
      /// Useful with Linq to Enitites.
      /// </summary>
      /// <typeparam name="T"></typeparam>
      /// <param name="first"></param>
      /// <param name="second"></param>
      /// <param name="merge"></param>
      /// <returns></returns>
      public static Expression<T> Compose<T>(this Expression<T> first, Expression<T> second, Func<Expression, Expression, Expression> merge)
      {
         // build parameter map (from parameters of second to parameters of first)
         var map = first.Parameters.Select((f, i) => new { f, s = second.Parameters[i] }).ToDictionary(p => p.s, p => p.f);

         // replace parameters in the second lambda expression with parameters from the first
         var secondBody = ParameterRebinder.ReplaceParameters(map, second.Body);

         // apply composition of lambda expression bodies to parameters from the first expression 
         return Expression.Lambda<T>(merge(first.Body, secondBody), first.Parameters);
      }

      public static Expression<Func<T, bool>> And<T>(this Expression<Func<T, bool>> first, Expression<Func<T, bool>> second)
      {
         return first.Compose(second, Expression.And);
      }

      public static Expression<Func<T, bool>> Or<T>(this Expression<Func<T, bool>> first, Expression<Func<T, bool>> second)
      {
         return first.Compose(second, Expression.Or);
      }

      #endregion

   }
}
