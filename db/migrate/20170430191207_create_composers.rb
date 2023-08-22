class CreateComposers < ActiveRecord::Migration
  def change
    create_table :composers do |t|
      t.string :name
      t.string :pro
      t.string :url
      t.text :description

      t.timestamps null: false
    end
  end
end
