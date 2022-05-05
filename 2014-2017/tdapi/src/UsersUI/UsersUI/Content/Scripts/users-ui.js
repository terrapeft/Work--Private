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
    BindColorPicker();
    ApplyCheckboxesStyle();

    refreshTimer = ApplyTimer();
}

function ApplyTimer() {
    try {
        if (window['updateInformersInterval']) {
            return setTimeout(function () { window.location = window.location; }, updateInformersInterval);
        }
    }
    catch (e) {
        var t = e;
    }
}


/* 
	Used on home page to order informers
*/
function OrderInformers(offsetY) {
    var x = 0;

    if ($(".informersContainer").length == 0) return;

    var maxY = offsetY;
    var added50 = false;

    $("div.informer").each(function () {
        if (x + $(this).width() > $(".informersContainer").width()) {
            offsetY += maxY;
            x = 0;

            if (!added50) {
                offsetY += 50;
                added50 = true;
            }
        }

        $(this).css({
            top: offsetY,
            left: x,
            position: "absolute"
        });

        x += $(this).width() + 50;
        maxY = Math.max($(this).height(), maxY);
    });
}

/*
	Binds events for Informers on home page
*/
function BindEvents() {
    $("#applyChangesButton").click(function () {
        $("#editLayoutButton").show();
        $("#applyChangesButton").hide();
        $(".hpCancel").hide();
        $("#rearrangeButton").hide();

        $("div.informer").css("overflow-y", "auto");
        $("div.informer").css("overflow-x", "auto");
        $("div.informer-header").css('cursor', '');

        $("div.informer").each(function () {
            var headerDiv = $(this).find("div.informer-header");
            headerDiv.css('background-color', headerDiv.attr('origHeaderColor'));
            $(this)
				.draggable("destroy")
				.resizable("destroy");
        });

        var informers = [];
        $("div.informer").each(function () {
            var informer = {};

            informer.id = $(this).attr("id");
            informer.top = $(this).css("top");
            informer.left = $(this).css("left");
            informer.width = $(this).css("width");
            informer.height = $(this).css("height");
            informer.zIndex = $(this).css("z-index");

            informers.push(informer);
        });

        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: "/WebMethods/WebService.asmx/UpdateInformers",
            data: JSON.stringify({ informers: informers }),
            dataType: "json",
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert('Error saving informers:' + errorThrown);
            }
        });

        refreshTimer = ApplyTimer();
    });

    $("#rearrangeButton").click(function () {
        var menu = $("#admin-menu");
        OrderInformers(menu.outerHeight() + menu.offset().top);
    });

    $("#editLayoutButton").click(function () {
        if (refreshTimer != null) {
            clearTimeout(refreshTimer);
        }

        $("#editLayoutButton").hide();
        $("#applyChangesButton").show();
        $("#rearrangeButton").show();
        $(".hpCancel").show();

        $("div.informer").css("overflow-y", "hidden");
        $("div.informer").css("overflow-x", "hidden");
        $("div.informer-header").css('cursor', 'move');

        var i = 1;

        $("div.informer").each(function () {
            var headerDiv = $(this).find("div.informer-header");
            headerDiv.attr('origHeaderColor', headerDiv.css('background-color'));
            headerDiv.css('background-color', 'aqua');
            headerDiv.addClass("edit-mode");

            i = Math.max(i, $(this).css('z-index') == 'auto' ? 0 : parseInt($(this).css('z-index')));

            $(this).click(function () {
                $(this).css('z-index', i++);
            });

            //$(".informersContainer").resizable({ grid: 5 });

            $(this)
				.draggable({ handle: "div.informer-header", /*containment: ".informersContainer",*/ grid: [5, 5] })
				.resizable({ /*containment: ".informersContainer",*/ grid: 5 });
        });
    });
}

/*
	Initializes ColorPicker  plugin for textbox.
	Used in ColorPicker field template.
*/
function BindColorPicker() {
    $("input.smallhsvTextBox").ColorPickerSliders({
        size: 'sm',
        placement: 'right',
        swatches: false,
        sliders: false,
        hsvpanel: true,
        preventtouchkeyboardonshow: false
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

/*
	Redirect to login page
*/
function RedirectToLoginPage() {
    window.location.href = '/Login.aspx';
}


/*
    GroupName_Edit.ascx
*/
function DdlShowTextbox() {
    var ddl = $('select[gn-ddl]');
    var text = $('input[gn-text]');
    var selectedValue = ddl.val();
    var isCommand = selectedValue.indexOf('<') === 0 && selectedValue.indexOf('>') === selectedValue.length - 1;

    if (isCommand) {
        text.removeClass('hide');
    } else {
        text.val('');
        text.removeClass('hide');
        text.addClass('hide');
    }
}