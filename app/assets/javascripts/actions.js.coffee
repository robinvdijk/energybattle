$ ->
  $('.fa-bell').click (event) ->
    event.preventDefault()
    $('.notifications-center').toggleClass('active')
  # $('.fa-bars').click (event) ->
  #   $('.menu').toggleClass('active')
