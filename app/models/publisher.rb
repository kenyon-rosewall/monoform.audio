class Publisher < ActiveRecord::Base
	has_many :song_publishers
	has_many :songs, :through => :song_publishers
	before_destroy :remove_songs

	def remove_songs
		SongPublisher.where(publisher_id: self.id).destroy_all
	end
end
