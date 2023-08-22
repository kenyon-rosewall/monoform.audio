class CreateRecordingTags < ActiveRecord::Migration
  def change
    create_table :recording_tags do |t|
      t.integer :recording_id
      t.integer :tag_id

      t.timestamps null: false
    end
  end
end
