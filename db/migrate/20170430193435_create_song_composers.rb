class CreateSongComposers < ActiveRecord::Migration
  def change
    create_table :song_composers do |t|
      t.integer :song_id
      t.integer :composer_id
      t.float :percentage

      t.timestamps null: false
    end
  end
end
