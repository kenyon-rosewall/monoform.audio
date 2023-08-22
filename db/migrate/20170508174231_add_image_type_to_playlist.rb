class AddImageTypeToPlaylist < ActiveRecord::Migration
  def change
    add_column :playlists, :image_type, :string
  end
end
