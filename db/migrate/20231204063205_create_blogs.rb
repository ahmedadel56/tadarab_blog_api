class CreateBlogs < ActiveRecord::Migration[7.1]
  def change
    create_table :blogs do |t|
      t.string :title
      t.text :introduction
      t.text :conclusion
      t.string :meta_title
      t.string :meta_description
      t.boolean :featured
      t.integer :length
      t.integer :status
      t.string :image

      t.timestamps
    end
  end
end
