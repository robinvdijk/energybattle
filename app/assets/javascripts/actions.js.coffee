$ ->
	# Notifications centre
	$('.fa-bell').click (event) ->
		event.preventDefault()
		$('.notifications-center').toggleClass('active')
		
	$('.flash').click (e) ->
		this.remove()
		
	# Progressbar
	$('#progressbar li').each ->
		if $(this).next().hasClass('active')
			$(this).addClass('active')
	 
	 