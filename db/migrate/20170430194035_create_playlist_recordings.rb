class CreatePlaylistRecordings < ActiveRecord::Migration
  def change
    create_table :playlist_recordings do |t|
      t.integer :playlist_id
      t.integer :recording_id

      t.timestamps null: false
    end
  end
end
