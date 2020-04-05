//= require jquery
//= require rails-ujs
//= require popper
//= require bootstrap-sprockets

//= require users/show
//= require users/edit
//= require posts/add

$(document).ready(function() {
  $(window).load(function() {
    window.setTimeout("$('#alert').fadeOut()", 2500);
  });
});