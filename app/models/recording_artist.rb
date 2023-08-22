class RecordingArtist < ActiveRecord::Base
	belongs_to :recording
	belongs_to :artist
	default_scope { order(primary: :desc) }
end
