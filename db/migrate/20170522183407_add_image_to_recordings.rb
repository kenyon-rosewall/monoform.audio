class AddImageToRecordings < ActiveRecord::Migration
  def change
    add_column :recordings, :image, :binary, :limit => 256.kilobyte
    add_column :recordings, :image_type, :string
  end
end
