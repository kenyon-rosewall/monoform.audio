class Playlist < ActiveRecord::Base
	has_many :playlist_recordings
	has_many :recordings, :through => :playlist_recordings

	def get_image_tag
		if self.image
			encoded_image = Base64.encode64(self.image)
			"<img src='data:#{self.image_type};base64,#{encoded_image}' alt='Playlist (#{self.name}) image' />"
		else
			ActionController::Base.helpers.image_tag('playlist')
		end
	end

	def slug
		name.parameterize
	end
end
