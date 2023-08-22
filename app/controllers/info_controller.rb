class InfoController < ApplicationController
	def index
		
	end

	def about_us
		
	end

	def reel
		
	end

	def credits
		
	end

	def testimonials
		
	end

	def privacy_policy
		
	end

	def license_agreement
		
	end

	def site_map
		@recordings = Recording.active_recordings
	end

	def licensing
		
	end
end
