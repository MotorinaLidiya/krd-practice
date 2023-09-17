require 'rails_helper'

RSpec.describe Lab, type: :model do
  let(:user) { create(:user) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      lab = Lab.new(title: 'Title', description: 'Description', user_id: user.id)
      expect(lab).to be_valid
    end

    it 'is not valid without a title' do
      lab = Lab.new(description: 'Description', user_id: user.id)
      expect(lab).not_to be_valid
    end

    it 'is not valid if title length more than 250 symbols' do
      lab = Lab.new(title: 'A' * 251, description: 'Description', user_id: user.id)
      expect(lab).not_to be_valid
    end

    it 'is not valid without a description' do
      lab = Lab.new(title: 'Title', user_id: user.id)
      expect(lab).not_to be_valid
    end

    it 'is not valid if description length more than 500 symbols' do
      lab = Lab.new(title: 'Title', description: 'A' * 501, user_id: user.id)
      expect(lab).not_to be_valid
    end

    it 'is not valid without a user_id' do
      lab = Lab.new(title: 'Title', description: 'Description')
      expect(lab).not_to be_valid
    end

    it 'is not valid with an invalid grade' do
      lab = Lab.new(title: 'Title', description: 'Description', user_id: user.id, grade: 'invalid_grade')
      expect(lab).not_to be_valid
    end

    it 'is valid with a valid grade' do
      lab = Lab.new(title: 'Title', description: 'Description', user_id: user.id, grade: 'a')
      expect(lab).to be_valid
    end
  end

  describe 'associations' do
    it 'belongs to a user' do
      association = Lab.reflect_on_association(:user)
      expect(association.macro).to eq(:belongs_to)
    end
  end
end
