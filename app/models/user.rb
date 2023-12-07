class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable, :timeoutable, :trackable

  has_and_belongs_to_many :authored_blogs, class_name: 'Blog', join_table: :blogs_users
  enum role: { user: 0, admin: 1 }
  after_initialize :set_default_role, if: :new_record?

  private

  def set_default_role
    self.role ||= :user
  end
end
