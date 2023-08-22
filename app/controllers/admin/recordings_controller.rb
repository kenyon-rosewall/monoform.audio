class Admin::RecordingsController < AdminController
	before_action :set_page

	def set_page
		@p = 'recordings'
	end

	def index
		@recordings = Recording.joins(:song).order("songs.name asc")
	end

	def edit
		@recording = Recording.find(params[:id])
		@licenses = License.where(active: true).order(name: :asc)
		@libraries = Library.where(active: true).order(name: :asc)
		@artists = Artist.order(name: :asc)
		@genres = Genre.order(name: :asc)

		@meta = @recording.metadata
	end

	def update
		r = Recording.find_by(recording_id: params[:recording_id])
		r.update(
			name: params[:name],
			description: params[:description],
			bpm: params[:bpm],
			length: params[:length],
			license_id: params[:license_id],
			recommended: params[:recommended],
			old_id: params[:old_id]
			)

		if params[:image]
			r.update(
				image: params[:image].read,
				image_type: params[:image].content_type
				)
		end

		redirect_to edit_admin_recording_path(r.id)
	end

	def destroy
		r = Recording.find(params[:id])
		r.destroy

		redirect_to admin_recordings_path
	end

	def add_artist
		RecordingArtist.create(
			recording_id: params[:recording_id],
			artist_id: params[:artist_id],
			primary: params[:primary]
			) if RecordingArtist.find_by(recording_id: params[:recording_id], artist_id: params[:artist_id]) == nil

		redirect_to edit_admin_recording_path(params[:recording_id])
	end

	def remove_artist
		ra = RecordingArtist.find(params[:id])
		ra.destroy

		redirect_to edit_admin_recording_path(params[:recording_id])
	end

	def add_library
		RecordingLibrary.create(
			recording_id: params[:recording_id],
			library_id: params[:library_id]
			) if RecordingLibrary.find_by(recording_id: params[:recording_id], library_id: params[:library_id]) == nil

		redirect_to edit_admin_recording_path(params[:recording_id])
	end

	def remove_library
		rl = RecordingLibrary.find(params[:id])
		rl.destroy

		redirect_to edit_admin_recording_path(params[:recording_id])
	end

	def add_genre
		RecordingGenre.create(
			recording_id: params[:recording_id],
			genre_id: params[:genre_id]
			) if RecordingGenre.find_by(recording_id: params[:recording_id], genre_id: params[:genre_id]) == nil

		redirect_to edit_admin_recording_path(params[:recording_id])
	end

	def remove_genre
		rg = RecordingGenre.find(params[:id])
		rg.destroy

		redirect_to edit_admin_recording_path(params[:recording_id])
	end

	def add_tag
		tags = params[:tag].split
		tags.each do |t|
			RecordingTag.create(
				recording_id: params[:recording_id],
				tag: t
				) if RecordingTag.find_by(recording_id: params[:recording_id], tag: t) == nil
		end

		redirect_to edit_admin_recording_path(params[:recording_id])
	end

	def remove_tag
		rt = RecordingTag.find(params[:id])
		rt.destroy

		redirect_to edit_admin_recording_path(params[:recording_id])
	end

	def reencode_files
		r = Recording.find(params[:recording_id])
		r.encode_files
		r.create_images

		redirect_to edit_admin_recording_path(params[:recording_id])
	end
end
