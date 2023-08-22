class FixTags < ActiveRecord::Migration
  def change
  	drop_table :tags
  	remove_column :recording_tags, :tag_id
  	add_column :recording_tags, :tag, :string
  end
end
