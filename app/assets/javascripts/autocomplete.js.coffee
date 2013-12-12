jQuery ->
  $(".invite_user").autocomplete
    source: $('.invite_user').data('autocomplete-source')
    select: (event, ui) ->
      event.preventDefault()
      $(this).val ui.item.label
      $('.user_id').val ui.item.value