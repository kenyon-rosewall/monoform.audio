class AddPathsToRecording < ActiveRecord::Migration
  def change
    add_column :recordings, :wav_name, :string
    add_column :recordings, :watermark_name, :string
  end
end
