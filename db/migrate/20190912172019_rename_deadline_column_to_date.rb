class RenameDeadlineColumnToDate < ActiveRecord::Migration[5.2]
  def change
    rename_column :posts, :deadline, :date
  end
end
