class AddClumnCategoryToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :category, :integer, default: 1, null: false
  end
end
