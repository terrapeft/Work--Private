Sys.Application.add_init(OnAppInit);

function OnAppInit(sender) {
    // rebind javascript event handlers after partial postback
    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(OnEndRequest);
}

/* 
    rebind javascript event handlers after partial postback
*/
function OnEndRequest(sender, args) {
    Init();
}

function Init() {
    EnsureContentSize();
}

$(function () {
    Init();
});

// debounce from underscore.js allows to run resize logic at the end of resizing, which means - only once.
$(window).resize(_.debounce(function () {
    EnsureContentSize();
}, 500));

function EnsureContentSize() {
    var div = $('#gridDiv');
    var parent = $('body');

    //alert("New height - " + (parent.height() - (div.outerHeight() - div.height()) - 101));

    div.width($(window).width() - $('#sidebar').outerWidth() - (div.outerWidth() - div.width()));
    div.height(parent.height() - (div.outerHeight() - div.height()) - 101);
}