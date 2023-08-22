class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :song_id
      t.string :name
      t.text :description
      t.date :release_date

      t.timestamps null: false
    end
  end
end
