class AddLicenseIdToRecording < ActiveRecord::Migration
  def change
    add_column :recordings, :license_id, :integer
  end
end
