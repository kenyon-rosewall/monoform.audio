class Admin::PlaylistsController < AdminController
	before_action :set_page

	def set_page
		@p = 'playlists'
	end

	def index
		@playlists = Playlist.order(name: :asc)
	end

	def edit
		@playlist = Playlist.find(params[:id])
	end

	def create
		if params[:image]
			Playlist.create(
				name: params[:name],
				description: params[:description],
				image: params[:image].read,
				image_type: params[:image].content_type,
				active: true
				)
		else
			Playlist.create(
				name: params[:name],
				description: params[:description],
				active: true
				)
		end

		redirect_to admin_playlists_path
	end

	def update
		playlist = Playlist.find(params[:id])
		if params[:image]
			playlist.update(
				name: params[:name],
				description: params[:description],
				image: params[:image].read,
				image_type: params[:image].content_type
				)
		else
			playlist.update(
				name: params[:name],
				description: params[:description]
				)
		end

		redirect_to admin_playlists_path
	end

	def destroy
		playlist = Playlist.find(params[:id])
		playlist.destroy

		redirect_to admin_playlists_path
	end

	def add_recording
		PlaylistRecording.create(
			playlist_id: params[:playlist_id],
			recording_id: params[:recording_id]
			)

		redirect_to edit_admin_playlist_path(params[:playlist_id])
	end

	def remove_recording
		pr = PlaylistRecording.find_by(playlist_id: params[:playlist_id], recording_id: params[:recording_id])
		pr.destroy

		redirect_to edit_admin_playlist_path(params[:playlist_id])
	end

	def inactivate
		p = Playlist.find(params[:playlist_id])
		p.update(active: false)

		redirect_to admin_playlists_path
	end

	def activate
		p = Playlist.find(params[:playlist_id])
		p.update(active: true)

		redirect_to admin_playlists_path		
	end
end
