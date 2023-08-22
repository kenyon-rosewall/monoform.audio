class Composer < ActiveRecord::Base
	default_scope { order('name ASC') }
	has_many :song_composers
	has_many :songs, :through => :song_composers
	before_destroy :remove_songs

	def remove_songs
		SongComposer.where(composer_id: self.id).destroy_all
	end
end
