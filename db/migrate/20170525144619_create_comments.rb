class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :name
      t.text :comment
      t.integer :recording_id

      t.timestamps null: false
    end
  end
end
