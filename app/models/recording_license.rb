class RecordingLicense < ActiveRecord::Base
	belongs_to :recording
	belongs_to :license
end
