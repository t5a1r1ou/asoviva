class ChangeDeadlineForNull < ActiveRecord::Migration[5.2]
  def change
    change_column_null :posts, :deadline, false
  end
end
