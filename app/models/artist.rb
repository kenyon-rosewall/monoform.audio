class Artist < ActiveRecord::Base
	has_many :recording_artists
	has_many :recordings, :through => :recording_artists
	before_destroy :remove_recordings

	def remove_recordings
		RecordingArtist.where(artist_id: self.id).destroy_all
	end

	def get_image_tag
		if self.image
			encoded_image = Base64.encode64(self.image)
			"<img src='data:#{self.image_type};base64,#{encoded_image}' alt='Artist (#{self.name}) image' />"
		else
			ActionController::Base.helpers.image_tag('artist')
		end
	end

	def slug
		name.parameterize
	end
end
