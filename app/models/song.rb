class Song < ActiveRecord::Base
	has_many :song_composers
	has_many :composers, :through => :song_composers
	has_many :song_publishers
	has_many :publishers, :through => :song_publishers
	has_many :recordings
	validates :name, :presence => true
	before_create :assign_song_id
	before_destroy :delete_recordings

	def self.search(q)
		vars = {}
		where_clause = '1=1 '

		if q.has_key?(:query)
			vars[:term] = "%" + q[:query].downcase + "%"
			where_clause += 'AND (LOWER(recordings.name) like :term '
			where_clause += 'OR LOWER(recordings.description) like :term '
			where_clause += 'OR LOWER(composers.name) like :term '
			where_clause += 'OR LOWER(songs.name) like :term '
			where_clause += 'OR LOWER(recording_tags.tag) like :term) '
		end
		if q.has_key?(:playlist)
			vars[:playlist_id] = q[:playlist].to_i
			where_clause += 'AND playlists.id = :playlist_id '
		end
		if q.has_key?(:artist)
			vars[:artist_id] = q[:artist]
			where_clause += 'AND artists.id = :artist_id '
		end
		if q.has_key?(:composer)
			vars[:composer_id] = q[:composer].to_i
			where_clause += 'AND composers.id = :composer_id '
		end
		if q.has_key?(:library)
			vars[:library_id] = q[:library].to_i
			where_clause += 'AND libraries.id = :library_id '
		end
		if q.has_key?(:mood)
			vars[:mood] = q[:mood].to_a
			where_clause += 'AND LOWER(recording_tags.tag) IN (:mood) '
		end
		if q.has_key?(:genre)
			vars[:genre] = Genre.where(name: q[:genre].to_a).collect{|g| g.id }
			where_clause += 'AND recording_genres.genre_id IN (:genre) '
		end
		vars[:active] = true
		where_clause += 'AND songs.active = :active'

		recordings = Recording.includes(:song, :composers, :recording_tags, :playlists, :artists, :libraries, :recording_genres)
			.where(where_clause, vars)
			.uniq
			.order('songs.release_date DESC, songs.name ASC')

		# if q["term"]
		# 	params = {};
		# 	params[:term] = "%" + q["term"].downcase + "%"
		# 	params[:active] = true
		# 	where_clause = '(LOWER(recordings.name) like :term '
		# 	where_clause += 'OR LOWER(recordings.description) like :term '
		# 	where_clause += 'OR LOWER(composers.name) like :term '
		# 	where_clause += 'OR LOWER(songs.name) like :term '
		# 	where_clause += 'OR LOWER(recording_tags.tag) like :term) '
		# 	if q["playlist"].to_i > 0
		# 		params[:playlist_id] = q["playlist"].to_i
		# 		where_clause += 'AND playlists.id = :playlist_id '
		# 	end
		# 	if q["artist"].to_i > 0
		# 		params[:artist_id] = q["artist"].to_i
		# 		where_clause += 'AND artists.id = :artist_id '
		# 	end
		# 	if q["composer"].to_i > 0
		# 		params[:composer_id] = q["composer"].to_i
		# 		where_clause += 'AND composers.id = :composer_id '
		# 	end
		# 	if q["library"].to_i > 0
		# 		params[:library_id] = q["library"].to_i
		# 		where_clause += 'AND libraries.id = :library_id '
		# 	end
		# 	where_clause += 'AND songs.active = :active'

		# 	Recording.includes(:song, :composers, :recording_tags, :playlists, :artists, :libraries, :genres)
		# 		.where(where_clause, params)
		# 		.uniq
		# 		.order('songs.release_date DESC, songs.name ASC')
		# else
		# 	Recording.includes(:song)
		# 		.where('songs.active = :active', active: true)
		# 		.order('songs.release_date DESC, songs.name ASC')
		# end
	end

	def self.recommended_songs(artist_id, playlist_id)
		if artist_id.to_i > 0
			recordings = Recording.includes(:song, :artists)
				.where('songs.active = :active AND recordings.recommended = :recommended AND artists.id = :artist_id', active: true, recommended: true, artist_id: artist_id)
				.order('songs.release_date DESC, songs.name ASC')

		end

		if playlist_id.to_i > 0
			recordings = Recording.includes(:song, :playlists)
				.where('songs.active = :active AND recordings.recommended = :recommended AND playlists.id = :playlist_id', active: true, recommended: true, playlist_id: playlist_id)
				.order('songs.release_date DESC, songs.name ASC')
		end

		if artist_id.to_i == 0 and playlist_id.to_i == 0
			recordings = Recording.includes(:song)
				.where('songs.active = :active and recordings.recommended = :recommended', active: true, recommended: true)
				.order('songs.release_date DESC, songs.name ASC')
		end

		recordings
	end

	def self.new_songs(artist_id, playlist_id)
		if artist_id.to_i > 0
			recordings = Recording.includes(:song, :artists)
				.where('songs.active = :active AND artists.id = :artist_id', active: true, artist_id: artist_id)
				.limit(7)
				.order('songs.release_date DESC, songs.created_at DESC, songs.name ASC')
		end

		if playlist_id.to_i > 0
			recordings = Recording.includes(:song, :playlists)
				.where('songs.active = :active AND playlists.id = :playlist_id', active: true, playlist_id: playlist_id)
				.limit(7)
				.order('songs.release_date DESC, songs.created_at DESC, songs.name ASC')
		end

		if artist_id.to_i == 0 and playlist_id.to_i == 0
			recordings = Recording.includes(:song)
				.where('songs.active = :active', active: true)
				.limit(7)
				.order('songs.release_date DESC, songs.created_at DESC, songs.name ASC')
		end

		recordings
	end

	def assign_song_id
		self.song_id = new_song_id
	end

	def first_recording_id
		self.recordings.first.recording_id
	end

	def list_composers
		if self.composers
			comps = self.song_composers.sort_by { |c| [-c.percentage] }
			comps.collect{|c| c.composer.name }.join(', ')
		else
			""
		end
	end

	def delete_recordings
		self.recordings.each do |r|
			r.destroy
		end
	end

private
	def new_song_id
		begin
			songid = rand(36**8).to_s(36)
		end while Song.find_by(song_id: songid)

		songid
	end

	def slug
		name.parameterize
	end
end
