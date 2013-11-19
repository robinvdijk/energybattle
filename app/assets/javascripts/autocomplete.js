$(document).ready(function() {
	$(function() {
		$("#search").autocomplete({
			source: "/users.json"
		});
	});
});
