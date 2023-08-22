class AddActiveToModels < ActiveRecord::Migration
  def change
  	add_column :artists, :active, :boolean
  	add_column :composers, :active, :boolean
  	add_column :libraries, :active, :boolean
  	add_column :licenses, :active, :boolean
  	add_column :playlists, :active, :boolean
  	add_column :publishers, :active, :boolean
  	add_column :songs, :active, :boolean
  end
end
