<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SalesForceForm.aspx.cs" Inherits="FowTradeDataU.umbraco.CustomWebForms.SalesForceForm" %>

<%@ Import Namespace="FowTradeDataU.umbraco.CustomWebForms" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SalesForce Form</title>
    <!-- Bootstrap core CSS -->
    <link href='http://fonts.googleapis.com/css?family=Ubuntu:400,500,700' rel='stylesheet' type='text/css' />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap-theme.min.css" />

    <link href="/css/fonts-icons.css" rel="stylesheet" />
    <link href="/css/carousel.css" rel="stylesheet" />
    <link type="text/css" href="/css/styles.css" rel="stylesheet" />
    <link type="text/css" href="/css/style.css" rel="stylesheet" />
    <script src="/js/jquery.min.js"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.14.0/jquery.validate.min.js"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.14.0/additional-methods.min.js"></script>
    <script type="text/javascript" src="/js/iframe/iframeResizer.contentWindow.min.js"></script>
</head>
<body>
    <form data-toggle="validator" runat="server" id="salesForceForm" enctype="multipart/form-data">
        <input type="hidden" name="orgid" value="<%=AppSettings.SalesForce_Form_OrgId_Value %>" />
        <input type="hidden" id="<%=AppSettings.SalesForce_Form_Field1_Name %>" name="<%=AppSettings.SalesForce_Form_Field1_Name %>" value="1" />
        <input type="hidden" id="<%=AppSettings.SalesForce_Form_CaseRecordType_Name%>" name="<%=AppSettings.SalesForce_Form_CaseRecordType_Name%>" value="Euromoney TRADEDATA" />
        <input type="hidden" id="<%=AppSettings.SalesForce_Form_AttachmentId_Name%>" name="<%=AppSettings.SalesForce_Form_AttachmentId_Name%>" />

        <%-- ---------------------------------------------------------------------- -->
        <!-- NOTE: These fields are optional debugging elements. Please uncomment -->
        <!-- these lines if you wish to test in debug mode. -->
        <!-- <input type="hidden" name="debug" value=1> -->
        <!-- <input type="hidden" name="debugEmail" -->
        <!-- value="maciej.bartyzel@outbox.pl"> -->
        <!-- ---------------------------------------------------------------------- --%>

        <div style="width: 400px;" id="supportForm" runat="server">
            <div class="form-group">
                <label for="name" class="control-label"><%=SiteConfig.SF_Form_Name %></label>
                <input id="name" maxlength="80" name="name" type="text" class="form-control input-sm" required value="<%=CurrentUserName %>" readonly />
                <div class="help-block with-errors"></div>
            </div>

            <div class="form-group">
                <label for="email" class="control-label"><%=SiteConfig.SF_Form_Email %></label>
                <input id="email" maxlength="80" type="email" name="email" type="text" class="form-control input-sm" required value="<%=CurrentUserEmail %>" />
                <div class="help-block with-errors"></div>
            </div>

            <div class="form-group">
                <label for="subject" class="control-label"><%=SiteConfig.SF_Form_Subject%></label>
                <input id="subject" reset maxlength="80" name="subject" size="20" type="text" class="form-control input-sm" required runat="server" />
                <div class="help-block with-errors"></div>
            </div>

            <div class="form-group">
                <label for="type" class="control-label"><%=SiteConfig.SF_Form_Query_Type %></label>
                <select name="type" id="type" size="1" class="form-control input-sm" style="margin-bottom: 25px;" required>
                    <option value="" selected="selected"></option>
                </select>

                <label id="subcategory1Label" for="<%=AppSettings.SalesForce_Subcategory1_Name %>" class="control-label" style="display: none;"><%=SiteConfig.SF_Form_Query_Type_2 %></label>
                <select
                    name="<%=AppSettings.SalesForce_Subcategory1_Name %>"
                    id="<%=AppSettings.SalesForce_Subcategory1_Name %>"
                    size="1" class="form-control input-sm" style="margin-bottom: 25px; display: none;" required>
                    <option value="" selected="selected"></option>
                </select>

                <label id="subcategory2Label" for="<%=AppSettings.SalesForce_Subcategory2_Name %>" class="control-label" style="display: none;"><%=SiteConfig.SF_Form_Query_Type_3 %></label>
                <select
                    name="<%=AppSettings.SalesForce_Subcategory2_Name %>"
                    id="<%=AppSettings.SalesForce_Subcategory2_Name %>"
                    size="1" class="form-control input-sm" style="display: none;" required>
                    <option value="" selected="selected"></option>
                </select>
                <div class="help-block with-errors"></div>
            </div>

            <div class="form-group">
                <label for="description" class="control-label"><%=SiteConfig.SF_Form_Description %></label>
                <textarea id="description" reset name="description" class="form-control input-sm" style="height: 180px" required></textarea>
                <div class="help-block with-errors"></div>
            </div>

            <div class="form-group">
                <label for="priority" class="control-label"><%=SiteConfig.SF_Form_Priority %></label>
                <select id="priority" reset name="priority" class="form-control input-sm" required runat="server">
                </select>
                <div class="help-block with-errors"></div>
            </div>

            <div class="form-group" id="impactDiv">
                <label for="<%=AppSettings.SalesForce_Impact_Name %>" class="control-label"><%=SiteConfig.SF_Form_Impact %></label>
                <select runat="server" reset id="impact" class="form-control input-sm" required runat="server">
                </select>
                <div class="help-block with-errors"></div>
            </div>

            <label for="attachments"><%=SiteConfig.SF_Form_Attachments %></label>
            <div class="input-group" runat="server" id="fileInput">
                <span class="input-group-btn">
                    <span class="btn btn-sm btn-default btn-file">Browse&hellip;
                       
                        <input type="file" id="attachments" name="attachments" multiple size="10">
                    </span>
                </span>
                <input type="text" class="form-control input-sm" readonly>
            </div>
            <div class="has-error" style="position: relative; top: -5px" runat="server" id="fileError" visible="False">
                <div class="help-block with-errors">
                    <ul class="list-unstyled">
                        <li><%=SiteConfig.SF_Form_Attachments_Error %></li>
                    </ul>
                </div>
            </div>
            <br>
            <input type="submit" id="submitButton" name="submitButton" runat="server" class="btn btn-primary btn-sm" />
            <br>
        </div>

        <script>
            var dataArray = <%= QueryTypesJson%>

            $(function () {

                $('#salesForceForm').validate({
                    rules: {
                        description: {
                            pattern: /^[\*-\w\s\.,=&\\\/:;+\(\)\[\]\{\}\%\$\#\@\!\?\~\"\']+$/
                        }
                    }
                });

                /***** Cascading drop-down lists *****/
                var qtDdl = $("#type"),
                    sc1Label = $("#subcategory1Label"),
                    sc1Ddl = $("#<%=AppSettings.SalesForce_Subcategory1_Name %>"),
                    sc2Ddl = $("#<%=AppSettings.SalesForce_Subcategory2_Name %>"),
                    sc2Label = $("#subcategory2Label"),
                    impactDdl = $("#<%=AppSettings.SalesForce_Impact_Name %>"),
                    impactDiv = $("#impactDiv");

                $.each(dataArray, function (data) {
                    AddOption(qtDdl, data);
                });

                qtDdl.change(function () {
                    sc1Ddl.find("option:not([value=''])").each(function () { $(this).remove(); });
                    sc2Ddl.find("option:not([value=''])").each(function () { $(this).remove(); });

                    DisableInput(sc1Ddl, true);
                    DisableInput(sc1Label, true);
                    DisableInput(sc2Label, true);
                    DisableInput(sc2Ddl, true);

                    if (qtDdl[0].selectedIndex < 1) {
                        DisableInput(sc1Ddl, true);
                        DisableInput(sc1Label, true);
                    } else {
                        var hasOptions = false;
                        var key = qtDdl.find("option:selected").text() + '=' + qtDdl.val();

                        $.each(dataArray[key], function (data) {
                            hasOptions = true;
                            AddOption(sc1Ddl, data);
                        });

                        if (hasOptions === true) {
                            DisableInput(sc1Ddl, false);
                            DisableInput(sc1Label, false);
                        }
                    }

                    if (qtDdl.val() === '<%=AppSettings.SalesForce_Form_HideImpact_Value %>') {
                        DisableInput(impactDdl, true);
                        impactDiv.hide();
                    } else {
                        DisableInput(impactDdl, false);
                        impactDiv.show();
                    }
                });


                sc1Ddl.change(function () {
                    sc2Ddl.find("option:not([value=''])").each(function () { $(this).remove(); });

                    if (sc1Ddl[0].selectedIndex < 1) {
                        DisableInput(sc2Ddl, true);
                        DisableInput(sc2Label, true);
                        return;
                    }

                    var key1 = qtDdl.find("option:selected").text() + '=' + qtDdl.val();
                    var key2 = sc1Ddl.find("option:selected").text() + '=' + sc1Ddl.val();

                    var level3Data = dataArray[key1][key2];

                    if (level3Data.length > 0) {
                        DisableInput(sc2Ddl, false);
                        DisableInput(sc2Label, false);

                        $.each(level3Data, function (id, data) {
                            AddOption(sc2Ddl, data);
                        });
                    }
                });

                /***** Attachments *****/
                $('.btn-file :file').on('fileselect', function (event, numFiles, label) {

                    var input = $(this).parents('.input-group').find(':text'),
                        log = numFiles > 1 ? numFiles + ' files selected' : label;

                    if (input.length) {
                        input.val(log);
                    } else {
                        if (log) alert(log);
                    }
                });
            });

            /*
                Say user, that request has been submitted 
            */
            function SwitchPanels(status, injectText) {
                ClearInput();
                parent.HideRequestForm();

                if (status === 'Success') {
                    parent.SwitchSubmitMessage('#infoDiv', injectText, true);
                }
                else if (status === "Error") {
                    parent.SwitchSubmitMessage('#errorDiv', injectText, true);
                }
            }

            function ClearInput() {
                $("input[reset]").val('');
                $("select[reset]").val('');
            }

            function DisableInput(elem, hide) {
                if (hide) {
                    elem.prop('disabled', true);
                    elem.hide();
                } else {
                    elem.prop('disabled', false);
                    elem.show();
                }
            }

            function AddOption(ddl, keyValuePair) {
                var text = keyValuePair.split('=')[0];
                var value = keyValuePair.split('=')[1];
                ddl.append($('<option>', { value: value, text: text }));
            }


            /***** Bootstrap-like style for file select *****/
            $(document).on('change', '.btn-file :file', function () {
                var input = $(this),
                    numFiles = input.get(0).files ? input.get(0).files.length : 1,
                    label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
                input.trigger('fileselect', [numFiles, label]);
            });

        </script>
    </form>
</body>
</html>
