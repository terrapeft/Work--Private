namespace WindowsService
{
   partial class ProjectInstaller
   {
      /// <summary>
      /// Required designer variable.
      /// </summary>
      private System.ComponentModel.IContainer components = null;

      /// <summary> 
      /// Clean up any resources being used.
      /// </summary>
      /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
      protected override void Dispose(bool disposing)
      {
         if (disposing && (components != null))
         {
            components.Dispose();
         }
         base.Dispose(disposing);
      }

      #region Component Designer generated code

      /// <summary>
      /// Required method for Designer support - do not modify
      /// the contents of this method with the code editor.
      /// </summary>
      private void InitializeComponent()
      {
         this.BslsWinServiceProcessInstaller = new System.ServiceProcess.ServiceProcessInstaller();
         this.BslsWinServiceInstaller = new System.ServiceProcess.ServiceInstaller();
         // 
         // BslsWinServiceProcessInstaller
         // 
         this.BslsWinServiceProcessInstaller.Account = System.ServiceProcess.ServiceAccount.NetworkService;
         this.BslsWinServiceProcessInstaller.Password = null;
         this.BslsWinServiceProcessInstaller.Username = null;
         // 
         // BslsWinServiceInstaller
         // 
         this.BslsWinServiceInstaller.Description = "The WCF Service for BSLS.";
         this.BslsWinServiceInstaller.DisplayName = "Jnj.3d.BslsService";
         this.BslsWinServiceInstaller.ServiceName = "Jnj.3d.BslsService";
         this.BslsWinServiceInstaller.StartType = System.ServiceProcess.ServiceStartMode.Automatic;
         // 
         // ProjectInstaller
         // 
         this.Installers.AddRange(new System.Configuration.Install.Installer[] {
            this.BslsWinServiceProcessInstaller,
            this.BslsWinServiceInstaller});

      }

      #endregion

      private System.ServiceProcess.ServiceProcessInstaller BslsWinServiceProcessInstaller;
      private System.ServiceProcess.ServiceInstaller BslsWinServiceInstaller;
   }
}