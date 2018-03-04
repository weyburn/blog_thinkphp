(function ($) {
    function AllChecked(checkElement, allCheckElement) {
        this.checkElement = checkElement;
        this.allCheckElement = allCheckElement;
        this._init();
    }

    AllChecked.prototype = {
        _init: function () {
            // eslint-disable-next-line prefer-destructuring
            const checkElement = this.checkElement;
            // eslint-disable-next-line prefer-destructuring
            const allCheckElement = this.allCheckElement;

            checkElement.on('click', function () {
                if (checkElement.filter(':checked').length === checkElement.length) {
                    allCheckElement.prop('checked', true);
                } else {
                    allCheckElement.prop('checked', false);
                }
            });

            allCheckElement.on('click', function () {
                if (allCheckElement.prop('checked')) {
                    checkElement.prop('checked', true);
                } else {
                    checkElement.prop('checked', false);
                }
            });
        },
    };

    $.extend({
        allChecked: function (checkElement, allCheckElement) {
            // eslint-disable-next-line no-new
            new AllChecked(checkElement, allCheckElement);
        },
    });
}(jQuery));
