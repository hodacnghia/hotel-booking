$(document).ready(function () {
    $('.hamburger').on('click', function (e) {
        e.preventDefault();
        $(this).toggleClass('opned');
        $('header nav').toggleClass('active');
    });
    $('#advanced_search_btn').on("click", function (e) {
        e.preventDefault();
        var ads_box = $('.advanced_search');
        if (!ads_box.hasClass('advanced_displayed')) {
            $(this).addClass('active');
            ads_box.stop().fadeIn(200).addClass('advanced_displayed');
        } else {
            $(this).removeClass('active');
            ads_box.stop().fadeOut(200).removeClass('advanced_displayed');
        }
    });
});
