class Admin::GenresController < AdminController
	before_action :set_page

	def set_page
		@p = 'genres'
	end

	def index
		@genres = Genre.order(name: :asc)
	end

	def create
		g = Genre.create(
			name: params[:name]
			) if Genre.find_by(name: params[:name]) == nil

		redirect_to admin_genres_path
	end

	def edit
		@genre = Genre.find(params[:id])
	end

	def update
		g = Genre.find_by(id: params[:id])
		g.update(
			name: params[:name]
			)

		redirect_to admin_genres_path
	end

	def destroy
		g = Genre.find(params[:id])
		g.destroy

		redirect_to admin_genres_path
	end
end
