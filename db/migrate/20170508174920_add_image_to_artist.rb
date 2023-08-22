class AddImageToArtist < ActiveRecord::Migration
  def change
    add_column :artists, :image, :binary
    add_column :artists, :image_type, :string
  end
end
