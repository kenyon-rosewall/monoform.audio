class AddSongIdToRecording < ActiveRecord::Migration
  def change
    add_column :recordings, :song_id, :integer
  end
end
