import './_layout.scss';

$(function () {
    $('.nav-toggle').on('click', function () {
        $('.nav').slideToggle();
    });

    const backToTop = $('#back-to-top');
    const getScrollPercent = function () {
        const availScrollHeight = $(document).height() - $(window).height();
        const scrollHeight = $(document).scrollTop();
        // eslint-disable-next-line no-mixed-operators
        const scrollPercent = `${Math.round(scrollHeight / availScrollHeight * 100)}%`;
        $('.percent').text(scrollPercent);
    };
    if ($(document).scrollTop() > 0) {
        backToTop.addClass('fadeInUpBig');
        getScrollPercent();
    }
    $(window).scroll(function () {
        backToTop.addClass('fadeInUpBig');
        getScrollPercent();
        if ($(document).scrollTop() === 0) {
            backToTop.removeClass('fadeInUpBig').addClass('fadeOutDownBig');
        }
    });
    backToTop.on('click', function () {
        $('html,body').animate({ scrollTop: 0 }, 500);
    });
});
