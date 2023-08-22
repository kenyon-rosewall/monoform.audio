class DropRecordingLicensesTable < ActiveRecord::Migration
  def change
  	drop_table :recording_licenses
  end
end
