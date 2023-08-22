class Genre < ActiveRecord::Base
	has_many :recording_genres
	has_many :recordings, :through => :recording_genres
	before_destroy :remove_recordings

	def remove_recordings
		RecordingGenre.where(genre_id: self.id).destroy_all
	end
end
