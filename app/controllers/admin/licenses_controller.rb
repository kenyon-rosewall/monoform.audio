class Admin::LicensesController < AdminController
	before_action :set_page

	def set_page
		@p = 'licenses'
	end

	def index
		@licenses = License.order(name: :asc)
	end

	def new
		
	end

	def create
		l = License.create(
			name: params[:name],
			description: params[:description],
			active: true
			)

		redirect_to edit_admin_license_path(l.id)
	end

	def edit
		@license = License.find(params[:id])
	end

	def update
		l = License.find_by(id: params[:id])
		l.update(
			name: params[:name],
			description: params[:description]
			)

		redirect_to edit_admin_license_path(l.id)
	end

	def destroy
		l = License.find(params[:id])
		l.destroy

		redirect_to admin_licenses_path
	end

	def inactivate
		l = License.find(params[:license_id])
		l.update(active: false)

		redirect_to admin_licenses_path
	end

	def activate
		l = License.find(params[:license_id])
		l.update(active: true)

		redirect_to admin_licenses_path		
	end
end
