class ChangeImagesToLongblob < ActiveRecord::Migration
  def change
  	change_column :playlists, :image, :binary, :limit => 256.kilobyte
  	change_column :artists, :image, :binary, :limit => 256.kilobyte
  end
end
