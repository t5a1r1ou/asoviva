class AddDefaultToPostDescription < ActiveRecord::Migration[5.2]
  def up
    change_column :posts, :description, :text, null: false, limit: 140, default: 'とりあえず遊びたーい'
  end
  def down
    change_column :posts, :description, :text, null: false
  end
end
