class CreateLicenseRequestRecordings < ActiveRecord::Migration
  def change
    create_table :license_request_recordings do |t|
      t.integer :license_request_id
      t.integer :recording_id

      t.timestamps null: false
    end
  end
end
