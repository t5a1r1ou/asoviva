class AddProfileAreaToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :profile, :text, limit: 140
    add_column :users, :area, :integer, null: false, default: 0
  end
end
