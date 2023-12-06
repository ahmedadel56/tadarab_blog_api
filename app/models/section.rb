class Section < ApplicationRecord
  belongs_to :blog

  validates :title, presence: true
  validates :body, presence: true
end
