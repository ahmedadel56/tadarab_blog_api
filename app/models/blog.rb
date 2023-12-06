class Blog < ApplicationRecord
  enum status: { draft: 0, published: 1, pending: 2 }

  default_scope { where(deleted_at: nil) }

  has_and_belongs_to_many :authors, class_name: 'User', join_table: :blogs_users
  has_and_belongs_to_many :categories, join_table: :blogs_categories
  has_and_belongs_to_many :tags, join_table: :blogs_tags
  has_many :sections, dependent: :destroy
  has_one_attached :image

  validates :title, presence: true
  validates :introduction, presence: true
  validates :conclusion, presence: true
  validates :meta_title, presence: true
  validates :meta_description, presence: true
  validate :validate_sections_count
  validate :single_featured_article
  validates :meta_title, length: { maximum: 60, too_long: 'must be at most %<count>s characters' }
  validates :meta_description, length: { maximum: 160, too_long: 'must be at most %<count>s characters' }

  validates :image, content_type: { in: ['image/png', 'image/jpg', 'image/jpeg'] },
                    size: { less_than: 100.kilobytes }

  private

  def validate_sections_count
    errors.add(:sections, 'exceed the maximum allowed count') if sections.size > 15
  end

  def soft_delete
    update(deleted_at: Time.current)
  end

  def single_featured_article
    return unless featured && Blog.where.not(id:).where(featured: true).exists?

    errors.add(:featured, 'There can only be one featured article')
  end
end
