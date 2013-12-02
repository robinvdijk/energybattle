$ ->
  $('.fa-bell').click (event) ->
    event.preventDefault()
    $('.notifications-center').toggleClass('active')
