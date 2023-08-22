class AddRecommendedToRecording < ActiveRecord::Migration
  def change
    add_column :recordings, :recommended, :boolean
  end
end
