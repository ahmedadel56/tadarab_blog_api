class TokenBlocklist < ApplicationRecord
  validates :token, presence: true
end
