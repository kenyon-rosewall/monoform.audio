class CreateRecordingLicenses < ActiveRecord::Migration
  def change
    create_table :recording_licenses do |t|
      t.integer :recording_id
      t.integer :license_id

      t.timestamps null: false
    end
  end
end
