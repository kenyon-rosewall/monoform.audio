class Api::SearchController < ApplicationController
	def recordings
		out = []
		Recording.search(params[:term]).each do |r|
			out << { "full_title" => r.full_title, "id" => r.id }
		end
		render json: out
	end

	def songs
		recordings = Song.search(params)
		songs = create_song_hash(recordings)

		render json: songs
	end

	def recommended_songs
		puts params[:artist]
		puts params[:playlist]
		recordings = Song.recommended_songs(params[:artist], params[:playlist])
		songs = create_song_hash(recordings)

		render json: songs
	end

	def new_songs
		recordings = Song.new_songs(params[:artist], params[:playlist])
		songs = create_song_hash(recordings)

		render json: songs
	end

private
	def create_song_hash(recordings)
		out = {}
		out["songs"] = []

		songs = recordings.collect{ |r| r.song_id }
		songs.uniq.each do |sid|
			s = Song.find(sid)
			song_hash = {}
			song_hash["title"] = s.name
			song_hash["composers"] = []
			artist_stage = []

			s.composers.each do |c|
				composer_hash = {}
				composer_hash["id"] = c.id
				composer_hash["name"] = c.name
				song_hash["composers"] << composer_hash
			end

			song_hash["recordings"] = []

			recordings.each do |r|
				if r.song_id == s.id
					recording_hash = {}
					recording_hash["id"] = r.id
					recording_hash["recording_id"] = r.recording_id
					recording_hash["title"] = r.name
					recording_hash["slug"] = r.slug
					recording_hash["description"] = r.description
					recording_hash["bpm"] = r.display_bpm
					recording_hash["recommended"] = r.recommended?
					#recording_hash["creative_commons"] = r.creative_commons?
					recording_hash["length"] = r.length
					recording_hash["genres"] = r.list_genres
					recording_hash["tags"] = []
					recording_hash["artists"] = []

					RecordingTag.where(recording_id: r.id).each do |t|
						tag_hash = {}
						tag_hash["tag"] = t.tag
						recording_hash["tags"] << tag_hash
					end
					r.artists.each do |a|
						artist_hash = {}
						artist_hash["id"] = a.id
						artist_hash["name"] = a.name
						artist_hash["slug"] = a.slug
						recording_hash["artists"] << artist_hash
					end

					song_hash["recordings"] << recording_hash
				end
			end
			
			out["songs"] << song_hash
		end

		out
	end
end
