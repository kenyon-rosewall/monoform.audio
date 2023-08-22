class CreateRecordingGenres < ActiveRecord::Migration
  def change
    create_table :recording_genres do |t|
      t.integer :recording_id
      t.integer :genre_id

      t.timestamps null: false
    end
  end
end
