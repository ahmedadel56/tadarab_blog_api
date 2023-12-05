class AddDeletedAtToBlogs < ActiveRecord::Migration[7.1]
  def change
    add_column :blogs, :deleted_at, :datetime
  end
end
