class Admin::SongsController < AdminController
	before_action :set_page

	def set_page
		@p = 'songs'
	end

	def index
		@songs = Song.order(release_date: :desc, name: :asc)
	end

	def new
		@todays_date = Date.today.strftime("%Y-%m-%d")
	end

	def create
		s = Song.create(
			name: params[:name],
			description: params[:description],
			release_date: params[:release_date],
			active: true
			)

		redirect_to edit_admin_song_path(s.id)
	end

	def edit
		@song = Song.find(params[:id])
		@composers = Composer.order(name: :asc)
		@publishers = Publisher.order(name: :asc)
	end

	def update
		s = Song.find_by(song_id: params[:song_id])
		s.update(
			name: params[:name],
			description: params[:description],
			release_date: params[:release_date]
			)

		redirect_to edit_admin_song_path(s.id)
	end

	def destroy
		s = Song.find(params[:id])
		s.destroy

		redirect_to admin_songs_path
	end
	
	def add_composer
		SongComposer.create(
			song_id: params[:song_id],
			composer_id: params[:composer_id],
			percentage: params[:percentage]
			)

		redirect_to edit_admin_song_path(params[:song_id])
	end

	def remove_composer
		sc = SongComposer.find(params[:id])
		sc.destroy

		redirect_to edit_admin_song_path(params[:song_id])
	end

	def add_publisher
		SongPublisher.create(
			song_id: params[:song_id],
			publisher_id: params[:publisher_id],
			percentage: params[:percentage]
			)

		redirect_to edit_admin_song_path(params[:song_id])
	end

	def remove_publisher
		sp = SongPublisher.find(params[:id])
		sp.destroy

		redirect_to edit_admin_song_path(params[:song_id])
	end

	def add_recording
		path = ''
		if params[:recording] and (params[:recording].content_type == 'audio/wav' or params[:recording].content_type == 'audio/aiff')
			r = Recording.create(song_id: params[:song_id], name: params[:recording].original_filename.gsub(".wav",""))
			r.write_file(params[:recording])
			r.encode_files
			r.create_images

			# r.update(length: r.get_length)

			path = edit_admin_recording_path(r.id)
		else
			path = edit_admin_song_path(params[:song_id])
		end

		redirect_to path
	end

	def remove_recording
		r = Recording.find(params[:id])
		r.destroy

		redirect_to edit_admin_song_path(params[:song_id])
	end

	def inactivate
		s = Song.find(params[:song_id])
		s.update(active: false)

		redirect_to admin_songs_path
	end

	def activate
		s = Song.find(params[:song_id])
		s.update(active: true)

		redirect_to admin_songs_path		
	end
end
