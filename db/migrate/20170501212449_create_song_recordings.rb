class CreateSongRecordings < ActiveRecord::Migration
  def change
    create_table :song_recordings do |t|
      t.integer :song_id
      t.integer :recording_id

      t.timestamps null: false
    end
  end
end
