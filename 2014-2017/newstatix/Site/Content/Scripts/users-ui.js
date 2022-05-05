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

$(window).resize(function () {
    HideOptions();
});

$(window).load(function () {
    InitializeAfterAsyncCall();
});

function InitializeAfterAsyncCall() {
    // RadGrid column filters size
    $('input.rgFilterBox').attr('size', '5');

    HideOptions();
    SetBackButton();
    ApplyCheckboxesStyle();
    SetUpDiaryCalendar();

    IFrameProgressListener();

    var dlg = $("[popup]");
    var iframe = $("[popup-iframe]");
    var progress = $("[iframe-progress]");

    $("[datepicker]").datepicker({
        showOtherMonths: true,
        selectOtherMonths: true,
        showButtonPanel: true,
        dateFormat: 'yy/mm/dd',
        numberOfMonths: 3,
        changeMonth: true,
        changeYear: true
    });

    dlg.dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        width: "auto",
        height: "auto",
        buttons: {
            Ok: function () {
                $(this).dialog("close");
            }
        },
        open: function () {
            var okBtn = $('.ui-dialog-buttonset').find('button:contains("Ok")');
            okBtn.removeAttr('class').addClass('btn btn-primary');
            okBtn.css({ width: '80px', height: '25px', 'padding': '0' });
            okBtn.text('OK');
            //okBtn.blur();
        },
        close: function () {
            iframe.attr("src", "");
        }
    });

    $("[popup-href]").on("click", function (e) {
        e.preventDefault();
        progress.show();

        iframe.attr({
            style: "width: 100%; height: 100%; border: 0;",
            src: $(this).attr("href")
        });

        dlg.dialog("option", "width", $(this).attr("width"));
        dlg.dialog("option", "height", $(this).attr("height"));
        dlg.dialog("option", "title", $(this).attr("title"));
        dlg.dialog("open");
    });

}

function SetBackButton() {
    var btn = $("[history-button]");
    if (window.location.pathname.indexOf('/view/') > -1)
        btn.show();
    else
        btn.hide();

    btn.click(function() {
        window.history.back();
    });
}

function IFrameProgressListener() {
    window.addEventListener("message", function (e) {
        $("[iframe-progress]").hide();
    });
}

function HideOptions() {
    var minWidthWithFilters = 1333;
    var minWidthNoFilters = 840;

    var width = $('.rgFilterBox').length ? minWidthWithFilters : minWidthNoFilters;

    var optionsDiv = $('[options]');

    //var metka = $('[metka]');
    //metka.text($(window).width());

    if ($(window).width() <= width) {
        optionsDiv.hide();
    } else {
        optionsDiv.show();
    }
}

function SetUpDiaryCalendar() {
    var goToTodayOrig = $.datepicker._gotoToday;
    $.datepicker._gotoToday = function (id) {
        goToTodayOrig.call(this, id);
        this._selectDate(id);
    }
}

/*
	Checkboxes
*/
function ApplyCheckboxesStyle() {
    $(function () {
        $("#format").buttonset();
    });

}

function OnDateSelecting(sender, args) {
    if (args._renderDay.IsSelected) {
        args.set_cancel(true);
    }
}