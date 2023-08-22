class SongPublisher < ActiveRecord::Base
	belongs_to :song
	belongs_to :publisher
end
