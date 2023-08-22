class Quote < ActiveRecord::Base
	def self.random
		offset = rand(Quote.count)

		Quote.offset(offset).first
	end
end
