class Admin::ArtistsController < AdminController
	before_action :set_page

	def set_page
		@p = 'artists'
	end

	def index
		@artists = Artist.order(name: :asc)
	end

	def new
		
	end

	def create
		if params[:image]
			Artist.create(
				name: params[:name],
				description: params[:description],
				image: params[:image].read,
				image_type: params[:image].content_type,
				active: true
				)
		else
			Artist.create(
				name: params[:name],
				description: params[:description],
				active: true
				)
		end

		redirect_to admin_artists_path
	end

	def edit
		@artist = Artist.find(params[:id])
	end

	def update
		a = Artist.find_by(id: params[:id])
		if params[:image]
			a.update(
				name: params[:name],
				description: params[:description],
				image: params[:image].read,
				image_type: params[:image].content_type,
				url: params[:url]
				)
		else
			a.update(
				name: params[:name],
				description: params[:description],
				url: params[:url]
				)
		end

		redirect_to admin_artists_path
	end

	def destroy
		a = Artist.find(params[:id])
		a.destroy

		redirect_to admin_artists_path
	end

	def inactivate
		a = Artist.find(params[:artist_id])
		a.update(active: false)

		redirect_to admin_artists_path
	end

	def activate
		a = Artist.find(params[:artist_id])
		a.update(active: true)

		redirect_to admin_artists_path		
	end
end
