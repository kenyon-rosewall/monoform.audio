class AdminController < ApplicationController
	layout "admin"
	before_action :auth, except: [:login, :authorize]

	def index
		@p = 'dashboard'
	end

	def login
		
	end

	def auth
		if !authenticated?
			authenticate
		end
	end

	def authenticated?
		session.has_key? :monoform
	end

	def authenticate
		redirect_to "/admin/login"
	end

	def authorize
		if params[:username] == 'monoform' and params[:password] == '5P@Rkyn@!1'
			session[:monoform] = 'monoform'
			session[:expires_at] = 4.hours.from_now
			redirect_to action: "index"
		else
			redirect_to "/admin/login"
		end
	end
end
