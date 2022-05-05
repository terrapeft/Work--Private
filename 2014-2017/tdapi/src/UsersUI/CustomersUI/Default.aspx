<%@ Page Language="C#" MasterPageFile="~/Site.master" CodeBehind="Default.aspx.cs" Inherits="UsersUI._Default" %>

<asp:Content ID="headContent" ContentPlaceHolderID="head" runat="Server">
    <title>Trial Subscription</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="content">
        <div class="row">
            <div class="col-md-7">
                <h3 class="larger-caps">Start your TRADEDATA free trial today</h3>
                <br>
                <div style="font-family: Arial; font-size: 13px;">
                    Take a free trial of TRADEDATA and immerse yourself in the instrument data from over 80,000 contracts on over 110 exchanges and see 
                    why TRADEDATA really is the reference data service of choice for the world’s top financial organisations, exchanges and regulators.<br>
                    <br />
                    During this free trial, you will have access to:<br />
                    <br />
                    <ol>
                        <li>A</li>
                        <li>B</li>
                        <li>C</li>
                        <li>D</li>
                    </ol>
                    <div style="font-size: 12px;">
                        <i>NB: You are under no obligation to purchase when you sign up for a trial</i><br>
                        <br>
                        If you know this is the right service for you, please contact <a href="mailto:sales@euromoneytradedata.com">sales@euromoneytradedata.com</a> who will be happy to help.
                        <br>
                        <br>
                        <br>
                    </div>

                </div>
            </div>
            <div class="col-md-5">
                <h3 class="larger-caps text-hlight">Sign up for free trial</h3>
                <br>
                <div style="margin: 10px 0;">
                    <div class="input-group">
                        <label for="nameTextBox" class="input-group-addon">Name:</label>
                        <input runat="server" type="text" required id="nameTextBox" class="form-control" placeholder="NAME*" />
                    </div>
                    <span class="help-block with-errors"></span>
                    <div class="input-group">
                        <label for="emailTextBox" class="input-group-addon">Email:</label>
                        <input type="email" required runat="server" id="emailTextBox" class="form-control" placeholder="EMAIL*" />
                    </div>
                    <div class="help-block with-errors"></div>
                    <div class="input-group">
                        <label for="phoneTextBox" class="input-group-addon">Phone:</label>
                        <input runat="server" type="tel" id="phoneTextBox" class="form-control" placeholder="PHONE" />
                    </div>
                    <div class="help-block with-errors"></div>
                    <div class="input-group">
                        <label for="companyTextBox" class="input-group-addon">Company:</label>
                        <input type="text" runat="server" id="companyTextBox" class="form-control" placeholder="COMPANY" />
                    </div>
                    <div class="help-block with-errors"></div>
                    <asp:Button runat="server" class="btn btn-default" Text="Submit" OnCommand="OnCommand" />
                </div>

                <div style='margin: 5px 0;' class='alert alert-danger fade in' id="errorMessagePanel" runat="server" visible="False">
                    <a href='#' style='color: black; position: relative; left: 0; top: -4px' class='close' data-dismiss='alert' aria-label='close'>&times;</a>
                    <span runat="server" id="errorMessageText" />
                </div>
                <div style='margin: 5px 0;' class='alert alert-info fade in' id="infoPanel" runat="server" visible="false">
                    <a href='#' style='color: black; position: relative; left: 0; top: -4px' class='close' data-dismiss='alert' aria-label='close'>&times;</a>
                    <span class="" runat="server" id="infoText" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
