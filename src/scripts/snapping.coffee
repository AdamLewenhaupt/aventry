setupTitle = ->
	paper = Snap "#logo"

	image = paper.image("imgs/logo-background.jpg", 0, 0, 1200, 400)
		.attr
			opacity: 0

	logoPattern = image.pattern(0,0,1200,400)

	paper.append logoPattern

	Snap.load "imgs/logo-c.svg", (f) ->

		logo = f.select '#logo'
		paper.append logo

		bbox = logo.getBBox()

		logo.attr
			fill: "none",
			stroke: "#fff",
			"stroke-width": 2,
			"stroke-dasharray": "150 75"
			
		logo.animate
			"stroke-dasharray": "1200 400",
			3000

		setTimeout ->
			$btns = $('.nav-btn').removeClass 'hidden',
			2000


spinAndFill = (el, filler) ->

	el.attr
		fill: filler

	if el.inAnim().length == 0

		bbox = el.getBBox()

		cx = bbox.cx
		cy = bbox.cy

		el.transform "r0,#{cx},#{cy}"
		el.animate
			transform:"r360,#{cx},#{cy}"
			1000, mina.bounce


setupIcons = ->
	soundcloud = Snap "#soundcloud-icon"

	Snap.load "imgs/soundcloud-icon.svg", (f) ->
		icon = f.select '#icon'
		soundcloud.append icon

		$('.icon-wrapper:has(#soundcloud-icon)').hover (-> spinAndFill icon, "r()#ff7024-#FF5510"), -> icon.attr {fill: "#000"}

	spotify = Snap "#spotify-icon"

	Snap.load "imgs/spotify-icon.svg", (f) ->
		icon = f.select '#icon'
		spotify.append icon

		$('.icon-wrapper:has(#spotify-icon)').hover (-> spinAndFill icon, "r()#95f205-#7DC211"), -> icon.attr {fill: "#000"}

	fb = Snap '#fb-icon'

	Snap.load "imgs/facebook-icon.svg", (f) ->
		icon = f.select '#icon'
		fb.append icon

		$('.icon-wrapper:has(#fb-icon)').hover (-> spinAndFill icon, "#3C5A99"), -> icon.attr {fill: "#000"}

$ ->
	setupTitle()

	setupIcons()