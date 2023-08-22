class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.string :name
      t.string :email
      t.text :message
      t.string :artist
      t.string :submission_id
      t.string :sounds_like
      t.string :how_did_you_hear

      t.timestamps null: false
    end
  end
end
