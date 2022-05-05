using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Data;
using System.Data.Objects;
using System.Data.Objects.DataClasses;
using System.Data.SqlClient;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Security;
using System.Web.UI.WebControls;
using System.Xml;

namespace SharedLibrary
{
    /// <summary>
    /// A collection of useful methods
    /// </summary>
    public static class ExtensionMethods
    {

        #region IEnumerable<...>

        /// <summary>
        /// Returns objects of the specified types.
        /// </summary>
        public static IEnumerable OfType<T1, T2>(this IEnumerable source)
        {
            return source.Cast<object>().Where(item => item is T1 || item is T2);
        }

        /// <summary>
        /// Returns objects of the specified types.
        /// </summary>
        public static IEnumerable OfType<T1, T2, T3>(this IEnumerable source)
        {
            return source.Cast<object>().Where(item => item is T1 || item is T2 || item is T3);
        }

        /// <summary>
        /// Returns objects of the specified types.
        /// </summary>
        public static IEnumerable OfType<T1, T2, T3, T4>(this IEnumerable source)
        {
            return source.Cast<object>().Where(item => item is T1 || item is T2 || item is T3 || item is T4);
        }

        /// <summary>
        /// Returns objects of the specified types.
        /// </summary>
        public static IEnumerable OfType<T1, T2, T3, T4, T5>(this IEnumerable source)
        {
            return source.Cast<object>().Where(item => item is T1 || item is T2 || item is T3 || item is T4 || item is T5);
        }

        /// <summary>
        /// Returns objects of the specified types.
        /// </summary>
        public static IEnumerable OfType<T1, T2, T3, T4, T5, T6>(this IEnumerable source)
        {
            return source.Cast<object>().Where(item => item is T1 || item is T2 || item is T3 || item is T4 || item is T5 || item is T6);
        }

        #endregion

        #region IEnumerable<string>

        /// <summary>
        /// Creates a SQL expression NOT IN.
        /// Examples: "Column1 not in (1, 2, 3)"
        ///           "Column2 not in ('1', '2', '3')"
        /// </summary>
        /// <param name="list">The list of values.</param>
        /// <param name="field">The field name.</param>
        /// <param name="quote">if set to <c>true</c> quotes are added.</param>
        /// <returns></returns>
        public static string NotInList(this IEnumerable<string> list, string field, bool quote)
        {
            if (!list.Any())
            {
                return String.Empty;
            }

            return quote
                ? string.Format("{0} not in ('{1}')", field, string.Join("', '", list))
                : string.Format("{0} not in ({1})", field, string.Join(", ", list));
        }

        /// <summary>
        /// Converts collection to table.
        /// </summary>
        /// <param name="list">The list of value.</param>
        /// <param name="columnName">Name of the column.</param>
        /// <returns></returns>
        public static DataTable ToTable(this IEnumerable<string> list, string columnName)
        {
            var dt = new DataTable();
            dt.Columns.Add(columnName);

            list.ToList().ForEach(s => dt.Rows.Add(dt.NewRow()[0] = s));

            return dt;
        }

        #endregion

        #region object

        /// <summary>
        /// Tries convert object to string, if value is not null or DBNull.
        /// </summary>
        /// <param name="value">The value.</param>
        /// <returns>Returns string value or empty string.</returns>
        public static string ToStringOrEmpty(this object value)
        {
            if (value != null && value != DBNull.Value)
                return value.ToString();

            return string.Empty;
        }

        /// <summary>
        /// Converts the string to the byte array.
        /// </summary>
        /// <param name="str">The string.</param>
        /// <returns></returns>
        public static byte[] ToByteArray(this string str)
        {
            var bytes = new byte[str.Length * sizeof(char)];
            System.Buffer.BlockCopy(str.ToCharArray(), 0, bytes, 0, bytes.Length);
            return bytes;
        }

        /// <summary>
        /// Converts byte array to string.
        /// </summary>
        /// <param name="bytes">The bytes.</param>
        /// <returns></returns>
        public static string BytesArrayToString(this byte[] bytes)
        {
            var chars = new char[bytes.Length / sizeof(char)];
            System.Buffer.BlockCopy(bytes, 0, chars, 0, bytes.Length);
            return new string(chars);
        }

        /// <summary>
        /// Using a bit of reflection to build up the strings.
        /// </summary>
        public static string ToCsvHeader(this object obj)
        {
            if (obj == null)
                return string.Empty;

            obj = ((IEnumerable)obj).Cast<object>().FirstOrDefault();

            if (obj == null)
                return string.Empty;

            var type = obj.GetType();
            var properties = type.GetProperties(BindingFlags.DeclaredOnly |
                                           BindingFlags.Public |
                                           BindingFlags.Instance);

            var result = string.Empty;
            Array.ForEach(properties, prop =>
            {
                result += prop.Name + ",";
            });

            return (!string.IsNullOrEmpty(result) ? result.Substring(0, result.Length - 1) : result);
        }

        /// <summary>
        /// To the CSV row.
        /// </summary>
        /// <param name="obj">The object.</param>
        /// <returns></returns>
        public static string ToCsvRow(this object obj)
        {
            var type = obj.GetType();
            var properties = type.GetProperties(BindingFlags.DeclaredOnly |
                                           BindingFlags.Public |
                                           BindingFlags.Instance);

            var result = string.Empty;
            Array.ForEach(properties, prop =>
            {
                var value = prop.GetValue(obj, null);
                var propertyType = prop.PropertyType.FullName;
                if (propertyType == "System.String")
                {
                    // wrap value incase of commas
                    value = "\"" + value + "\"";
                }

                result += value + ",";

            });

            return (!string.IsNullOrEmpty(result) ? result.Substring(0, result.Length - 1) : result);
        }
        #endregion

        #region ObjectResult

        /// <summary>
        /// Converts stored procedure's scalar output value to int. 
        /// Assumes there is only one value.
        /// </summary>
        /// <param name="output">The output.</param>
        /// <returns>Return value or 0</returns>
        public static int ReturnValue(this ObjectResult<int?> output)
        {
            return output.FirstOrDefault() ?? 0;
        }

        #endregion

        #region string


        /// <summary>
        /// Replaces using RegEx with ignore case option.
        /// </summary>
        /// <param name="input">The input.</param>
        /// <param name="lookFor">The look for.</param>
        /// <param name="replaceWith">The replace with.</param>
        /// <returns></returns>
        public static string ReplaceIgnoreCase(this string input, string lookFor, string replaceWith)
        {
            return Regex.Replace(input, Regex.Escape(lookFor), replaceWith, RegexOptions.IgnoreCase);
        }

        /// <summary>
        /// Splits string.
        /// </summary>
        /// <param name="s">The s.</param>
        /// <param name="splitStrings">The split strings.</param>
        /// <returns></returns>
        public static string[] SplitBy(this string s, params string[] splitStrings)
        {
            return splitStrings.Length == 0 ? new[] { s } : s.Split(splitStrings, StringSplitOptions.RemoveEmptyEntries);
        }

        /// <summary>
        /// Tries to convert string to enum.
        /// </summary>
        /// <typeparam name="T">Enum</typeparam>
        /// <param name="s">The enum member name.</param>
        /// <exception cref="System.Exception">T must be an Enumeration type.</exception>
        public static T ToEnumByName<T>(this string s) where T : struct
        {
            if (!typeof(T).IsEnum)
            {
                throw new Exception("T must be an Enumeration type.");
            }

            T t;
            return Enum.TryParse(s, true, out t) ? t : default(T);
        }

        /// <summary>
        /// Tries to cast stringified integer to enum.
        /// </summary>
        /// <typeparam name="T">Enum</typeparam>
        /// <param name="s">The enum member's value.</param>
        /// <exception cref="System.Exception">T must be an Enumeration type.</exception>
        public static T ToEnumByVal<T>(this string s)
        {
            if (!typeof(T).IsEnum)
            {
                throw new Exception("T must be an Enumeration type.");
            }

            int k;
            return int.TryParse(s, out k) ? (T)Enum.ToObject(typeof(T), k) : default(T);
        }

        /// <summary>
        /// Tries convert to boolean, otherwise false.
        /// </summary>
        /// <param name="str">The value.</param>
        public static bool ToBoolean(this string str)
        {
            if (string.IsNullOrEmpty(str)) return false;

            bool v;
            return Boolean.TryParse(str, out v) && v;

        }

        /// <summary>
        /// Assumes the string value is a number with a floating point.
        /// Removes spaces, checks for non-digit chars and replaces all but plus and minus with CultureInfo.CurrentCulture.NumberFormat.NumberDecimalSeparator
        /// </summary>
        /// <param name="value">The value.</param>
        /// <returns></returns>
        public static string EnsureDecimalSeparator(this string value)
        {
            var arr = value.Replace(" ", string.Empty).ToCharArray();

            for (var k = 0; k < arr.Length; k++)
            {
                var v = arr[k];
                if (!char.IsDigit(v) && v != '-' && v != '+')
                {
                    arr[k] = Convert.ToChar(CultureInfo.CurrentCulture.NumberFormat.NumberDecimalSeparator);
                }
            }

            return new string(arr);
        }

        /// <summary>
        /// Tries to convert string to Int32, otherwise returns 0.
        /// </summary>
        public static int ToInt32(this string s)
        {
            int k;
            return int.TryParse(s, out k) ? k : 0;
        }

        /// <summary>
        /// Changes the first letter to upper case.
        /// </summary>
        /// <param name="s">The string.</param>
        /// <returns></returns>
        public static string UppercaseFirst(this string s)
        {
            var a = s.ToCharArray();
            a[0] = char.ToUpper(a[0]);
            return new string(a);
        }

        /// <summary>
        /// Doubles single quotes.
        /// </summary>
        /// <param name="value">The value.</param>
        /// <returns></returns>
        public static string SqlEscape(this string value)
        {
            if (string.IsNullOrWhiteSpace(value))
                return string.Empty;

            return value.Replace("'", "''");
        }


        /// <summary>
        /// Converts string to stream.
        /// </summary>
        /// <param name="value">The value.</param>
        /// <returns></returns>
        public static Stream ToStream(this string value)
        {
            var resultBytes = Encoding.UTF8.GetBytes(value);
            return new MemoryStream(resultBytes);
        }

        /// <summary>
        /// Replaces empty string with null.
        /// </summary>
        /// <param name="value">The value.</param>
        /// <returns></returns>
        public static string Null(this string value)
        {
            return value.Trim() == string.Empty ? null : value;
        }

        /// <summary>
        /// For bit columns converts dbnull to false or returns the value.
        /// </summary>
        /// <param name="value">The value.</param>
        /// <returns></returns>
        public static bool BitColumnBoolean(this object value)
        {
            return value != DBNull.Value && Convert.ToBoolean(value);
        }

        /// <summary>
        /// Splits the string on caps.
        /// </summary>
        /// <param name="text">The text.</param>
        /// <param name="preserveAcronyms">if set to <c>true</c> doesn't split acronyms.</param>
        /// <returns></returns>
        public static string SplitStringOnCaps(this string text, bool preserveAcronyms = true)
        {
            if (String.IsNullOrWhiteSpace(text)) return String.Empty;

            var newText = new StringBuilder(text.Length * 2);
            newText.Append(text[0]);

            for (var k = 1; k < text.Length; k++)
            {
                if (Char.IsUpper(text[k]))
                {
                    if ((text[k - 1] != ' ' && !Char.IsUpper(text[k - 1])) || (preserveAcronyms && Char.IsUpper(text[k - 1]) && k < text.Length - 1 && !Char.IsUpper(text[k + 1])))
                    {
                        newText.Append(' ');
                    }
                }

                newText.Append(text[k]);
            }

            return newText.ToString();
        }

        /// <summary>
        /// Splits the string to the List.
        /// </summary>
        /// <param name="value">The value.</param>
        /// <param name="delimiter">The delimiter.</param>
        /// <param name="unescape">if set to <c>true</c> applies the Uri.UnescapeDataString method.</param>
        /// <returns></returns>
        public static List<string> ToList(this string value, string delimiter = ",", bool unescape = false)
        {
            if (!string.IsNullOrWhiteSpace(value))
            {
                var array = value
                    .Split(new[] { delimiter }, StringSplitOptions.RemoveEmptyEntries);

                if (unescape)
                    return array.Select(Uri.UnescapeDataString).ToList();

                return array.ToList();
            }

            return new List<string>();
        }

        #endregion

        #region DateTime

        /// <summary>
        /// Converts time to provided time zone.
        /// </summary>
        /// <param name="dateTime">The date time.</param>
        /// <param name="countryCode">The country code.</param>
        /// <returns></returns>
        public static string ToUserLocalDateTimeString(this DateTime dateTime, string countryCode)
        {
            if (countryCode != null)
            {
                var tzi = TimeZoneInfo.FindSystemTimeZoneById(countryCode);
                return TimeZoneInfo.ConvertTimeFromUtc(dateTime, tzi).ToString();
            }

            return dateTime + " UTC";
        }

        #endregion

        #region ListControl


        /// <summary>
        /// Returns a collection of selected values.
        /// </summary>
        /// <param name="listBox">The list box.</param>
        public static List<string> SelectedValues(this ListControl listBox)
        {
            return listBox.Items
                .Cast<ListItem>()
                .Where(i => i.Selected)
                .Select(i => i.Value)
                .ToList();
        }

        /// <summary>
        /// Returns a collection of values of all items.
        /// </summary>
        /// <param name="listBox">The list box.</param>
        public static List<string> ItemsValues(this ListControl listBox)
        {
            return listBox.Items
                .Cast<ListItem>()
                .Select(i => i.Value)
                .ToList();
        }

        /// <summary>
        /// Determines whether list control has selected items.
        /// </summary>
        /// <param name="list">The list control.</param>
        /// <returns></returns>
        public static bool HasSelectedItems(this ListControl list)
        {
            return list.Items.Cast<ListItem>().Any(i => i.Selected);
        }

        /// <summary>
        /// Returns a ListItem collection of selected items.
        /// </summary>
        /// <param name="list">The listbox.</param>
        /// <returns></returns>
        public static IEnumerable<ListItem> SelectedItems(this ListControl list)
        {
            return list.Items.Cast<ListItem>().Where(i => i.Selected);
        }

        /// <summary>
        /// Selects and disables the items by value.
        /// </summary>
        /// <param name="list">The list control.</param>
        /// <param name="values">The values.</param>
        public static void DisableItemsByValue(this ListControl list, List<int> values)
        {
            foreach (var item in values.Select(value => list.Items.FindByValue(value.ToString())).Where(item => item != null))
            {
                item.Selected = true;
                item.Enabled = false;
            }
        }

        /// <summary>
        /// Selects items by value.
        /// </summary>
        /// <param name="list">The list control.</param>
        /// <param name="values">The values.</param>
        public static void SelectItemsByValue(this ListControl list, List<int> values)
        {
            foreach (var item in values.Select(value => list.Items.FindByValue(value.ToString())).Where(item => item != null))
            {
                item.Selected = true;
            }
        }

        /// <summary>
        /// Selects items by value.
        /// </summary>
        /// <param name="list">The list control.</param>
        /// <param name="values">The values.</param>
        public static void SelectItemsByValue(this ListControl list, List<string> values)
        {
            foreach (var item in values.Select(value => list.Items.FindByValue(value)).Where(item => item != null))
            {
                item.Selected = true;
            }
        }

        /// <summary>
        /// Selects first found item by value.
        /// </summary>
        /// <param name="list">The list control.</param>
        /// <param name="value">The value.</param>
        public static void SelectItemByValue(this ListControl list, string value)
        {
            var item = list.Items.FindByValue(value);
            if (item != null) item.Selected = true;
        }

        /// <summary>
        /// Selects all items.
        /// </summary>
        /// <param name="list">The list control.</param>
        public static void SelectAll(this ListControl list)
        {
            foreach (ListItem item in list.Items)
            {
                item.Selected = true;
            }
        }

        /// <summary>
        /// Sorts the specified list control by ListItem.Text property, ascending.
        /// </summary>
        /// <param name="lstBox">The LST box.</param>
        public static void Sort(this ListControl lstBox)
        {
            var list = lstBox.Items
                .Cast<ListItem>()
                .OrderBy(item => item.Text)
                .ToList();

            lstBox.Items.Clear();

            foreach (var listItem in list)
            {
                lstBox.Items.Add(listItem);
            }
        }

        #endregion

        #region List<string>

        /// <summary>
        /// Converts string list to collection of ListItems.
        /// </summary>
        /// <param name="list">The string list.</param>
        public static IEnumerable<ListItem> ToListItems(this List<string> list)
        {
            return list.Select(i => new ListItem(i.SplitStringOnCaps(), i));
        }

        /// <summary>
        /// Converts collection to table.
        /// </summary>
        /// <param name="list">The list of value.</param>
        /// <param name="columnName">Name of the column.</param>
        /// <returns></returns>
        public static DataTable ToTable<T>(this List<T> list, string columnName)
        {
            var dt = new DataTable();
            dt.Columns.Add(columnName);

            list.ToList().ForEach(s => dt.Rows.Add(dt.NewRow()[0] = s));

            return dt;
        }

        #endregion

        #region NameValueCollection

        /// <summary>
        /// Determines whether specified collection contains a key.
        /// For example the Request.QueryString.
        /// </summary>
        /// <param name="coll">The coll.</param>
        /// <param name="key">The key.</param>
        /// <returns></returns>
        public static bool HasKey(this NameValueCollection coll, string key)
        {
            return coll[key] != null;
        }

        #endregion

        #region SqlParameterCollection

        /// <summary>
        /// Determines whether specified collection contains a key, search is case insensitive.
        /// </summary>
        /// <param name="coll">The coll.</param>
        /// <param name="key">The key.</param>
        /// <returns></returns>
        public static bool HasParameter(this SqlParameterCollection coll, string key)
        {
            return coll
                .Cast<SqlParameter>()
                .Any(p => p.ParameterName.Equals(key, StringComparison.OrdinalIgnoreCase));
        }

        #endregion

        #region Dictionary

        /// <summary>
        /// Determines whether specified dictionary contains a key, search is case insensitive.
        /// </summary>
        /// <param name="coll">The coll.</param>
        /// <param name="key">The key.</param>
        /// <returns></returns>
        public static bool HasKey<TK, TV>(this Dictionary<TK, TV> coll, string key)
        {
            return coll.Keys.Any(p => p.ToString().Equals(key, StringComparison.OrdinalIgnoreCase));
        }

        #endregion

        #region DataSet

        /// <summary>
        /// Moves the table from one dataset to another.
        /// </summary>
        /// <param name="ds">The source dataset.</param>
        /// <param name="tableIndex">Index of the table.</param>
        /// <returns>New dataset</returns>
        public static DataSet MoveTableToNewDataSet(this DataSet ds, int tableIndex)
        {
            var nds = new DataSet();
            if (ds.Tables.Count > tableIndex)
            {
                var dt = ds.Tables[tableIndex];
                ds.Tables.Remove(dt);
                nds.Tables.Add(dt);
            }

            return nds;
        }

        /// <summary>
        /// Moves the table to new data set.
        /// </summary>
        /// <param name="ds">The source dataset.</param>
        /// <param name="newDataSet">The new data set.</param>
        /// <param name="table">The table to move.</param>
        /// <returns></returns>
        public static void MoveTableToNewDataSet(this DataSet ds, DataSet newDataSet, DataTable table)
        {
            var i = ds.Tables.IndexOf(table);
            if (i > -1)
            {
                var dt = ds.Tables[i];
                ds.Tables.Remove(dt);
                newDataSet.Tables.Add(dt);
            }
        }

        /// <summary>
        /// Moves the tables to new data set.
        /// </summary>
        /// <param name="ds">The ds.</param>
        /// <param name="tableNames">The table names.</param>
        /// <returns></returns>
        public static DataSet MoveTablesToNewDataSet(this DataSet ds, List<string> tableNames)
        {
            var nds = new DataSet();

            tableNames.ForEach(tn =>
            {
                var dt = ds.Tables[tn];
                if (dt != null)
                {
                    ds.Tables.Remove(dt);
                    nds.Tables.Add(dt);
                }
            });

            return nds;
        }


        /// <summary>
        /// Moves the tables to new data set.
        /// </summary>
        /// <param name="ds">The ds.</param>
        /// <param name="newDataSet">The new data set.</param>
        public static void MoveTablesToNewDataSet(this DataSet ds, DataSet newDataSet)
        {
            ds.Tables.Cast<DataTable>().ToList()
                .ForEach(dt =>
                {
                    ds.Tables.Remove(dt);
                    newDataSet.Tables.Add(dt);
                });
        }

        #endregion

        #region DataTable

        /// <summary>
        /// Removes table from dataset.
        /// </summary>
        /// <param name="dt">The dt.</param>
        /// <returns></returns>
        public static DataTable Detach(this DataTable dt)
        {
            var ds = dt.DataSet;
            if (ds != null)
            {
                ds.Tables.Remove(dt);
            }

            return dt;
        }

        /// <summary>
        /// Converts values of all empty cells to DBNull.
        /// </summary>
        /// <param name="table">The table.</param>
        /// <returns></returns>
        public static DataTable EmptyCellsToNull(this DataTable table)
        {
            foreach (DataColumn col in table.Columns)
            {
                if (col.AllowDBNull)
                {
                    foreach (DataRow row in table.Rows)
                    {
                        if (row[col] == DBNull.Value) continue;

                        if (row[col] == null || row[col].ToString() == string.Empty)
                        {
                            row[col] = DBNull.Value;
                        }
                    }
                }
            }

            return table;
        }

        #endregion

        #region ObjectContext

        /// <summary>
        /// Clones the specified ObjectContext.
        /// </summary>
        /// <typeparam name="T">EntityObject</typeparam>
        /// <param name="ctx">The ObjectContext.</param>
        /// <param name="entity">The entity.</param>
        /// <param name="copyKeys">if set to <c>true</c> then copy a key property.</param>
        /// <returns></returns>
        public static T Clone<T>(this ObjectContext ctx, T entity, bool copyKeys = false) where T : EntityObject
        {
            var clone = ctx.CreateObject<T>();
            var pis = entity.GetType().GetProperties();

            foreach (var pi in pis)
            {
                var attrs = (EdmScalarPropertyAttribute[])pi.GetCustomAttributes(typeof(EdmScalarPropertyAttribute), false);

                foreach (var attr in attrs)
                {
                    if (!copyKeys && attr.EntityKeyProperty) continue;
                    pi.SetValue(clone, pi.GetValue(entity, null), null);
                }
            }

            return clone;
        }

        #endregion

        #region HttpResponse

        /// <summary>
        /// Sets the authentication cookie with provided user data.
        /// </summary>
        /// <param name="response">The HttpResponse.</param>
        /// <param name="name">The username.</param>
        /// <param name="rememberMe">Persistent cookie or not.</param>
        /// <param name="userData">The user data.</param>
        /// <returns></returns>
        public static int SetAuthCookie(this HttpResponse response, string name, bool rememberMe, string userData)
        {
            var cookie = FormsAuthentication.GetAuthCookie(name, rememberMe);
            var ticket = FormsAuthentication.Decrypt(cookie.Value);

            var newTicket = new FormsAuthenticationTicket(ticket.Version, ticket.Name, ticket.IssueDate, ticket.Expiration,
                ticket.IsPersistent, userData, ticket.CookiePath);
            var encTicket = FormsAuthentication.Encrypt(newTicket);

            cookie.Value = encTicket;
            response.Cookies.Add(cookie);

            return encTicket.Length;
        }

        #endregion

        #region HttpRequest

        /// <summary>
        /// Expects userData to contain a string representation of GUID, wich stands for the Session Token.
        /// </summary>
        /// <param name="request">The request.</param>
        /// <param name="name">The name.</param>
        /// <returns></returns>
        public static Guid GetSessionToken(this HttpRequestBase request, string name)
        {
            var authCookie = request.Cookies[FormsAuthentication.FormsCookieName];
            var ticket = FormsAuthentication.Decrypt(authCookie.Value);

            if (!string.IsNullOrWhiteSpace(ticket.UserData))
            {
                Guid guid;
                if (Guid.TryParse(ticket.UserData, out guid))
                {
                    return guid;
                }
            }

            // if no guid in cookie, then any guid value will force to log out the user.
            return Guid.Empty;
        }

        /// <summary>
        /// Expects userData to contain a string representation of GUID, wich stands for the Session Token.
        /// </summary>
        /// <param name="request">The HttpRequest.</param>
        /// <param name="name">The username.</param>
        /// <returns></returns>
        public static Guid GetSessionToken(this HttpRequest request, string name)
        {
            return GetSessionToken(new HttpRequestWrapper(request), name);
        }

        #endregion

        #region Action<N>

        /// <summary>
        /// Invokes the callback action.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="action">The action.</param>
        /// <param name="param">The parameter.</param>
        public static void Answer<T>(this Action<T> action, T param)
        {
            if (action != null)
            {
                action.Invoke(param);
            }
        }

        /// <summary>
        /// Invokes the callback action.
        /// </summary>
        /// <param name="action">The action.</param>
        /// <param name="param">The parameter.</param>
        /// <param name="args">The arguments.</param>
        public static void Answer(this Action<string> action, string param, params object[] args)
        {
            if (action != null)
            {
                action.Invoke(string.Format(param, args));
            }
        }

        /// <summary>
        /// Invokes the callback action.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <typeparam name="TK">The type of the k.</typeparam>
        /// <param name="action">The action.</param>
        /// <param name="param1">The param1.</param>
        /// <param name="param2">The param2.</param>
        public static void Answer<T, TK>(this Action<T, TK> action, T param1, TK param2)
        {
            if (action != null)
            {
                action.Invoke(param1, param2);
            }
        }

        #endregion

        #region int, long

        private const long Kb = 1024;
        private const long Mb = Kb * 1024;
        private const long Gb = Mb * 1024;
        private const long Tb = Gb * 1024;

        /// <summary>
        /// Converts size in bytes to Tb, Gb, Mb, Kb, 
        /// For example "2700" to "3Kb"
        /// </summary>
        /// <param name="value">The value.</param>
        /// <param name="decimalPlaces">The decimal places.</param>
        /// <returns></returns>
        public static string ToPrettySize(this int value, int decimalPlaces = 0)
        {
            return ((long)value).ToPrettySize(decimalPlaces);
        }

        /// <summary>
        /// Converts size in bytes to Tb, Gb, Mb, Kb, 
        /// For example "2700" to "3Kb"
        /// </summary>
        /// <param name="value">The value.</param>
        /// <param name="decimalPlaces">The decimal places.</param>
        /// <returns></returns>
        public static string ToPrettySize(this long value, int decimalPlaces = 0)
        {
            var asTb = Math.Round((double)value / Tb, decimalPlaces);
            var asGb = Math.Round((double)value / Gb, decimalPlaces);
            var asMb = Math.Round((double)value / Mb, decimalPlaces);
            var asKb = Math.Round((double)value / Kb, decimalPlaces);
            var chosenValue = asTb > 1 ? string.Format("{0}Tb", asTb)
                : asGb > 1 ? string.Format("{0}Gb", asGb)
                : asMb > 1 ? string.Format("{0}Mb", asMb)
                : asKb > 1 ? string.Format("{0}Kb", asKb)
                : string.Format("{0}B", Math.Round((double)value, decimalPlaces));
            return chosenValue;
        }

        #endregion

        #region Type

        /// <summary>
        /// Get the equivalent SQL data type of the given type.
        /// </summary>
        /// <param name="type">Type to get the SQL type equivalent of</param>
        public static string GetSqlType(this Type type)
        {
            return "nvarchar(200)";
        }

        #endregion

    }
}
