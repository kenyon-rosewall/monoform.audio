class HomeController < ApplicationController
	def index
		@quote = Quote.random
	end

	def cart
		
	end

	def thanks
		if params.has_key? :type and params[:type] != ''
			@message = thanks_messages[params[:type]]
			@duration = thanks_durations[params[:type]]
		else
			@message = thanks_messages['generic']
			@duration = thanks_durations['generic']
		end
	end

	def login
		
	end

	def logout
		
	end

	def profile
		
	end

	private
	def thanks_messages
		{
			"generic" => "Thanks.",
			"license_request" => "Thanks for submitting your licensing request.",
			"music_submit" => "Thanks for submitting your music to Monoform. We are excited to listen to it."
		}
	end

	def thanks_durations
		{
			"generic" => 5,
			"license_request" => 5,
			"music_submit" => 15
		}
	end
end
