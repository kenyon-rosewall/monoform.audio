class CreatePlaylists < ActiveRecord::Migration
  def change
    create_table :playlists do |t|
      t.string :playlist_id
      t.string :name
      t.text :description
      t.binary :image

      t.timestamps null: false
    end
  end
end
