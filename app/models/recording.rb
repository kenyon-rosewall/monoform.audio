class Recording < ActiveRecord::Base
	include Admin::FfmpegHelper
	has_many :recording_artists
	has_many :artists, :through => :recording_artists
	has_many :recording_genres
	has_many :genres, :through => :recording_genres
	has_many :recording_libraries
	has_many :libraries, :through => :recording_libraries
	belongs_to :license
	has_many :playlist_recordings
	has_many :playlists, :through => :playlist_recordings
	has_many :recording_tags
	belongs_to :song
	has_many :song_composers, :through => :song
	has_many :composers, :through => :song_composers
	has_many :song_publishers, :through => :song
	has_many :publishers, :through => :song_publishers
	has_many :comments
	before_create :assign_recording_id
	before_destroy :delete_files

	def self.active_recordings
		Recording.joins(:song)
			.where("songs.active = ?", true)
			.order(name: :asc)
	end

	def base_path
		"./public"
	end

	def get_image_tag
		if self.image
			encoded_image = Base64.encode64(self.image)
			"<img src='data:#{self.image_type};base64,#{encoded_image}' alt='Artist (#{self.name}) image' />"
		end
	end

	def primary_artist
		rel = RecordingArtist.find_by(primary: true, recording_id: id)

		rel.artist
	end

	# def creative_commons?
	# 	cc = License.find_by(name: 'Creative Commons')

	# 	self.license_id == cc.id
	# end

	def list_genres
		self.recording_genres.collect { |g| g.genre.name }.join(', ')
	end

	def list_tags
		self.recording_tags.collect { |t| "<span class='tag'>#{t.tag}</span>" }.join(' ')
	end

	def list_artists
		self.recording_artists.collect { |a| a.artist.name }.join(', ')
	end

	def list_libraries
		self.recording_libraries.collect { |l| l.library.name }.join(', ')
	end

	def list_composers
		self.song.song_composers.collect { |c| c.composer.name + ' - ' + c.percentage.to_s + '%'}.join('<br />')
	end

	def list_publishers
		self.song.song_publishers.collect { |p| p.publisher.name + ' - ' + p.percentage.to_s + '%' }.join('<br />')
	end

	def display_bpm
		if self.bpm.to_s != ""
			self.bpm.to_s + " BPM"
		else
			""
		end
	end

	def watermarked_path(full = false)
		mp3 = "/files/#{self.recording_id}/#{self.watermark_name}.mp3"

		if full
			mp3 = "#{Rails.root.to_s}/public#{mp3}"
		end

		mp3
	end

	def wav_path(full = false)
		if self.filepath
			wav = self.filepath
			if full
				wav = Rails.root.to_s + "/public" + wav
			end

			wav
		else
			""
		end
	end

	def waveform_path(full = false)
		png = "/files/" + self.recording_id + "/" + self.recording_id + ".png"
		if full
			png = Rails.root.to_s + "/public" + png
		end

		png
	end

	def assign_recording_id
		self.recording_id = new_recording_id
		self.wav_name = new_recording_id
		self.watermark_name = new_recording_id
	end

	def write_file(uploaded_file)
		dir = base_path + "/files/" + self.recording_id + "/"
		FileUtils.mkdir_p(dir)
		filepath = dir + self.wav_name + File.extname(uploaded_file.original_filename)
		File.open(filepath, 'wb') do |file|
			file.write(uploaded_file.read)
		end

		if File.exist? filepath
			self.filepath = filepath.gsub(base_path,"")
			self.save
		end
	end

	def encode_files
		input = wav_path(true)
		# mp3_output = mp3_path(true)
		watermarked_output = watermarked_path(true)

		# encode_mp3(input, mp3_output)
		create_watermarked(input, watermarked_output)
	end

	def create_images
		input = wav_path(true)
		png_output = waveform_path(true)
		create_waveform(input, png_output)
	end

	def get_length
		input = wav_path(true)
		duration = get_duration(input)
		Time.at(duration.to_i).utc.strftime("%M:%S")
	end

	def metadata
		input = wav_path(true)
		puts get_metadata(input)
	end

	def delete_files
		folder = "./public/files/" + self.recording_id
		if self.filepath
			if File.directory? folder
				FileUtils.rm_r(folder)
			end
		end
	end

	def self.search(term)
		joins(:song).where('LOWER(recordings.name) like :term OR LOWER(songs.name) like :term', term: "%#{term.downcase}%")
	end

	def slug
		full_title.parameterize
	end

	def full_title
		if name == 'Main' or name == song.name or name == ''
			song.name
		else
			song.name + ' (' + name + ')'
		end
	end

private
	def new_recording_id
		begin
			recordingid = rand(36**8).to_s(36)
		end while Recording.find_by(recording_id: recordingid)

		recordingid
	end
end
