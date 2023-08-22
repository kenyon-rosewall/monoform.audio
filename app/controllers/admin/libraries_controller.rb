class Admin::LibrariesController < AdminController
	before_action :set_page

	def set_page
		@p = 'libraries'
	end

	def index
		@libraries = Library.order(name: :asc)
	end

	def new
		
	end

	def create
		l = Library.create(
			name: params[:name],
			description: params[:description],
			active: true
			)

		redirect_to edit_admin_library_path(l.id)
	end

	def edit
		@library = Library.find(params[:id])
	end

	def update
		l = Library.find_by(id: params[:id])
		l.update(
			name: params[:name],
			description: params[:description]
			)

		redirect_to edit_admin_library_path(l.id)
	end

	def destroy
		l = Library.find(params[:id])
		l.destroy

		redirect_to admin_libraries_path
	end

	def inactivate
		l = Library.find(params[:library_id])
		l.update(active: false)

		redirect_to admin_libraries_path
	end

	def activate
		l = Library.find(params[:library_id])
		l.update(active: true)

		redirect_to admin_libraries_path		
	end
end
