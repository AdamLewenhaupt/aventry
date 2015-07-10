rot = (el, deg) ->
	bbox = el.getBBox()
	"r#{deg},#{bbox.cx},#{bbox.cy}"

setupPlayPause = (el) ->
	paper = Snap el
	play = undefined
	pause = undefined

	Snap.load 'imgs/playbutton.svg', (f) ->

		play = f.select '#play'
		paper.append play

		play.attr
			stroke: "none"

	Snap.load 'imgs/pausebutton.svg', (f) ->

		pause = f.select '#pause'
		paper.append pause

		pause.selectAll('path')
			.attr
				stroke: "none"
				"fill-opacity": "0"

	playFn = ->
		play.attr
			transform: rot(play,0)

		pause.attr
			transform: rot(pause,180)

		play.animate 
			transform: rot(play,180),
			"fill-opacity": '0'
			250

		pause.animate
			transform: rot(pause,360),
			250

		pause.selectAll('path').animate
			"fill-opacity": '1',
			250

	pauseFn = ->
		play.animate 
			transform: rot(play,360),
			"fill-opacity": '1'
			250

		pause.animate
			transform: rot(pause,480),
			250

		pause.selectAll('path').animate
			"fill-opacity": '0',
			250

	resetFn = ->
		play.attr
			transform: rot(play,0)
			'fill-opacity': '1'

		pause.attr
			transform: rot(pause,180)

		pause.selectAll('path').attr
			'fill-opacity': '0'


	obj =
		animatePlay: playFn
		animatePause: pauseFn
		reset: resetFn
	obj


runRotation = (el, radius, revolution, reverse=false) ->
	if reverse
		el.attr { "stroke-dashoffset": "#{2*Math.PI*radius}" }
		el.animate
			"stroke-dashoffset": "0",
			revolution, ->
				runRotation el, radius, revolution, reverse
	else
		el.animate
			"stroke-dashoffset": "#{2*Math.PI*radius}",
			revolution, ->
				el.attr { "stroke-dashoffset": "0" }
				runRotation el, radius, revolution, reverse


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


setupProfile = ->
	paper = Snap "#portrait"
	gray = paper.filter (Snap.filter.grayscale 1)

	image = paper.image "imgs/aventry.png", 50, 50, 400, 400
		.pattern()

	center = 250

	aventry = paper.circle center, center, 150
		.attr
			fill: image

	effect1 = paper.circle center, center, 180
		.attr
			stroke: "#34919C"
			"stroke-width": "5"
			fill: "none"
			"stroke-dasharray": "#{Math.PI * 180} #{Math.PI * 180}"

	effect2 = paper.circle center, center, 200
		.attr
			stroke: "#D5DED7"
			"stroke-width": "5"
			fill: "none"
			"stroke-dasharray": "#{Math.PI * 200} #{Math.PI * 200}"

	effect3 = paper.circle center, center, 220
		.attr
			stroke: "#FFE9AD"
			"stroke-width": "5"
			fill: "none"
			"stroke-dasharray": "#{Math.PI * 220} #{Math.PI * 220}"

	runRotation effect1, 180, 1500
	runRotation effect2, 200, 2000, true
	runRotation effect3, 220, 3000


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
	setupProfile()