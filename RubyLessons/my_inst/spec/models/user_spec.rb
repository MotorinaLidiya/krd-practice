require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      user = build(:user, email: '1@2.3', password: 'password')
      expect(user).to be_valid
    end

    it 'is not valid without an email' do
      user = build(:user, email: nil, password: 'password')
      expect(user).not_to be_valid
    end

    it 'is not valid without a password' do
      user = build(:user, email: '1@2.3', password: nil)
      expect(user).not_to be_valid
    end
  end

  describe 'associations' do
    it 'has many reactions' do
      association = User.reflect_on_association(:reactions)
      expect(association.macro).to eq(:has_many)
    end
  end
end
