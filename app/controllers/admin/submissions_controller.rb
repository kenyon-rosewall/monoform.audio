class Admin::SubmissionsController < AdminController
	before_action :set_page

	def set_page
		@p = 'submissions'
	end

	def index
		@submissions = Submission.order(created_at: :desc)
	end

	def view
		@submission = Submission.find(params[:id])
	end

	def delete
		s = Submission.find(params[:id])
		s.destroy

		redirect_to admin_submissions_path
	end
end
