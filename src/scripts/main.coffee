$ ->

	width = $("#logo-wrapper").width()
	height = $("#logo-wrapper").height()

	stuck = false

	s = skrollr.init
		scale: 0.5
		constants:
			music: height,
			bio: 2 * height

		forceHeight: false

	$(window).scroll ->
		if s.getScrollTop() > height
			stuck = true
			$('#nav').css
				position: "fixed"
				top: "0px"
				bottom: "80%"
		else if stuck
			$("#nav").css
				position: "absolute"
				top: "80%"
				bottom: "0%"


	$("#music-btn").click ->
		s.animateTo height,
			duration: 1000,
			easing: "cubic"

	$("#bio-btn").click ->
		s.animateTo 2 * height,
			duration: 1000,
			easing: "cubic"

	$.get "https://api.soundcloud.com/users/18472102/tracks.json?client_id=9d1cbd39001e5ab06a56ef60fce34af2", (songs) ->
		
		split = Math.floor songs.length / 2 

		console.log songs

		urls = _.pluck songs, 'artwork_url'
		hdUrls = _.map urls, (str) -> str.replace 'large', 't500x500'

		titles = _.pluck songs, 'title'

		for i in [0..songs.length-1]
			$(".music-row:eq(#{Math.floor i / split})").append $("<div class='song-wrapper' style='background-image:url(#{hdUrls[i]});'></div>")