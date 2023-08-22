class Admin::QuotesController < AdminController
	before_action :set_page

	def set_page
		@p = 'quotes'
	end

	def index
		@quotes = Quote.all
	end

	def edit
		@quote = Quote.find(params[:id])
	end

	def new
		
	end

	def create
		Quote.create(
			content: params[:content],
			author: params[:author]
			)

		redirect_to action: "index"
	end

	def update
		q = Quote.find(params[:id])

		q.update(
			content: params[:content],
			author: params[:author]
			)

		redirect_to action: "index"
	end

	def destroy
		q = Quote.find(params[:id])
		q.delete

		redirect_to action: "index"
	end
end
