class Category < ApplicationRecord
  has_and_belongs_to_many :blogs, join_table: :blogs_categories

  validates :name, presence: true
end
