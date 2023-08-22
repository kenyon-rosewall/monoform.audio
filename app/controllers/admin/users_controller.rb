class Admin::UsersController < AdminController
	before_action :set_page

	def set_page
		@p = 'users'
	end

end
