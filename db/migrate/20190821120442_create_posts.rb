class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :name, limit: 20, null: false
      t.text :description, limit: 140, null: false
      t.integer :area, null: false
      t.integer :count, null: true
      t.date :deadline, null: true

      t.timestamps
    end
  end
end
