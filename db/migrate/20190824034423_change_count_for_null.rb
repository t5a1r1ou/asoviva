class ChangeCountForNull < ActiveRecord::Migration[5.2]
  def change
    change_column_null :posts, :count, false
  end
end
