$.fn.centerInClient = function (a) {
    var b = { forceAbsolute: false, container: window, completeHandler: null };
    $.extend(b, a); return this.each(function (e) {
        var g = $(this); var f = $(b.container); var d = b.container == window; if (b.forceAbsolute) {
            if (d)
            { g.appendTo("body") } else { g.appendTo(f.get(0)) }
        } g.css("position", "absolute");
        var h = d ? 2 : 1.8; var c = (d ? f.width() : f.outerWidth()) / 2 - g.outerWidth() / 2;
        var j = (d ? f.height() : f.outerHeight()) / h - g.outerHeight() / 2; g.css("left", c + f.scrollLeft()); g.css("top", j + f.scrollTop());
        if (b.completeHandler) {
            b.completeHandler(this)
        }
    })
};