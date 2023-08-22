class Library < ActiveRecord::Base
	has_many :recording_libraries
	has_many :recordings, :through => :recording_libraries
	before_destroy :remove_recordings

	def remove_recordings
		RecordingLibrary.where(library_id: self.id).destroy_all
	end
end
