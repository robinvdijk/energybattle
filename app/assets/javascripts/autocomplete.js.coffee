jQuery ->
  $(".invite_user").autocomplete
    source: $('.invite_user').data('autocomplete-source')
    changed: (event , ui) ->
      console.log(ui.item)
      $('.ui-menu-item').prepend("<img class='ui-menu-item-avatar avatar'></img>")
      $( ".ui-menu-item-avatar" ).attr( "src", ui.item.icon )
    select: (event, ui) ->
      event.preventDefault()
      $(this).val ui.item.label
      $('.user_id').val ui.item.value