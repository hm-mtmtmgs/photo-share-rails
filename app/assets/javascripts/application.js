//= require jquery
//= require rails-ujs
//= require popper
//= require bootstrap-sprockets

//= require users/show
//= require users/edit
//= require posts/create
//= require home/index

$(document).ready(function() {
  $(window).load(function() {
    window.setTimeout("$('#alert').fadeOut()", 2500);
  });
});

$(function () {
    var topBtn = $('#page-top');
    topBtn.hide();
    $(window).scroll(function () {
        if ($(this).scrollTop() > 500) {
            topBtn.fadeIn();
        } else {
            topBtn.fadeOut();
        }
    });
    topBtn.click(function () {
        $('body,html').animate({
            scrollTop: 0
        }, 500);
        return false;
    });
});