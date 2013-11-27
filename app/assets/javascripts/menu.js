$(document).ready(function() {
	$(".blanket").click(function() {
		$(this).toggle();
		$(".st-effect-1.st-menu").css('transform', 'translate3d(-100%, 0, 0)');
	});

	$("#edit-btn").click(function() {
		$(".st-effect-1.st-menu").css('transform', 'translate3d(0, 0, 0)');
		$(".blanket").toggle();
	});
	if($('body.profile-edit').length){
		$(".st-effect-1.st-menu").css('transform', 'translate3d(0, 0, 0)');
		$(".blanket").toggle();
	}
});