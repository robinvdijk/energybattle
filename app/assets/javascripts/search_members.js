jQuery(document).ready(function() {
  $("#user_search input").on('keyup', function (){
    $.get($("#user_search").attr("action"), $("#user_search").serialize(), null, "script");
    return false;
  });
});
