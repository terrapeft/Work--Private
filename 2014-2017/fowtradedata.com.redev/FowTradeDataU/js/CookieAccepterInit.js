function InitCookieAccepterEffect(params) {
    var body = $('body');

    var cookieControls = {
        slidePanel: $('.' + params.slidePanel),
        slideButton: $('.' + params.slideButton),
        slideLink: $('.' + params.slideLink),
        popupPanel: $('.' + params.popupPanel),
        popupButton: $('.' + params.popupButton),
        popupCloseButton: $('.' + params.popupCloseButton),
        grayBody: $('.' + params.grayBody)
    };

    var functions = {
        animateSlidePanel: function () {
            cookieControls.slidePanel.animate({ left: '+=223', duration: 1000 });

            // hide after 2 minutes
            setTimeout(function () {
                cookieControls.slidePanel.animate({ left: '-=223', duration: 1000 });
                cookieControls.slideButton.hide();
                cookieControls.slideLink.hide();
                SetCookie(2);
            }, 120000);
        },

        bindPanelEvents: function () {
            cookieControls.slideLink.click(function () {
                cookieControls.grayBody.css("display", "block");
                cookieControls.grayBody.css({ opacity: 0.5, 'width': $(document).width(), 'height': $(document).height(), 'top': 0, 'left': 0 });
                cookieControls.popupPanel.fadeIn("slow");
                body.css({ 'overflow': 'hidden' });
                functions.repositionPanels();
            });

            cookieControls.slideButton.click(function () {
                cookieControls.slideButton.hide();
                cookieControls.slideLink.hide();
                cookieControls.popupButton.click();
            });
        },

        bindPopupCloseButton: function () {
            cookieControls.popupCloseButton.click(function () {
                cookieControls.popupPanel.fadeOut("slow");
                cookieControls.grayBody.fadeOut("slow", function () {
                    body.css({ 'overflow': '' });
                });
            });
        },

        repositionPanels: function () {
            cookieControls.popupPanel.centerInClient();
            cookieControls.grayBody.css({ 'width': $(document).width(), 'height': $(document).height() });
        },

        cutCookieAccepterIntoPieces: function () {
            var cookieAccepterHeight = cookieControls.slidePanel.height();
            var pieceHeight = 10;
            var additionalWidth = 18;
            for (var position = 0; position < cookieAccepterHeight; position += pieceHeight) {
                var $cookieAccepterPiece = $('<div/>');
                $cookieAccepterPiece.addClass('cookieAccepterSliderPiece');
                $cookieAccepterPiece.width(position + additionalWidth);
                $cookieAccepterPiece.css('top', position);
                $cookieAccepterPiece.css('background-position', '0px -' + position + 'px');
                cookieControls.slidePanel.append($cookieAccepterPiece);
            }

            cookieControls.slidePanel.css('background', 'none');
            cookieControls.slidePanel.width(0);
        }
    };

    // call all functions
    functions.cutCookieAccepterIntoPieces(); // fix a bug, where transparent part covers content
    functions.animateSlidePanel();
    functions.bindPanelEvents();
    functions.bindPopupCloseButton();
    functions.repositionPanels();

    // bind resize event
    $(window).resize(function () {
        functions.repositionPanels();
    });

}

// set cookie
function SetCookie(months) {
    var expires = "";
    if (months) {
        expires = "; expires=" + addMonths(months).toGMTString();
    }

    document.cookie = "CookiesAccepted=" + expires + "; path=/";
}

// check cookie
function GetCookie(name) {
    var mas = document.cookie.match(name + "=[^;]*");

    if (mas) {
        var cook = mas[0].split(/=/);
        return decodeURIComponent(cook[1]);
    };

    return null;
}

// add months to current date
function addMonths(numberMonths) {
    var date = new Date();
    var day = date.getDate(); // returns day of the month number

    // avoid date calculation errors
    date.setHours(20);

    // add months and set date to last day of the correct month
    date.setMonth(date.getMonth() + numberMonths + 1, 0);

    // set day number to min of either the original one or last day of month
    date.setDate(Math.min(day, date.getDate()));

    return date;
}
