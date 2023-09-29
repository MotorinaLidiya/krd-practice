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

    it 'has many posts' do
      association = User.reflect_on_association(:posts)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:foreign_key]).to eq(:author_id)
      expect(association.options[:dependent]).to eq(:restrict_with_error)
    end

    it 'has many subscriptions' do
      association = User.reflect_on_association(:subscriptions)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:class_name]).to eq('Subscribtion')
      expect(association.options[:foreign_key]).to eq('subscriber_id')
      expect(association.options[:dependent]).to eq(:destroy)
    end

    it 'has many subscribers' do
      association = User.reflect_on_association(:subscribers)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:class_name]).to eq('Subscribtion')
      expect(association.options[:foreign_key]).to eq('owner_id')
      expect(association.options[:dependent]).to eq(:destroy)
    end
  end

  describe 'methods' do
    it 'subscribed_to? returns true if subscribed' do
      other_user = create(:user)
      subscription = create(:subscribtion, subscriber: user, owner: other_user)
      expect(user.subscribed_to?(other_user)).to be_truthy
    end

    it 'subscribed_to? returns false if not subscribed' do
      other_user = create(:user)
      expect(user.subscribed_to?(other_user)).to be_falsey
    end

    it 'not_subscribed_to? returns true if not subscribed' do
      other_user = create(:user)
      expect(user.not_subscribed_to?(other_user)).to be_truthy
    end

    it 'not_subscribed_to? returns false if subscribed' do
      other_user = create(:user)
      subscription = create(:subscribtion, subscriber: user, owner: other_user)
      expect(user.not_subscribed_to?(other_user)).to be_falsey
    end
  end
end
