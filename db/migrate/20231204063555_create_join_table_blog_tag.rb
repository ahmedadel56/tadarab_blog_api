class CreateJoinTableBlogTag < ActiveRecord::Migration[7.1]
  def change
    create_join_table :blogs, :tags do |t|
      # The blog_id and tag_id columns are automatically created
      t.index :blog_id
      t.index :tag_id
      # No need to explicitly create blog_id and tag_id here
    end
  end
end
