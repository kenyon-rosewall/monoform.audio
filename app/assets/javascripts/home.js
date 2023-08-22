$(document).ready(function() {
	if (window.location.pathname == '/cart') {
		$.ajax({
			url: '/api/recording/info',
			data: {recording_ids: $.cookie('song_list')},
			method: 'GET',
			success: function(data) {
				render_songs(data);
			}
		});
	}

	if (window.location.pathname == '/thanks/license_request') {
		if ($.removeCookie('song_list',{path: '/', expires: 7})) {
			
		} else {
			// $.cookie('song_list');
		}
		update_cart();
	}
});

function empty_cart_message() {
	return "You don't have any songs in your cart";
}

function remove_song_from_cart(rid) {
	var song_list = $.cookie('song_list');
	if (song_list != undefined) {
		var index = song_list.indexOf(rid);
		if (index > -1) {
			song_list.splice(index, 1);
			$('#' + rid).remove();
		}
	}

	if (song_list.length == 0) {
		$('.playlist-block-a').append(empty_cart_message());
	}

	$.cookie('song_list', song_list, {path: '/', expires: 7});
	update_cart();
}

function render_songs(data) {
	cart = $('.playlist-block-a');
	if (data.length > 0) {
		for (var i=0; i < data.length; i++) {
			var r = data[i];
			var songitem = $('<li class="song-info"></li>');
			if (r.artist != undefined && r.artist != '') {
				var songartist = $('<div class="artist">By <a href="/music/view_artist/' + r.artist_id + '/' + r.artist_slug + '">' + r.artist + '</a></div>');
			} else {
				songartist = $('<div class="artist">By Unknown</div>');
			}
			var songtitle = $('<div class="title">' + r.full_title + '</div>');
			var songcontainer = $('<ul class="playlist-main-item playlist-song" id="' + r.id + '"></ul>');

			songitem.append(songtitle);
			songitem.append(songartist);
			songcontainer.append(songitem);

			var songdetails = $('<div class="song-info-details"></div>');
			var songduration = $('<li class="duration">' + r.length + '</li>');
			var songlink = $('<li class="link"><a href="/music/song/' + r.real_id + '/' + r.slug + '" title="' + r.full_title + '"><i class="fa fa-link" aria-hidden="true"></i></a></li>');
			var songln = $('<li class="license-now"><input type="button" class="mf-button" onclick="remove_song_from_cart(\'' + r.id + '\');" value="Remove" /></li>');

			songdetails.append(songduration);
			songdetails.append(songlink);
			songdetails.append(songln);
			songdetails.append('<li class="recommended"></li>');

			songcontainer.append(songdetails);

			cart.append(songcontainer);
		}
	} else {
		cart.append(empty_cart_message());
	}
}