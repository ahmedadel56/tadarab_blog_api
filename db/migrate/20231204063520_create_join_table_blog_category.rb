class CreateJoinTableBlogCategory < ActiveRecord::Migration[7.1]
  def change
    create_join_table :blogs, :categories do |t|
      # The blog_id and category_id columns are automatically created
      t.index :blog_id
      t.index :category_id
      # You don't need to explicitly create blog_id and category_id here
    end
  end
end
