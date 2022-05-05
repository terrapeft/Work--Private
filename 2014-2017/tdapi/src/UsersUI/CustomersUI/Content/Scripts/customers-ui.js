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
    /* -- restore search options panels */
    $('#searchOptionsPanel .collapse-trigger').each(function () {
        var t = $(this).attr('data-target');
        var cookie = getCookie('soptr' + t);
        if (cookie !== undefined && cookie != null) {
            $(this).attr('class', 'collapse-trigger ' + cookie);
        }
    });

    $('#searchOptionsPanel .panel-collapse').each(function () {
        var t = $(this).attr('id');
        var cookie = getCookie('soppn#' + t);
        if (cookie !== undefined && cookie != null) {
            $(this).attr('class', 'panel-collapse collapse ' + cookie);
        }
    });

    $('div .panel-collapse').on('hidden.bs.collapse', function () {
        setCookie('soptr#' + $(this).attr("id"), 'collapsed');
        setCookie('soppn#' + $(this).attr("id"), '');
    });

    $('div .panel-collapse').on('shown.bs.collapse', function () {
        setCookie('soptr#' + $(this).attr("id"), '');
        setCookie('soppn#' + $(this).attr("id"), 'in');
    });

    /* -- end of search options panels */

    // search - export - switch data format options
    $(document).on("change", "input[format-selector]", function () {
        if ($('input[csv-checkbox]').is(':checked')) {
            $("#csvOptions input").each(function () {
                $(this).removeAttr('disabled', 'disabled');
            });
        } else {
            $("#csvOptions input").each(function () {
                $(this).attr('disabled', 'disabled');
            });
        }
    });

    // collapse search results
    $('div[collapse-all]').click(function () {
        $('#resultsPanel .panel-collapse').collapse('hide');
    });

    // expand search results
    $('div[expand-all]').click(function () {
        $('#resultsPanel .panel-collapse').collapse('show');
    });

    // collapse search options
    $('div[collapse-all-opt]').click(function () {
        $('#searchOptionsPanel .panel-collapse').collapse('hide');
    });

    // expand search options
    $('div[expand-all-opt]').click(function () {
        $('#searchOptionsPanel .panel-collapse').collapse('show');
    });

    // Select/Deselect checkbox handler
    $('#deselectCheckBox').click(function () {
        var table = $('table[search-list]');
        $('td input:checkbox', table).prop('checked', this.checked);
    });

    // Set up autocomplete
    patchAutocomplete();

    $("input[search-box]").autocomplete({
        source: function (request, response) {
            var searchParams = {
                s: $('input[search-box]').val(),
                fl: {
                    "ExchangeCode": takeSelectItems('exchange-code', ':selected'),
                    "ContractType": takeSelectItems('contract-type', ':selected')
                },
                sc: takeSearchColumns(),
                vc: takeSelectItems('visible-columns'),
                so: takeSearchOption()
            };
            $.ajax({
                url: "/WebMethods/CustomerService.asmx/FindSuggestions",
                data: '{ searchParams: \'' + JSON.stringify(searchParams) + '\'}',
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataFilter: function (data) { return data; },
                success: function (data) {
                    response($.map(data.d, function (item) {
                        return {
                            value: item
                        };
                    }));
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert('Error:' + errorThrown);
                }
            });
        },
        minLength: 2
    });
}

/*
	Redirect to login page
*/
function RedirectToLoginPage() {
    window.location.href = '/Login.aspx';
}


/* 
    Gather parameters for suggestions 
*/
function takeSearchColumns() {
    var table = $('table[search-list]');
    var selected = [];
    $('td input:checked', table).each(function () {
        selected.push($(this).val());
    });

    return selected;
}

/* 
    Gather parameters for suggestions 
*/
function takeSelectItems(id, modifier) {
    modifier = modifier === undefined ? '' : modifier;

    var table = $('select[' + id + ']');
    var items = [];

    $('option' + modifier, table).each(function () {
        items.push($(this).val());
    });

    return items;
}

/* 
    Gather parameters for suggestions 
*/
function takeSearchOption() {
    var table = $('table[search-options-list]');
    var val = $('td input:checked', table).val();
    return val === undefined ? 4 : val;
}


function patchAutocomplete() {
    $.ui.autocomplete.prototype._renderItem = function (ul, item) {
        var re = new RegExp("(" + this.term + ")", "gi"),
			 template = "<span class='search-highlight'>$1</span>",
			 label = item.label.replace(re, template),
			 $li = $("<li/>").appendTo(ul);

        $("<a/>").attr("href", "#")
					  .html(label)
					  .appendTo($li);

        return $li;
    };
}

function scrollToElement(el) {
    $('html,body').animate({
        scrollTop: $(el).offset().top
    }, 1000);
}

function setCookie(key, value) {
    var expires = new Date();
    expires.setTime(expires.getTime() + 31536000000); //1 year  
    document.cookie = key + '=' + value + ';expires=' + expires.toUTCString();
}

function getCookie(key) {
    var keyValue = document.cookie.match('(^|;) ?' + key + '=([^;]*)(;|$)');
    return keyValue ? keyValue[2] : null;
}


/*
    My Account pager
*/
function SimplePager() {
    this.requestsPerPage = 3;
    this.currentPage = 1;

    this.showPage = function (page) {
        var html = '';

        this.paragraphs.slice((page - 1) * this.requestsPerPage,
            ((page - 1) * this.requestsPerPage) + this.requestsPerPage).each(function () {
                html += '<div>' + $(this).html() + '</div>';
            });

        $("#page-content").html(html);
    }
}