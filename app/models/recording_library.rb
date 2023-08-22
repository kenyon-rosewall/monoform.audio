class RecordingLibrary < ActiveRecord::Base
	belongs_to :recording
	belongs_to :library
end
