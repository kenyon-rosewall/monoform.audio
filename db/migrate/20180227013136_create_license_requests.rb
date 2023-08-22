class CreateLicenseRequests < ActiveRecord::Migration
  def change
    create_table :license_requests do |t|
      t.string :name
      t.string :organization
      t.string :email
      t.string :project_name
      t.text :project_description
      t.text :song_use
      t.text :budget
      t.text :timeline
      t.text :alterations
      t.text :notes
      t.string :phone

      t.timestamps null: false
    end
  end
end
