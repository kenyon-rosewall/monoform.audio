class CreatePublishers < ActiveRecord::Migration
  def change
    create_table :publishers do |t|
      t.string :name
      t.string :pro
      t.string :url

      t.timestamps null: false
    end
  end
end
