class CreateJoinTableBlogUser < ActiveRecord::Migration[7.1]
  def change
    create_join_table :blogs, :users do |t|
      # The blog_id and user_id columns are automatically created
      t.index :blog_id
      t.index :user_id
      # You don't need to explicitly create blog_id and user_id here
    end
  end
end
