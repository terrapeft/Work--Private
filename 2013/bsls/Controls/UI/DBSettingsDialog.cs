#region Copyright (C) 1994-2009, Johnson & Johnson PRD, LLC.
//---------------------------------------------------------------------------*
//
//    DBSettingsDialog.cs: Allows to specify database server options for Series. 
//
//---
//
//    Copyright (C) 1994-2009, Johnson & Johnson PRD, LLC.
//    All Rights Reserved.
//
//    Vitaly Chupaev, 11/2009
//
//---------------------------------------------------------------------------*/
#endregion

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using Jnj.ThirdDimension.Data;
using Syncfusion.Windows.Forms.Tools;
using Jnj.ThirdDimension.Mt.Util;
using Jnj.ThirdDimension.BusinessLayer.BarcodeSeries;
using res = Jnj.ThirdDimension.Controls.BarcodeSeries.Properties;
using Jnj.ThirdDimension.Utils.BarcodeSeries;
using Jnj.ThirdDimension.Arms.Model;
using System.Data.EntityClient;
using Jnj.ThirdDimension.Base;
using Jnj.ThirdDimension.Data.BarcodeSeries;
using Jnj.ThirdDimension.Controls.BarcodeSeries.Properties;

namespace Jnj.ThirdDimension.Controls.BarcodeSeries
{
   /// <summary>
   /// Allows to specify database server options for Series.
   /// </summary>
   public partial class DBSettingsDialog : Form
   {
      private List<ResourceSystem> seqResources;
      private List<ResourceSystemAccess> seqAccounts;
      private string seqResName;
      private DataProviderType seqProviderType = DataProviderType.ODP;
      private string seqInitialUser;

      private List<ResourceSystem> tabResources;
      private List<ResourceSystemAccess> tabAccounts;
      private string tabResName;
      private DataProviderType tabProviderType = DataProviderType.ODP;
      private string tabInitialUser;
      private bool suspendComboBoxUpdate = false;   // indicate wheather to skip SelectedIndexChanged event
      private bool sequenceCreated = false;
      private SeriesDataLayer dataLayer;

      #region Constructor

      public DBSettingsDialog()
      {
         InitializeComponent();
      }

      public DBSettingsDialog(SeriesDataLayer dataLayer) : this()
      {
         this.dataLayer = dataLayer;
         HideOutput();
      }

      #endregion

      #region Public members
      /// <summary>
      /// Resets the form.
      /// </summary>
      public void Reset()
      {
         SuspendComboBoxUpdate = true;
         try
         {
            HideOutput();
            ResetControls(this);

            autoSeqCheckBox.Checked = true;
            seqInitialUser = null;
            tabInitialUser = null;
            seqResName = null;
            tabResName = null;
            seqProviderType = DataProviderType.ODP;
            tabProviderType = DataProviderType.ODP;
         }
         finally
         {
            SuspendComboBoxUpdate = false;
         }
      }

      public bool AutoSequenceManagement
      {
         get { return autoSeqCheckBox.Checked; }
         set
         {
            autoSeqCheckBox.Checked = value;
            EnableSequence(!value);
            if (value) SetDefaultSequenceValues();
         }
      }

      public bool UseValidationQuery
      {
         get { return checkBoxUseValidationQuery.Checked; }
         set
         {
            checkBoxUseValidationQuery.Checked = value;
            EnableValidationQuery(value);
         }
      }

      public string SeriesName { get; set; }

      private List<ResourceSystemAccess> SequenceAccounts
      {
         get
         {
            return seqAccounts;
         }
         set
         {
            seqAccounts = value;

            if (value != null)
            {
               seqAccounts.Sort(CompareAccounts);
               seqAccComboBox.DisplayMember = "AccountName";
               seqAccComboBox.DataSource = seqAccounts;

               seqAccComboBox_SelectedIndexChanged(this, EventArgs.Empty);
            }
         }
      }     

      private List<ResourceSystemAccess> TableAccounts
      {
         get
         {
            return tabAccounts;
         }
         set
         {
            tabAccounts = value;

            if (value != null)
            {
               tabAccounts.Sort(CompareAccounts);
               tableAccComboBox.DisplayMember = "AccountName";
               tableAccComboBox.DataSource = tabAccounts;
            }
         }
      }

      public string SequenceAccountName
      {
         get
         {
            if (autoSeqCheckBox.Checked)
            {
               return dataLayer.SecurityContext.AccountName;
            }

            return SequenceAccount == null ? string.Empty : SequenceAccount.AccountName;
         }
         set
         {
            if (seqAccounts == null) return;
            foreach (ResourceSystemAccess account in seqAccounts)
            {
               if (account.AccountName == value)
               {
                  seqAccComboBox.SelectedItem = account;
                  break;
               }
            }
         }
      }

      public string TableAccountName
      {
         get
         {
            return TableAccount == null ? string.Empty : TableAccount.AccountName;
         }
         set
         {
            if (tabAccounts == null) return;
            foreach (ResourceSystemAccess account in tabAccounts)
            {
               if (account.AccountName == value)
               {
                  tableAccComboBox.SelectedItem = account;
                  break;
               }
            }
         }
      }

      private ResourceSystemAccess SequenceAccount
      {
         get
         {
            return seqAccComboBox.SelectedItem as ResourceSystemAccess;
         }
         set
         {
            seqAccComboBox.SelectedItem = value;
         }
      }

      private ResourceSystemAccess TableAccount
      {
         get
         {
            return tableAccComboBox.SelectedItem as ResourceSystemAccess;
         }
         set
         {
            tableAccComboBox.SelectedItem = value;
         }
      }

      public List<ResourceSystem> SequenceResources
      {
         get
         {
            if (seqResources == null)
            {
               seqResources = new List<ResourceSystem>();
            }
            return seqResources;
         }
         set
         {
            seqResources = value;

            if (seqResources != null)
            {
               seqResources.Sort(CompareResources);
               seqResComboBox.DisplayMember = "Name";
               seqResComboBox.DataSource = seqResources;

               if (!string.IsNullOrEmpty(seqResName))
               {
                  SetResource(seqResName, Endpoint.Sequence);
               }
            }
         }
      }

      public List<ResourceSystem> TableResources
      {
         get
         {
            if (tabResources == null)
            {
               tabResources = new List<ResourceSystem>();
            }
            return tabResources;
         }
         set
         {

            tabResources = value;

            if (tabResources != null)
            {
               tabResources.Sort(CompareResources);
               tableResComboBox.DisplayMember = "Name";
               tableResComboBox.DataSource = tabResources;

               if (!string.IsNullOrEmpty(tabResName))
               {
                  SetResource(tabResName, Endpoint.Table);
               }
            }
         }
      }

      /// <summary>
      /// Returns name in format "Schema.SequenceName".
      /// </summary>
      public string DBSequence
      {
         get
         {
            return string.Format("{0}.{1}", SequenceSchemaName, SequenceName);
         }
         set
         {
            if (string.IsNullOrEmpty(value)) return;

            string[] seq = value.Split(new char[] { '.' });

            SequenceSchemaName = seq[0];
            SequenceName = seq[1];
         }
      }

      /// <summary>
      /// Gets the schema name.
      /// </summary>
      /// <value>The schema.</value>
      public string SequenceSchemaName
      {
         get
         {
            if (autoSeqCheckBox.Checked)
            {
               return SeriesDataLayer.SEQ_SCHEMA_NAME;
            }

            return seqSchemaCombobox.SelectedValue == null
                      ? seqSchemaCombobox.Text
                      : GetString(seqSchemaCombobox.SelectedValue);
         }
         set
         {
            seqSchemaCombobox.SelectedItem = value;
         }
      }

      /// <summary>
      /// Gets the schema name.
      /// </summary>
      /// <value>The schema.</value>
      public string TableSchemaName
      {
         get
         {
            return tableSchemaComboBox.SelectedValue == null
                      ? tableSchemaComboBox.Text
                      : GetString(tableSchemaComboBox.SelectedValue);
         }
         set
         {
            tableSchemaComboBox.SelectedItem = value;
         }
      }

      /// <summary>
      /// Returns name in format "SequenceName".
      /// </summary>
      public string SequenceName
      {
         get
         {
            if (autoSeqCheckBox.Checked)
            {
               return SqlHelper.EnsureSequenceName(SeriesName, "_seq");
            }

            return sequenceComboBox.SelectedValue == null
                      ? sequenceComboBox.Text
                      : GetString(sequenceComboBox.SelectedValue);
         }
         set
         {
            sequenceComboBox.SelectedItem = value;
            if (sequenceComboBox.SelectedItem == null)
            {
               sequenceComboBox.Text = value;
            }
         }
      }

      public string FieldName
      {
         get
         {
            return fieldComboBox.SelectedValue == null
                      ? fieldComboBox.Text
                      : GetString(fieldComboBox.SelectedValue);
         }
         set
         {
            fieldComboBox.SelectedItem = value;
         }
      }

      public string TableName
      {
         get
         {
            return tableComboBox.SelectedValue == null
                      ? tableComboBox.Text
                      : GetString(tableComboBox.SelectedValue);
         }
         set
         {
            tableComboBox.SelectedItem = value;
         }
      }

      public string Filter
      {
         get
         {
            return GetString(filterTextBox.Text);
         }
         set
         {
            filterTextBox.Text = value;
         }
      }

      /// <summary>
      /// Provides connection string.
      /// Used to store a connection info in db.
      /// </summary>
      public string SequenceConnectionString
      {
         get
         {
            return ConstructConnectionString(true, Endpoint.Sequence);
         }
         set
         {
            if (seqAccounts == null)
            {
               seqInitialUser = ConnectionStringHelper.GetUser(value);
            }
            else
            {
               SequenceAccountName = (ConnectionStringHelper.GetUser(value));
            }
         }
      }

      /// <summary>
      /// Provides connection string.
      /// Used to store a connection info in db.
      /// </summary>
      public string TableConnectionString
      {
         get
         {
            return ConstructConnectionString(true, Endpoint.Table);
         }
         set
         {
            if (tabAccounts == null)
            {
               tabInitialUser = ConnectionStringHelper.GetUser(value);
            }
            else
            {
               TableAccountName = (ConnectionStringHelper.GetUser(value));
            }
         }
      }

      /// <summary>
      /// Provides connection string.
      /// Used to store a connection info in db.
      /// </summary>
      public string SequenceResourceName
      {
         get
         {
            if (autoSeqCheckBox.Checked)
            {
               return dataLayer.SecurityContext.ResourceSystemName;
            }

            var res = seqResComboBox.SelectedItem as ResourceSystem;
            if (res != null)
            {
               return res.Name;
            }
            return string.Empty;
         }
         set
         {
            seqResName = value;

            if (seqResources != null)
            {
               SetResource(value, Endpoint.Sequence);
            }
         }
      }

      /// <summary>
      /// Provides connection string.
      /// Used to store a connection info in db.
      /// </summary>
      public string TableResourceName
      {
         get
         {
            var res = tableResComboBox.SelectedItem as ResourceSystem;
            if (res != null)
            {
               return res.Name;
            }
            return string.Empty;
         }
         set
         {
            tabResName = value;

            if (tabResName != null)
            {
               SetResource(value, Endpoint.Table);
            }
         }
      }

      /// <summary>
      /// Handles delimited query.
      /// </summary>
      /// <value>The DB query formatted.</value>
      public string DBQuery
      {
         get
         {
            return queryTextBox.Text;
         }
         set
         {
            DisassembleQuery(value);
         }
      }

      public DataProviderType SequenceDataProviderType
      {
         get { return seqProviderType; }
         set
         {
            seqProviderType = (value == DataProviderType.Oracle) ? DataProviderType.ODP : value;
            sequencePanel.Enabled = (seqProviderType == DataProviderType.ODP && !autoSeqCheckBox.Checked);
         }
      }

      public DataProviderType TableDataProviderType
      {
         get { return tabProviderType; }
         set
         {
            tabProviderType = (value == DataProviderType.Oracle) ? DataProviderType.ODP : value;
         }
      }

      /// <summary>
      /// Provides connection string.
      /// </summary>
      public string SequenceDecryptedConnectionString
      {
         get
         {
            if (autoSeqCheckBox.Checked)
            {
               return dataLayer.SecurityContext.ConnectionString;
            }

            return ConstructConnectionString(false, Endpoint.Sequence);
         }
      }

      /// <summary>
      /// Provides connection string.
      /// </summary>
      public string TableDecryptedConnectionString
      {
         get
         {
            return ConstructConnectionString(false, Endpoint.Table);
         }
      }

      public bool SuspendComboBoxUpdate
      {
         get { return suspendComboBoxUpdate; }
         set { suspendComboBoxUpdate = value; }
      }

      #endregion


      #region Utils

      private int CompareResources(ResourceSystem x, ResourceSystem y)
      {
         if (x.Name == null && y.Name == null) return 0;
         if (x.Name == null) return -1;
         if (y.Name == null) return 1;

         return x.Name.CompareTo(y.Name);
      }

      private string GetString(object val)
      {
         if (val == null || val == DBNull.Value)
            return string.Empty;

         return val.ToString();
      }

      private int CompareAccounts(ResourceSystemAccess x, ResourceSystemAccess y)
      {
         return x.AccountName.CompareTo(y.AccountName);
      }

      internal void SetResources(List<ResourceSystem> resources, Endpoint type)
      {
         if (type == Endpoint.Sequence)
         {
            SequenceResources = resources;
         }
         else
         {
            TableResources = resources;
         }
      }

      private void SetResource(string resName, Endpoint type)
      {
         List<ResourceSystem> resources = (type == Endpoint.Sequence) ? seqResources : tabResources;
         ComboBoxAdv combo = (type == Endpoint.Sequence) ? seqResComboBox : tableResComboBox;

         for (int k = 0; k < resources.Count; k++)
         {
            if (!string.IsNullOrEmpty(resources[k].Name) && resources[k].Name == resName)
            {
               combo.SelectedIndex = k;
               break;
            }
         }
      }

      private ResourceSystemAccess GetAccount(Endpoint type)
      {
         return (type == Endpoint.Sequence) ? SequenceAccount : TableAccount;
      }

      private ResourceSystem GetResource(Endpoint type)
      {
         return (type == Endpoint.Sequence)
            ? seqResComboBox.SelectedItem as ResourceSystem
            : tableResComboBox.SelectedItem as ResourceSystem;
      }

      private bool ValidateForm()
      {
         if (sequencePanel.Enabled)
         {
            if (seqResComboBox.SelectedItem == null) return false;
            if (seqAccComboBox.SelectedItem == null) return false;
            if (sequenceComboBox.SelectedItem == null && sequenceComboBox.Text.IsEmpty()) return false;
            if (seqSchemaCombobox.SelectedItem == null) return false;
         }

         if (UseValidationQuery)
         {
            if (tableResComboBox.SelectedItem == null) return false;
            if (tableAccComboBox.SelectedItem == null) return false;
            if (tableSchemaComboBox.SelectedItem == null) return false;
            if (tableComboBox.SelectedItem == null) return false;
            if (fieldComboBox.SelectedItem == null) return false;
         }
         
         return true;
      }

      private string ConstructConnectionString(bool encrypt, Endpoint type)
      {
         ResourceSystem res = GetResource(type);
         ResourceSystemAccess acc = GetAccount(type);

         if (res == null || res.Information.IsEmpty()) return string.Empty;

         string cn = ConnectionStringHelper.GetOdpConnectionString(res.Information);

         if (cn.Length == 0) return cn;

         string pwd = acc.AccountPassword;
         if (!encrypt)
         {
            pwd = Security.XORDecrypt(pwd);
         }
         cn = cn.Replace("USERXXX", acc.AccountName);
         cn = cn.Replace("PWDXXX", pwd);
         return cn;
      }

      /// <summary>
      /// Resets the controls.
      /// </summary>
      /// <param name="control">The control.</param>
      private void ResetControls(Control control)
      {
         foreach (Control ctl in control.Controls)
         {
            if (ctl is TextBox)
            {
               ctl.Text = string.Empty;
               continue;
            }
            if (ctl is ComboBoxAdv)
            {
               ((ComboBoxAdv)ctl).SelectedItem = null;
               continue;
            }

            if (ctl is GroupBox || ctl is Panel)
            {
               ResetControls(ctl);
            }
         }
      }

      /// <summary>
      /// Enables or disables controls on the parent control.
      /// </summary>
      /// <param name="enable"></param>
      /// <param name="controlType">Type of the control to disable, use null to disable all.</param>
      /// <param name="parentControl">The parent control.</param>
      private void EnableSequence(bool enable)
      {
         seqResComboBox.Enabled = enable;
         seqResLabel.Enabled = enable;
         sequencePanel.Enabled = enable;// && !autoSeqCheckBox.Checked; // ? true : false;                  
      }

      private void EnableValidationQuery(bool enable)
      {
         panelValidationQuery.Enabled = enable;                  
      }

      /// <summary>
      /// Hides the output.
      /// </summary>
      private void HideOutput()
      {
         //outputPanel.Visible = false;
      }

      /// <summary>
      /// Shows the output.
      /// </summary>
      private void ShowOutput()
      {
         //outputPanel.Visible = true;
      }

      /// <summary>
      /// Handles the Click event of the testConnectionButton control.
      /// </summary>
      /// <param name="sender">The source of the event.</param>
      /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
      private void testConnectionButton_Click(object sender, EventArgs e)
      {
         if (!ValidateForm())
         {
            MessagesHelper.ShowInformation("Please fill all required fields.", WizardHelper.FindParentHeaderText(this));
            return;
         }

         TestConnectionEventArgs args = null;

         try
         {
            if (outputTextBox.Text.Length > 0)
            {
               outputTextBox.Text += string.Format("{0}{1}", new String('-', 20), Environment.NewLine);
            }

            if (TestSequence != null)
            {
               this.Cursor = Cursors.WaitCursor;

               ShowOutput();
               args = new TestConnectionEventArgs();
               TestSequence(this, args);

               PrintSeqResults(args, null);
            }

            if (TestTargetTable != null && UseValidationQuery)
            {
               this.Cursor = Cursors.WaitCursor;

               ShowOutput();
               args = new TestConnectionEventArgs();
               TestTargetTable(this, args);

               PrintTableResults(args, null);
            }
         }
         catch (Exception ex)
         {
            MessagesHelper.ReportError(ex, true);
         }
         finally
         {
            this.Cursor = Cursors.Default;
         }
      }

      /// <summary>
      /// Populates the results of connection testing.
      /// </summary>
      private void PrintSeqResults(TestConnectionEventArgs args, Exception ex)
      {
         if (args.SequenceServerConnected)
         {
            outputTextBox.Text += "> " + "Connection with sequence server was successful.\r\n";
         }

         if (args.SequenceCurrentValue > -1)
         {
            sequenceCreated = true;
            outputTextBox.Text += "> " + string.Format("The next sequence value is {0}.\r\n", args.SequenceCurrentValue);
         }
         else
         {
            sequenceCreated = false;
            outputTextBox.Text += string.Format("> Sequence {0} was not created\r\n", DBSequence.ToUpper());
         }

         if (ex != null)
         {
            outputTextBox.Text += "> " + ex.Message + "\r\n";
         }
      }

      /// <summary>
      /// Populates the results of connection testing.
      /// </summary>
      private void PrintTableResults(TestConnectionEventArgs args, Exception ex)
      {
         if (args.TableServerConnected)
         {
            outputTextBox.Text += "> " + "Connection with target server was successful.\r\n";
         }

         if (args.QueryResult > -1)
         {
            outputTextBox.Text += "> " + string.Format("Query returns {0} results.\r\n", args.QueryResult);
         }

         if (ex != null)
         {
            outputTextBox.Text += "> " + ex.Message + "\r\n";
         }
      }


      /// <summary>
      /// Removes specified strings from the source string.
      /// </summary>
      /// <param name="sourceString">The source string.</param>
      /// <param name="removeString">Strings to remove.</param>
      private void RemoveText(TextBox textBox, params string[] removeStrings)
      {
         int selStart = textBox.SelectionStart;

         foreach (string rStr in removeStrings)
         {
            textBox.Text = textBox.Text.Replace(rStr, string.Empty);
         }

         textBox.SelectionStart = selStart;
      }

      /// <summary>
      /// Assembles the query.
      /// </summary>
      /// <returns></returns>
      private string AssembleQuery()
      {
         StringBuilder sb = new StringBuilder();
         sb.Append("select ");
         sb.Append(FieldName.ToUpper());
         sb.Append(" from ");
         sb.Append(TableSchemaName.ToUpper());
         sb.Append(".");
         sb.Append(TableName.ToUpper());

         if (!filterTextBox.Text.Trim().IsEmpty())
         {
            sb.Append(" where ");
            sb.Append(filterTextBox.Text.ToUpper());
         }
         return sb.ToString();
      }

      private void DisassembleQuery(string query)
      {
         TableSchemaName = SqlHelper.GetSchema(query);
         TableName = SqlHelper.GetTable(query);
         FieldName = SqlHelper.GetField(query);
         Filter = SqlHelper.GetFilter(query);
      }

      #endregion


      #region Event handlers

      private void seqResComboBox_SelectedIndexChanged(object sender, EventArgs e)
      {
         try
         {
            if (SuspendComboBoxUpdate) return;
            //using (AsynchronousWaitDialog.ShowWaitDialog("Loading resource systems..."))
            //{
               ResourceSystem res = ((ComboBoxAdv) sender).SelectedItem as ResourceSystem;
               if (res != null && res.Name != null)
               {
                  SequenceAccounts = new List<ResourceSystemAccess>(res.ResourceSystemAccess);                  
                  seqResName = res.Name;                                   

                  if (res.ResourceSystemType != null && res.ResourceSystemType.Name == "Oracle")
                  {
                     sequencePanel.Enabled = !autoSeqCheckBox.Checked;
                     seqProviderType = Data.DataProviderType.ODP;                     
                  }
                  else
                  {
                     MessagesHelper.ShowInformation(Resources.MSSQL_Unsupported, this.Text);
                     sequencePanel.Enabled = false;
                     seqProviderType = Data.DataProviderType.SqlServer;
                  }

                  if (!seqInitialUser.IsEmpty() && seqAccounts != null && !AutoSequenceManagement)
                  {
                     SequenceAccountName = seqInitialUser;
                     seqInitialUser = null;
                  }                  
               }
            //}
         }
         catch (Exception ex)
         {
            MessagesHelper.ReportError(ex, false);
         }
      }

      private void tableResComboBox_SelectedIndexChanged(object sender, EventArgs e)
      {
         try
         {
            if (SuspendComboBoxUpdate) return;
            //using (AsynchronousWaitDialog.ShowWaitDialog("Loading resource systems..."))
            //{
               ResourceSystem res = ((ComboBoxAdv) sender).SelectedItem as ResourceSystem;
               if (res != null && res.Name != null)
               {
                  TableAccounts = new List<ResourceSystemAccess>(res.ResourceSystemAccess);
                  tabResName = res.Name;

                  if (res.ResourceSystemType != null && res.ResourceSystemType.Name == "Oracle")
                  {
                     tabProviderType = Data.DataProviderType.ODP;
                  }
                  else
                  {
                     tabProviderType = Data.DataProviderType.SqlServer;
                     MessagesHelper.ShowInformation(Resources.MSSQL_Unsupported, this.Text);
                  }

                  if (!tabInitialUser.IsEmpty() && tabAccounts != null)
                  {
                     TableAccountName = tabInitialUser;
                     tabInitialUser = null;
                  }
               }
           // }
         }
         catch (Exception ex)
         {
            MessagesHelper.ReportError(ex, false);
         }
      }

      /// <summary>
      /// Handles the TextChanged event of the sequenceTextBox.
      /// </summary>
      /// <param name="sender">The source of the event.</param>
      /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
      private void textBox_TextChanged(object sender, EventArgs e)
      {
         try
         {
            RemoveText(sender as TextBox, " ", ",");
         }
         catch (Exception ex)
         {
            MessagesHelper.ReportError(ex, false);
         }
      }

      private void sql_TextChanged(object sender, EventArgs e)
      {
         try
         {
            if (sender != null)
            {
               RemoveText(sender as TextBox, " ", ",");
            }
            queryTextBox.Text = AssembleQuery();
         }
         catch (Exception ex)
         {
            MessagesHelper.ReportError(ex, false);
         }
      }

      private void filterTextBox_TextChanged(object sender, EventArgs e)
      {
         try
         {
            queryTextBox.Text = AssembleQuery();
         }
         catch (Exception ex)
         {
            MessagesHelper.ReportError(ex, false);
         }
      }

      private void checkBox1_CheckedChanged(object sender, EventArgs e)
      {
         try
         {
            EnableSequence(!autoSeqCheckBox.Checked);
            if (autoSeqCheckBox.Checked) SetDefaultSequenceValues();
         }
         catch (Exception ex)
         {
            MessagesHelper.ReportError(ex, false);
         }
      }

      private void SetDefaultSequenceValues()
      {
         SequenceResourceName = SequenceResourceName; // returns default value
         SequenceAccountName = SequenceAccountName;  // returns default value
      }

      private void tableAccComboBox_SelectedIndexChanged(object sender, EventArgs e)
      {
         try
         {
            if (SuspendComboBoxUpdate) return;
            if (TableDecryptedConnectionString.IsEmpty()) return;

            using (AsynchronousWaitDialog.ShowWaitDialog("Loading...", false))
            {
               tableSchemaComboBox.AllowNewText = (tabProviderType == DataProviderType.SqlServer);
               if (tabProviderType == DataProviderType.SqlServer) return;

               DbConnectionInfo connInfo = InstantDbAccess.PrepareDBConnectionInfo(TableDecryptedConnectionString,
                                                                                   TableDataProviderType);
               SeriesDataLayer dl = new SeriesDataLayer(connInfo);              

               IList<string> schemas = null;
               string currentSchema = TableSchemaName;

               using (dl.Connect())
               {
                  schemas = dl.MetadataDB.GetSchemas();
                  tableSchemaComboBox.DataSource = dl.MetadataDB.GetSchemas();
               }

               if (currentSchema != null && schemas.Contains(currentSchema) && !Object.Equals(tableSchemaComboBox.SelectedValue, currentSchema))
               {
                  tableSchemaComboBox.SelectedIndex = schemas.IndexOf(currentSchema);
               }
               else
               {
                  tableSchemaComboBox_SelectedIndexChanged(this, EventArgs.Empty);
               }

               sql_TextChanged(null, null);
            }
         }
         catch (Exception ex)
         {
            MessagesHelper.ReportError(ex, false);
         }
      }

      private void tableSchemaComboBox_SelectedIndexChanged(object sender, EventArgs e)
      {
         try
         {
            if (SuspendComboBoxUpdate) return;
            if (TableDecryptedConnectionString.IsEmpty()) return;

            using (AsynchronousWaitDialog.ShowWaitDialog("Loading...", false))
            {
               tableComboBox.AllowNewText = (tabProviderType == DataProviderType.SqlServer);
               if (tabProviderType == DataProviderType.SqlServer) return;

               DbConnectionInfo connInfo = InstantDbAccess.PrepareDBConnectionInfo(TableDecryptedConnectionString,
                                                                                   TableDataProviderType);
               SeriesDataLayer dl = new SeriesDataLayer(connInfo);

               var currentTable = TableName;
               IList<string> tables = null;

               using (dl.Connect())
               {
                  tables = dl.MetadataDB.GetTables(TableSchemaName);
                  tableComboBox.DataSource = tables;                  
               }

               if (currentTable != null && tables.Contains(currentTable) && !Object.Equals(tableComboBox.SelectedValue, currentTable))
               {
                  tableComboBox.SelectedIndex = tables.IndexOf(currentTable);
               }
               else
               {
                  tableComboBox_SelectedIndexChanged(this, EventArgs.Empty);
               }

               sql_TextChanged(null, null);
            }
         }
         catch (Exception ex)
         {
            MessagesHelper.ReportError(ex, false);
         }
      }

      private void tableComboBox_SelectedIndexChanged(object sender, EventArgs e)
      {
         try
         {
            if (SuspendComboBoxUpdate) return;
            if (TableDecryptedConnectionString.IsEmpty()) return;

            using (AsynchronousWaitDialog.ShowWaitDialog("Loading...", false))
            {
               fieldComboBox.AllowNewText = (tabProviderType == DataProviderType.SqlServer);
               if (tabProviderType == DataProviderType.SqlServer) return;

               DbConnectionInfo connInfo = InstantDbAccess.PrepareDBConnectionInfo(TableDecryptedConnectionString,
                                                                                   TableDataProviderType);
               SeriesDataLayer dl = new SeriesDataLayer(connInfo);

               using (dl.Connect())
               {
                  fieldComboBox.DataSource = dl.MetadataDB.GetFields(TableSchemaName, TableName);
               }

               sql_TextChanged(null, null);
            }
         }
         catch (Exception ex)
         {
            MessagesHelper.ReportError(ex, false);
         }
      }

      private void fieldComboBox_SelectedIndexChanged(object sender, EventArgs e)
      {
         try
         {
            if (SuspendComboBoxUpdate) return;

            sql_TextChanged(null, null);
         }
         catch (Exception ex)
         {
            MessagesHelper.ReportError(ex, false);
         }
      }

      private void seqAccComboBox_SelectedIndexChanged(object sender, EventArgs e)
      {
         try
         {
            if (SuspendComboBoxUpdate) return;
            if (SequenceDecryptedConnectionString.IsEmpty()) return;

            seqSchemaCombobox.AllowNewText = (seqProviderType == DataProviderType.SqlServer);
            if (seqProviderType == DataProviderType.SqlServer) return;

            using (AsynchronousWaitDialog.ShowWaitDialog("Loading...", false))
            {
               DbConnectionInfo connInfo = InstantDbAccess.PrepareDBConnectionInfo(SequenceDecryptedConnectionString,
                                                                                   SequenceDataProviderType);
               SeriesDataLayer dl = new SeriesDataLayer(connInfo);

               var currentSchema = SequenceSchemaName;
               IList<string> schemas = null;

               using (dl.Connect())
               {
                  schemas = dl.MetadataDB.GetSchemas();
                  seqSchemaCombobox.DataSource = dl.MetadataDB.GetSchemas();                        
               }

               if (currentSchema != null && schemas.Contains(currentSchema) && !Equals(seqSchemaCombobox.SelectedValue, currentSchema))
               {                  
                  seqSchemaCombobox.SelectedIndex = schemas.IndexOf(currentSchema);
               }
               else
               {
                  seqSchemaCombobox_SelectedIndexChanged(this, EventArgs.Empty);
               }
            }
         }
         catch (Exception ex)
         {
            MessagesHelper.ReportError(ex, false);
         }
      }

      private void seqSchemaCombobox_SelectedIndexChanged(object sender, EventArgs e)
      {
         try
         {
            if (SuspendComboBoxUpdate) return;
            if (SequenceDecryptedConnectionString.IsEmpty()) return;

            if (seqProviderType == DataProviderType.SqlServer) return;

            using (AsynchronousWaitDialog.ShowWaitDialog("Loading...", false))
            {
               DbConnectionInfo connInfo = InstantDbAccess.PrepareDBConnectionInfo(SequenceDecryptedConnectionString,
                                                                                   SequenceDataProviderType);
               SeriesDataLayer dl = new SeriesDataLayer(connInfo);

               using (dl.Connect())
               {
                  string text = SequenceName; // sequenceComboBox.Text;
                  sequenceComboBox.DataSource = dl.MetadataDB.GetSequences(SequenceSchemaName);
                  if (!text.IsEmpty())
                  {
                     sequenceComboBox.Text = text;
                  }
               }
            }
         }
         catch (Exception ex)
         {
            MessagesHelper.ReportError(ex, false);
         }
      }

      private void DBSettingsDialog_FormClosing(object sender, FormClosingEventArgs e)
      {
         try
         {
            if (DialogResult == System.Windows.Forms.DialogResult.OK)
            {
               if (!ValidateForm())
               {
                  MessagesHelper.ShowError(res.Resources.FormIsNotFilled, "Error");
                  e.Cancel = true;
               }

               if (!sequenceCreated)
               {
                  DialogResult answer =
                     MessagesHelper.ShowQuestion(
                        "You have not try the sequence and it may not exist.\r\nTo check the sequence, choose Cancel and then press Test button.",
                        WizardHelper.FindParentHeaderText(this), MessageBoxButtons.OKCancel);

                  if (answer == DialogResult.Cancel)
                  {
                     e.Cancel = true;
                  }
               }
            }
         }
         catch (Exception ex)
         {
            MessagesHelper.ReportError(ex, false);
         }
      }

      private void sequenceComboBox_SelectedValueChanged(object sender, EventArgs e)
      {
         sequenceCreated = false;
      }

      private void checkBoxUseValidationQuery_CheckedChanged(object sender, EventArgs e)
      {
         EnableValidationQuery(checkBoxUseValidationQuery.Checked);
      }

      #endregion


      #region Events

      /// <summary>
      /// Occurs on sequence test request.
      /// </summary>
      public event EventHandler<TestConnectionEventArgs> TestSequence;

      /// <summary>
      /// Occurs on target table test request.
      /// </summary>
      public event EventHandler<TestConnectionEventArgs> TestTargetTable;

      #endregion


      #region Enums

      public enum Endpoint
      {
         Sequence,
         Table
      }

      #endregion


      


   }

   /// <summary>
   /// Event arguments for TestSequence event.
   /// </summary>
   public class TestConnectionEventArgs : EventArgs
   {
      public TestConnectionEventArgs()
      {
         SequenceServerConnected = false;
         TableServerConnected = false;
         QueryResult = -1;
         SequenceCurrentValue = -1;
      }

      public bool SequenceServerConnected { get; set; }
      public bool TableServerConnected { get; set; }
      public long QueryResult { get; set; }
      public decimal SequenceCurrentValue { get; set; }
   }

}
