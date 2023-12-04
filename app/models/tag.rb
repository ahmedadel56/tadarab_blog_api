class Tag < ApplicationRecord
    has_and_belongs_to_many :blogs, join_table: :blogs_tags

    alidates :name, presence: true
end
