class RecordingGenre < ActiveRecord::Base
	belongs_to :recording
	belongs_to :genre
end
