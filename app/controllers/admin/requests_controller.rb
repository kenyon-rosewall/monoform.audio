class Admin::RequestsController < AdminController
	before_action :set_page
	
	def set_page
		@p = 'requests'
	end

	def index
		@requests = LicenseRequest.order(created_at: :desc)
	end

	def edit
		@request = LicenseRequest.find(params[:id])
	end
end
