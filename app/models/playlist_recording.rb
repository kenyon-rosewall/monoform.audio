class PlaylistRecording < ActiveRecord::Base
	belongs_to :playlist
	belongs_to :recording
end
