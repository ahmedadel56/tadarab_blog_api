class Tag < ApplicationRecord
    has_and_belongs_to_many :blogs, join_table: :blogs_tags

    validates :name, presence: true
end
