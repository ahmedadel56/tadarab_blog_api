require 'rails_helper'

RSpec.describe Section, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:blog) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:body) }
  end

  describe 'Factory' do
    context 'with valid attributes' do
      it 'creates a valid section' do
        expect(build(:section)).to be_valid
      end
    end

    context 'with invalid attributes' do
      it 'is invalid without a title' do
        section_without_title = build(:section, title: nil)
        expect(section_without_title).not_to be_valid
        expect(section_without_title.errors[:title]).to include("can't be blank")
      end

      it 'is invalid without a body' do
        section_without_body = build(:section, body: nil)
        expect(section_without_body).not_to be_valid
        expect(section_without_body.errors[:body]).to include("can't be blank")
      end
    end
  end
end
