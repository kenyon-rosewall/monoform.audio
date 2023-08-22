class Admin::PublishersController < AdminController
	before_action :set_page

	def set_page
		@p = 'publishers'
	end

	def index
		@publishers = Publisher.order(name: :asc)
	end

	def new
		
	end

	def create
		p = Publisher.create(
			name: params[:name],
			pro: params[:pro],
			url: params[:url],
			active: true
			)

		redirect_to edit_admin_publisher_path(p.id)
	end

	def edit
		@publisher = Publisher.find(params[:id])
	end

	def update
		p = Publisher.find_by(id: params[:id])
		p.update(
			name: params[:name],
			pro: params[:pro],
			url: params[:url]
			)

		redirect_to edit_admin_publisher_path(p.id)
	end

	def destroy
		p = Publisher.find(params[:id])
		p.destroy

		redirect_to admin_publishers_path
	end

	def inactivate
		p = Publisher.find(params[:publisher_id])
		p.update(active: false)

		redirect_to admin_publishers_path
	end

	def activate
		p = Publisher.find(params[:publisher_id])
		p.update(active: true)

		redirect_to admin_publishers_path		
	end
end
