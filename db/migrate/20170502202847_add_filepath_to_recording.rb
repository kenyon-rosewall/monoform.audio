class AddFilepathToRecording < ActiveRecord::Migration
  def change
    add_column :recordings, :filepath, :string
  end
end
