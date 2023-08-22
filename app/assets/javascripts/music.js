/* Remove Selected Filtered When Clicked */
$(document).ready(function($) {
	window.player = $('#current_track').get(0);
	current_index = 0;
	$('.filter-choice').click(function(){
		$(this).hide();
	});
});

$(document).ready(function() {
	$('.main').addClass('player-main');
	load_songs('',true);

	$('.close_btn').click(function(e) {
		e.preventDefault();
		$('.alert').slideUp(400);
	});
});

function init() {
	// Event listener for track progress
	$('#progressTrack').on('mousedown', function(event) {
		if (window.player.duration) {
			var x = event.pageX - this.offsetLeft;
			var width = 250;
			var percentage = x / width;
			var current_time = window.player.duration * percentage;

			window.player.currentTime = current_time;
		}
	});

	// Event listener for volume progress
	$('#progressVolume').on('click', function(event) {
		var x = event.pageX - this.offsetLeft;
		var width = $('#progressVolume').width();
		var percentage = x / width;

		window.player.volume = percentage;
		$('#progressVolume').attr('value', percentage);
	});

	// Event listener for mute
	$('#volume-button').on('click', function(event) {
		if (window.player.volume > 0) {
			window.player.volume = 0;
			$('#progressVolume').attr('value', 0);
			$('#volume-button').addClass('fa-volume-off').removeClass('fa-volume-up');
		} else {
			window.player.volume = 0.75;
			$('#progressVolume').attr('value', 0.75);
			$('#volume-button').addClass('fa-volume-up').removeClass('fa-volume-off');
		}
		
	});

	// Event listener for search
	$('#query').keyup(function (e) {
		if (e.which == 13) {
			load_songs();
		}

		if ($('#query').val() == '') {
			load_songs();
		}
	});

	// Event listener for recommended filter 
	$('#recommended-filter').on('click', function(event) {
		$('.filter-bank').html('');
		$.ajax({
			url: '/api/search/recommended_songs',
			data: { 'artist': $('#artist_id').val(), 'playlist': $('#playlist_id').val() },
			success: function(data) {
				render_songs(data);
			}
		});
	});

	// Event listener for new filter
	$('#new-filter').on('click', function(event) {
		$('.filter-bank').html('');
		$.ajax({
			url: '/api/search/new_songs',
			data: { 'artist': $('#artist_id').val(), 'playlist': $('#playlist_id').val() },
			success: function(data) {
				render_songs(data);
			}
		});
	});

	window.player.volume = 0.75;
	$('#progressVolume').attr('value', 0.75);

	window.player.addEventListener("timeupdate", update_time);
	window.player.addEventListener("ended", update_song);
}

// After loading songs, send the first song to the transport
function queue_first_song(play = true) {
	first_song = $('.playlist-block-a .playlist-main-item .song-info').get(0);
	if (first_song && window.player.paused)
		play_song(first_song, play);
}

function composer_query(q) {
	$('#composer').val(q);
	load_songs();
}

function set_query(q) {
	$('#query').val(q);
	load_songs();
}

function load_songs(params = '', init_bool = false) {
	var url = '/api/search/songs/';
	var query_data = {};
	query_data["mood"] = [];
	query_data["genre"] = [];

	if ($('#query').val() != '' && $('#query').val() != undefined) {
		//url += $('#query').val();
		query_data["query"] = $('#query').val();
	}
	if ($('#playlist_id').val() != '' && $('#playlist_id').val() != undefined) {
		//url += '^playlist=' + $('#playlist_id').val();
		query_data["playlist"] = $('#playlist_id').val();
	}
	if ($('#artist_id').val() != '' && $('#artist_id').val() != undefined) {
		//url += '^artist=' + $('#artist_id').val();
		query_data["artist"] = $('#artist_id').val();
	}
	if ($('#library_id').val() != '' && $('#library_id').val() != undefined) {
		//url += '^library=' + $('#library_id').val();
		query_data["library"] = $('#library_id').val();
	}
	if ($('#composer').val() != '' && $('#composer').val() != undefined) {
		query_data["composer"] = $('#composer').val();
	}
	$.each($('input[name=mood]'), function(i,mood) {
		query_data["mood"].push($(mood).val());
	});
	$.each($('input[name=genre]'), function(i,genre) {
		query_data["genre"].push($(genre).val());
	});

	$.ajax({
		url: url,
		data: query_data,
		dataType: "json",
		method: "GET",
		success: function(data) {
			render_songs(data);
			if (init_bool) {
				init();
			}
		}
	});
}

// Render function that takes songs json and makes it HTML
function render_songs(songs) {
	$('.playlist-block-a').html('');
	if (songs.songs.length > 0) {
		//$('#music_player').append('<div class="playlist-block-a"></div>');
		playlist = $('.playlist-block-a');
		$.each(songs.songs, function(song_i,song) {
			first_recording = song.recordings[0];

			accordion = '';
			if (song.recordings.length > 1) {
				accordion = ' accordion-toggle';
				songitem = $('<li class="song-info accordion-toggle" onclick="play_song(this)" data-id="' + first_recording.recording_id + '" data-index="' + song_i + '"></li>');
				songartist = $('<div class="artist"><div class="view-all">View All Versions <i class="fa fa-caret-down" aria-hidden="true"></i></div></div>');
			} else {
				songitem = $('<li class="song-info" onclick="play_song(this)" data-id="' + first_recording.recording_id + '" data-index="' + song_i + '" data-recording="0"></li>')
				if (first_recording.artists[0])
					songartist = $('<div class="artist">By <a href="/music/view_artist/' + first_recording.artists[0].id + '/' + first_recording.artists[0].slug + '">' + first_recording.artists[0].name + '</a></div>');
				else
					songartist = $('<div class="artist">By Unknown</div>');
			}
			songtitle = $('<div class="title">' + song.title + '</div>');
			songcontainer = $('<ul class="playlist-main-item playlist-song"></ul>');

			songitem.append(songtitle);
			songitem.append(songartist);
			songcontainer.append(songitem);

			songdetails = $('<div class="song-info-details"></div>');
			songduration = $('<li class="duration">' + first_recording.length + '</li>');
			songbpm = $('<li class="bpm">' + first_recording.bpm + '</li>');
			songgenre = $('<li class="genre">' + first_recording.genres + '</li>');
			songrecommended = $('<li class="recommended"></li>');
			if (first_recording.recommended)
				songrecommended.append('<i class="fa fa-star" aria-hidden="true"></i>');
			else
				songrecommended.append('<i class="fa fa-star" aria-hidden="true" style="visibility:hidden;"></i>');
			songlink = $('<li class="link"><a href="/music/song/' + first_recording.id + '/' + first_recording.slug + '" title="' + first_recording.title + '"><i class="fa fa-link" aria-hidden="true"></i></a></li>');
			songln = $('<li class="license-now"><input type="button" class="mf-button" onclick="add_song_to_cart(\'' + first_recording.recording_id + '\', \'' + song.title + '\');" value="License Now" /></li>');
			
			songdetails.append(songgenre);
			songdetails.append(songbpm);
			songdetails.append(songln);
			songdetails.append(songrecommended);
			songdetails.append(songlink);
			songdetails.append(songduration);

			songcontainer.append(songdetails);

			if (song.recordings.length > 1) {
				recordingwrapper = $('<li class="dropdown-playlist accordion-content"></li>');
				$.each(song.recordings, function(recording_i, recording) {
					recordingcontainer = $('<ul class="playlist-main-item playlist-recording"></ul>');
					recordingitem = $('<li class="song-info" onclick="play_song(this)" data-id="' + recording.recording_id + '" data-index="' + song_i + '" data-recording="' + recording_i + '"></li>');
					recordingtitle = $('<div class="title">' + recording.title + '</div>');
					/* Account for multiple artists */
					if (recording.artists[0]) {
						recordingartist = $('<div class="artist">By <a href="/music/view_artist/' + recording.artists[0].id + '/' + recording.artists[0].slug + '">' + recording.artists[0].name + '</a></div>');
					} else {
						recordingartist = $('<div class="artist">By Unknown</div>');	
					}
					recordingitem.append(recordingtitle);
					recordingitem.append(recordingartist);

					recordingdetails = $('<div class="song-info-details"></div>');
					recordingduration = $('<li class="duration">' + recording.length + '</li>');
					recordingbpm = $('<li class="bpm">' + recording.bpm + '</li>');
					recordinggenre = $('<li class="genre">' + recording.genres + '</li>');
					recordingrecommended = $('<li class="recommended"></li>');
					if (recording.recommended)
						recordingrecommended.append('<i class="fa fa-star" aria-hidden="true"></i>');
					else
						recordingrecommended.append('<i class="fa fa-star" aria-hidden="true" style="visibility:hidden;"></i>');
					recordinglink = $('<li class="link"><a href="/music/song/' + recording.id + '/' + recording.slug + '" title="' + recording.title + '"><i class="fa fa-link" aria-hidden="true"></i></a></li>');
					recordingln = $('<li class="license-now"><input type="button" class="mf-button" onclick="add_song_to_cart(\'' + recording.recording_id + '\', \'' + recording.title + '\');" value="License Now" /></li>');
					
					recordingdetails.append(recordinggenre);
					recordingdetails.append(recordingbpm);
					recordingdetails.append(recordingln);
					recordingdetails.append(recordingrecommended);					
					recordingdetails.append(recordinglink);
					recordingdetails.append(recordingduration);

					recordingcontainer.append(recordingitem);
					recordingcontainer.append(recordingdetails);

					recordingwrapper.append(recordingcontainer);
				});

				songcontainer.append(recordingwrapper);
			}

			playlist.append(songcontainer);
		});
		
		update_toggles();
		queue_first_song(false);
	} else {
		$('.playlist-block-a').append('<p class="notice">No results</p>');
	}
}

// Make dynamic HTML still do javascript things
function update_toggles() {
	$('.playlist-main-item .accordion-toggle').click(function(){
	    //Expand or collapse this panel
		open_versions(this);
	  });
	var $dropdown = $('div.dropdownWrapper'),
	      $drpBtn   = $dropdown.find('div.dropdownLabel');

	  $drpBtn.on('click', function(e){
	    e.stopPropagation();
	    var $element = $(this).parent();
	    $element.find('.dropdownPanel').fadeToggle(200);
	  });

	  $("body").click(function(){
	    $('.dropdownPanel').hide(200);
	  });
}

function close_versions() {
	$('.playlist-main-item').removeClass('open');
    $('.playlist-main-item').find('.accordion-content').hide();
}

function open_versions(el) {
	close_versions();

    $(el).closest('.playlist-main-item').find('.accordion-content').show();
    $(el).closest('.playlist-main-item').addClass('open');
    $(el).addClass('open');
}

// Play or pause track
function tm_toggle() {
	if (window.player.paused) {
		$('#toggle').removeClass('fa-play');
		$('#toggle').addClass('fa-pause');
		window.player.play();
	} else {
		$('#toggle').removeClass('fa-pause');
		$('#toggle').addClass('fa-play');
		window.player.pause();
	}
}

// Play previous track in playlist
function tm_prev() {
	if (parseInt(current_index) == 0) {
		current_index = 0;
	} else {
		current_index = parseInt(current_index) - 1;
	}

	prev_song = $('.playlist-song > .song-info').get(current_index);
	if ($(prev_song).hasClass('accordion-toggle')) {
		open_versions(prev_song);
	} else {
		close_versions();
	}

	play_song(prev_song);
}

// Play next track in playlist
function tm_next() {
	len = parseInt($('.playlist-song').length) - 1;
	if (current_index >= len) {
		current_index = len;
	} else {
		current_index = parseInt(current_index) + 1;
	}

	next_song = $('.playlist-song > .song-info').get(current_index);
	if ($(next_song).hasClass('accordion-toggle')) {
		open_versions(next_song);
	} else {
		close_versions();
	}
	play_song(next_song);
}

// Automatically play next song in playlist when track finishes
function update_song() {
	len = parseInt($('.playlist-song').length) - 1;
	if (current_index >= len) {
		current_index = 0;
	} else {
		current_index = parseInt(current_index) + 1;
	}

	next_song = $('.playlist-song > .song-info').get(current_index);
	if ($(next_song).hasClass('accordion-toggle')) {
		open_versions(next_song);
	} else {
		close_versions();
	}

	play_song(next_song);
}

// When clicked in playlist, play song
function play_song(el, play = true, refresh_display = true) {
	current_index = el.dataset.index;
	id = el.dataset.id;
	recording_index = el.dataset.recording;
	if (recording_index == undefined) {
		recording_index = 0;
	}

	window.player.pause();

	$.ajax({
		url: "/api/recording/" + id,
		success: function(data) {
			window.player.src = data.src;
			$('.track-info .song').text(data.full_title);
			if (data.artist != undefined) {
				$('.track-info .artist a').text(data.artist);
				$('.track-info .artist a').prop('href', '/music/view_artist/' + data.artist_id + '/' + data.artist_slug)
			} else {
				$('.track-info .artist a').text('Unknown');
				$('.track-info .artist a').prop('href', '');
			}
			$('#waveform').attr('src',data.waveform);
			$('#download').attr('href','/music/download/' + data.id);
			$('ul').removeClass('active');
			$('.song-info[data-index=' + current_index + '][data-recording=' + recording_index + ']').closest('.playlist-main-item').addClass('active');
			if (recording_index == 0)
				$(el).closest('.playlist-main-item').find('.playlist-recording:first').addClass('active');

			if (play) {
				tm_toggle();
			} else {
				$('#toggle').removeClass('fa-pause');
				$('#toggle').addClass('fa-play');
			}
		}
	});
}

// Update the progress time on transport
function update_time() {
	if (window.player.duration) {
		var dur_minutes = str_pad_left(Math.floor(window.player.duration / 60));
		var dur_seconds = str_pad_left(Math.floor(window.player.duration - dur_minutes * 60));
	} else {
		var dur_minutes = '--';
		var dur_seconds = '--';
	}

	if (window.player.currentTime) {
		var minutes = str_pad_left(Math.floor(window.player.currentTime / 60));
		var seconds = str_pad_left(Math.floor(window.player.currentTime - minutes * 60));
	} else {
		var minutes = '--';
		var seconds = '--';
	}

	$('#time').text(minutes + ":" + seconds);
	$('#duration').text(dur_minutes + ":" + dur_seconds);
	$('#progressTrack').attr('value', window.player.currentTime / window.player.duration);
}

function str_pad_left(num) {
	if (num < 10)
		return '0' + num;
	else
		return num;
}

function add_song_to_cart(rid, title) {
	var song_list = $.cookie('song_list');
	if (song_list != undefined) {
		for (var i=0; i < song_list.length; i++) {
			if (song_list[i] == rid) {
				return;
			}
		}
		song_list.push(rid);
	} else {
		song_list = [rid];
	}

	$.cookie('song_list', song_list, {path:'/', expires: 7});
	update_cart();

	$('.alert').hide();
	$('#alert_song_title').text(title);
	$('.alert').slideDown(400).delay(2000).slideUp(400);
}

