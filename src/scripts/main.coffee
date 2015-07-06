$ ->

	width = $("#logo-wrapper").width()
	height = $("#logo-wrapper").height()

	stuck = false

	s = skrollr.init
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
			duration: 500

	$("#bio-btn").click ->
		s.animateTo 2 * height,
			duration: 500