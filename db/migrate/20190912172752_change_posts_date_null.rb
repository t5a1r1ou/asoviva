class ChangePostsDateNull < ActiveRecord::Migration[5.2]
  def change
    change_column_null :posts, :date, true
  end
end
