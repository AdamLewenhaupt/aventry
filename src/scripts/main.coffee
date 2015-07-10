$ ->
	width = $(document).width()
	height = $(document).height()

	stuck = false

	s = skrollr.init
		constants:
			music: height
			bio: 2 * height
			end: 3 * height

	$("#music-btn").click ->
		s.animateTo height,
			duration: 1000,
			easing: "cubic"

	$("#bio-btn").click ->
		s.animateTo 2 * height,
			duration: 1000,
			easing: "cubic"

	$.get "https://api.soundcloud.com/users/18472102/tracks.json?client_id=9d1cbd39001e5ab06a56ef60fce34af2", (songs) ->

		console.log songs
		
		split = Math.floor songs.length / 2 

		urls = _.pluck songs, 'artwork_url'
		hdUrls = _.map urls, (str) -> str.replace 'large', 't500x500'

		titles = _.pluck songs, 'title'
		cleanTitles = _.map titles, (title) -> title.replace(/\(.+\)/, "").replace(/\[.+\]/, "").replace(/^.+-/, "")

		uris = _.pluck songs, 'uri'
		cleanUris = _.map uris, (uri) -> uri.replace /^.*\.com/, ""

		for i in [0..songs.length-1]

			$wrapper = $("<div class='song-wrapper' style='background-image:url(#{hdUrls[i]});'><p>#{cleanTitles[i]}</p></div>")
			$play = $("<div class='song-play' src='imgs/play.png' alt='play'><svg viewBox='0 0 50 50'></svg></div>")


			uri = cleanUris[i]

			$play.attr "uri", uri
			$play[0].anim = setupPlayPause $play.children("svg")[0]

			$play.click ->

				$parent = $(this).parent()

				$('.song-wrapper').each ->

					if not $(this).is $parent

						$(this).removeClass 'playing'
							.children('.song-play').each ->
								if this.song != undefined
									this.song.stop()
									this.anim.reset()


				obj = this
				if this.song == undefined
					SC.stream $(obj).attr("uri"), (song) ->
						obj.song = song
						song.play()
						window.song = song
						$parent.addClass 'playing'
						obj.anim.animatePlay()
				else
					state = this.song.getState()

					if state == "playing"
						$parent.removeClass "playing"
						this.song.pause()
						obj.anim.animatePause()

					else if state == "paused" or state == "seeking"
						$parent.addClass "playing"
						this.song.play()
						obj.anim.animatePlay()


			$wrapper.append $play

			$(".music-row:eq(#{Math.floor i / split})").append $wrapper