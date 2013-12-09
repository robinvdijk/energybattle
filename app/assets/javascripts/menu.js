$(document).ready(function() {
  $(".blanket").click(function() {
    $(this).toggle();
    $(".st-effect-1.st-menu").css('transform', 'translate3d(141%, 0, 0)');
  });
  $("#menu").click(function() {
    $(".st-effect-1.st-menu").css('transform', 'translate3d(41%, 0, 0)');
    $(".st-effect-1.st-menu").css('display', 'block');
    $(".blanket").toggle();
  });
  if($('body.profile-edit').length){
    $(".st-effect-1.st-menu").css('transform', 'translate3d(0, 0, 0)');
    $(".blanket").toggle();
  }
});