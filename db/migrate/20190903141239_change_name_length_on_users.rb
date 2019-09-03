class ChangeNameLengthOnUsers < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :name, :string, limit: 8, null: false
  end

  def down
    change_column :users, :name, :string, default: "", null: false
  end
end
