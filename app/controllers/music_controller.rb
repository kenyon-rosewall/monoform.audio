class MusicController < ApplicationController
	include ApplicationHelper
	before_action :set_genres

	def set_genres
		@genres = Genre.order(:name)
		@moods = ['Atmospheric', 'Bright', 'Brooding', 'Calm', 'Carefree', 'Dark', 'Delicate', 'Dramatic', 'Energetic', 'Epic', 'Fun', 'Gloomy', 'Happy', 'Introspective', 'Ironic', 'Mellow', 'Mysterious', 'Ominous', 'Plaintive', 'Powerful', 'Sad', 'Scary', 'Somber', 'Tense', 'Uplifting', 'Warm']
	end

	def index
		
	end

	# def creative_commons
	# 	@library = Library.find_by(name: 'Creative Commons')
	# 	render :index
	# end

	def commercial_music
		@library = Library.find_by(name: 'Commercial Music')
		render :index
	end

	def song
		@recording = Recording.find(params[:id])
	end

	def post_comment
		err = ''
		payload = {
			"secret" => ENV['RECAPTCHA_SECRET'],
			"response" => params["g-recaptcha-response"],
			"remoteip" => request.remote_ip
		}
		response = post_data(ENV['RECAPTCHA_URL'], payload)

		if response["success"] == true
			Comment.create(
				recording_id: params[:id],
				name: params[:name],
				comment: params[:comment]
				)
		else
			if response["error-codes"].include? 'missing-input-response'
				err += "Missing reCaptcha input <br>"
			end
		end

		r = Recording.find(params[:id])

		if err != ''
			flash[:error] = err
		end

		redirect_to action: "song", id: r.id, slug: r.slug
	end

	def legacy_song
		r = Recording.find_by(old_id: params[:old_id])

		redirect_to action: "song", id: r.id, slug: r.slug
	end

	def download
		@file = ''
		if params[:recording_id]
			r = Recording.find_by(recording_id: params[:recording_id])
			@file = r.watermarked_path
		end
	end

	def artists
		@artists = Artist.where(active: true).order(name: :asc)
	end

	def view_artist
		@artist = Artist.find(params[:artist_id])
	end

	def playlists
		@playlists = Playlist.where(active: true).order(name: :asc)
	end

	def view_playlist
		@playlist = Playlist.find(params[:playlist_id])
	end

	def get_player_json(r)
		r.collect{ |r| "title: '" + r.song.name + "',id: '" + r.recording_id + "',src: '" + r.watermarked_path + "'" }
	end
end
