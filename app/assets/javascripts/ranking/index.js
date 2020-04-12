$('.event').on('click', function () {
  for (var i = 0; i < $('.event').length; i++) {
    $('#rank_show_' + i).removeClass('active');
    $('#rank_area_' + i).addClass('d-none');
  }
  $(this).addClass('active');
  $('#rank_area_' + $(this).data('rank')).removeClass('d-none');
});