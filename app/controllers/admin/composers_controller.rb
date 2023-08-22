class Admin::ComposersController < AdminController
	before_action :set_page

	def set_page
		@p = 'composers'
	end

	def index
		@composers = Composer.order(name: :asc)
	end

	def new
		
	end

	def create
		c = Composer.create(
			name: params[:name],
			pro: params[:pro],
			url: params[:url],
			description: params[:description],
			active: true
			)

		redirect_to edit_admin_composer_path(c.id)
	end

	def edit
		@composer = Composer.find(params[:id])
	end

	def update
		c = Composer.find_by(id: params[:id])
		c.update(
			name: params[:name],
			pro: params[:pro],
			url: params[:url],
			description: params[:description]
			)

		redirect_to edit_admin_composer_path(c.id)
	end

	def destroy
		c = Composer.find(params[:id])
		c.destroy

		redirect_to admin_composers_path
	end

	def inactivate
		c = Composer.find(params[:composer_id])
		c.update(active: false)

		redirect_to admin_composers_path
	end

	def activate
		c = Composer.find(params[:composer_id])
		c.update(active: true)

		redirect_to admin_composers_path		
	end
end
