$(document).ready(function() {
	  $('input.datepicker').datepicker({
			dateFormat: 'dd-mm-yy',
			changeDay: true,
			monthNames: ['Januari', 'Febuari', 'Maart', 'April', 'Mei', 'Juni', 'Juli', 'Augustus', 'September', 'Oktober', 'November', 'December'],
			dayNamesMin: ['Z', 'M', 'D', 'W', 'D', 'V', 'Z'],
			minDate: 0
	});
});


