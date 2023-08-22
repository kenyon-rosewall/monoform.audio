class AddOldIdToRecording < ActiveRecord::Migration
  def change
    add_column :recordings, :old_id, :integer
  end
end
