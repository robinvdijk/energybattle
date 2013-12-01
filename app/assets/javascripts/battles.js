$(document).ready(function() {
  // Zorgt dat als er geen join button is de box aansluit op de members
  if ($("form").hasClass("new_team_relation")) {
    $('.teams-header').css("padding-bottom","6em");
    $('.primary-button').css("margin-left","1em");
  }
});
