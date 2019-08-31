class AddGenderToUser < ActiveRecord::Migration[5.2]
  def change
    execute 'DELETE FROM users;'
    add_column :users, :gender, :integer, null: false, default: 0
  end
end
