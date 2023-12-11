# spec/models/token_blocklist_spec.rb
require 'rails_helper'

RSpec.describe TokenBlocklist, type: :model do
  describe 'Validations' do
    it { is_expected.to validate_presence_of(:token) }
  end

  describe 'Factory' do
    it 'has a valid factory' do
      expect(build(:token_blocklist)).to be_valid
    end

    it 'is invalid without a token' do
      blocklist = build(:token_blocklist, token: nil)
      expect(blocklist).not_to be_valid
      expect(blocklist.errors[:token]).to include("can't be blank")
    end
  end
end
