class CreateRecordingLibraries < ActiveRecord::Migration
  def change
    create_table :recording_libraries do |t|
      t.integer :recording_id
      t.integer :library_id

      t.timestamps null: false
    end
  end
end
