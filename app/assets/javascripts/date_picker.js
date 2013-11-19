$(document).ready(function() {
	$(function() {
	  $('.datepicker').datepicker({
			dateFormat: 'dd-mm-yy',
			changeDay: true,
			monthNamesShort: ['Januari', 'Febuari', 'Maart', 'April', 'Mei', 'Juni', 'Julie', 'Augustus', 'September', 'Oktober', 'November', 'December'],
			dayNamesMin: ['Z', 'M', 'D', 'W', 'D', 'V', 'Z'],
			minDate: 0
		});
	});
});


