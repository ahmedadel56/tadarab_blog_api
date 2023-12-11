require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'Database table' do
    it { is_expected.to have_db_column(:name).of_type(:string) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'Associations' do
    it { is_expected.to have_and_belong_to_many(:blogs).join_table(:blogs_categories) }
  end

  describe 'Model' do
    let(:category) { build(:category) }

    it 'is valid with valid attributes' do
      expect(category).to be_valid
    end

    it 'is not valid without a name' do
      category.name = nil
      expect(category).not_to be_valid
    end

    it 'has and belongs to many blogs' do
      expect(category.blogs).to be_empty

      blog1 = build(:blog)
      blog2 = build(:blog)

      category.blogs << blog1
      category.blogs << blog2

      expect(category.blogs).to include(blog1, blog2)
    end
  end
end
