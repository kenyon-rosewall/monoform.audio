class CreateRecordingArtists < ActiveRecord::Migration
  def change
    create_table :recording_artists do |t|
      t.integer :recording_id
      t.integer :artist_id
      t.boolean :primary

      t.timestamps null: false
    end
  end
end
