var refreshTimer = null;

Sys.Application.add_init(OnAppInit);

function OnAppInit(sender) {
    // rebind javascript event handlers after partial postback
    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(OnEndRequest);
}

/* 
	rebind javascript event handlers after partial postback
*/
function OnEndRequest(sender, args) {
    InitializeAfterAsyncCall();
}

$(window).load(function () {
    InitializeAfterAsyncCall();
});

function InitializeAfterAsyncCall() {
    BindEvents();
    ApplyCheckboxesStyle();
}

/*
	Binds events for Informers on home page
*/
function BindEvents() {

    // ip expand
    $("button[expand-cidr-button]").click(function (e) {
        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: "/WebMethods/WebService.asmx/VerifyAndExpandIps",
            data: JSON.stringify({ list: $("[ip-range-textbox]").val(), ignoreInvalidValues: $("[ignore-bad-ips]").is(":checked") }),
            dataType: "json",
            success: function (json) {
                $("[ip-range-textbox]").val(json.d);
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert('Error:' + errorThrown);
            }
        });

        e.preventDefault();
    });

    //upload
    $(document).on('change', '.btn-file :file', function () {
        $(this).trigger('fileselect', $(this).val());
    });

    $(document).ready(function () {
        $('.btn-file :file').on('fileselect', function (event, file) {
            $("[upload-file]").val(file);
        });
    });
}

/*
	Checkboxes
*/
function ApplyCheckboxesStyle() {
    $(function () {
        $("#format").buttonset();
    });

}