# spec/models/tag_spec.rb
require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe 'Associations' do
    it { is_expected.to have_and_belong_to_many(:blogs).join_table(:blogs_tags) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'Factory' do
    it 'has a valid factory' do
      expect(build(:tag)).to be_valid
    end

    it 'is invalid without a name' do
      tag = build(:tag, name: nil)
      expect(tag).not_to be_valid
      expect(tag.errors[:name]).to include("can't be blank")
    end
  end
end
