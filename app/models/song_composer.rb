class SongComposer < ActiveRecord::Base
	default_scope { order('percentage DESC') }
	belongs_to :song
	belongs_to :composer
end
