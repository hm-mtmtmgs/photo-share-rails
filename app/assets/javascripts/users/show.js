let element = 'input[name="options"]';

$(element).on('change', function () {
	$(element).each(function (index) {
		$('#area_' + index).addClass('d-none');
		if($(element).eq(index).prop('checked')) {
			$('#area_' + index).toggleClass('d-none');
		}
	});
});
