class CreateSongPublishers < ActiveRecord::Migration
  def change
    create_table :song_publishers do |t|
      t.integer :song_id
      t.integer :publisher_id
      t.float :percentage

      t.timestamps null: false
    end
  end
end
