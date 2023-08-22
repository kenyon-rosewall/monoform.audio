class DropSongRecordings < ActiveRecord::Migration
  def change
  	drop_table :song_recordings
  end
end
