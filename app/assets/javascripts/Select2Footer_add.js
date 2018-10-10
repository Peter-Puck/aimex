// 1) Add call to Select2Footer_add to edit/new .js.erb
// 2) Add "select2-add" to class of Select2 dropdowns in which you want to include the "+" button
// 3) Add database code to handle adding values before saving record.

function Select2Footer_add(sNotFound, imgPath) {
    var aDropdowns = document.getElementsByClassName('select2-add');

    for (var i = 0; i < aDropdowns.length; i++) {
        var aDropdown = aDropdowns[i];
        var id = 'select#' + aDropdown.id;
        
        $(id).select2({
            formatNoMatches: function (term) {
                var callerId = 'select#' + $(this).attr('id');
                var Result = sNotFound + ' ';
                if (term.trim() != '') Result += '<img src="' + imgPath + '" onclick="addOption(\'' + callerId + '\',\'' + term + '\')" />';

                return Result;
            }
        });
    }
}

function addOption(id, term) {
    $(id).append('<option value=' + cleanId(term) + '>' + term + '</option>');
    $(id).select2('data', { id: cleanId(term), text: term });
    $(id).select2('close');
}

function cleanId(term) {
    if (isInt(term)) term = 'New:' + term;
    return encodeURI(term);
}

function isInt(value) {
    return !isNaN(value) && (function(x) { return (x | 0) === x; })(parseFloat(value))
}