class CreateRecordings < ActiveRecord::Migration
  def change
    create_table :recordings do |t|
      t.string :recording_id
      t.string :name
      t.text :description
      t.integer :bpm
      t.string :length

      t.timestamps null: false
    end
  end
end
