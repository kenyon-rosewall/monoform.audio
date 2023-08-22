class License < ActiveRecord::Base
	has_many :recordings
	before_destroy :remove_recordings

	def remove_recordings
		RecordingLicense.where(license_id: self.id).destroy_all
	end
end
