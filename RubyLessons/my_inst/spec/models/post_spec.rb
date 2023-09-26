require 'rails_helper'

require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { create(:user) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      post = build(:post, author: user, title: 'Title')
      expect(post).to be_valid
    end

    it 'is not valid without a title' do
      post = build(:post, author: user, title: nil)
      expect(post).not_to be_valid
    end

    it 'is not valid if title length is more than 250 characters' do
      post = build(:post, author: user, title: 'A' * 301)
      expect(post).not_to be_valid
    end

    it 'is not valid without an author' do
      post = build(:post, author: nil, title: 'Title')
      expect(post).not_to be_valid
    end
  end

  describe 'associations' do
    it 'belongs to an author (user)' do
      association = Post.reflect_on_association(:author)
      expect(association.macro).to eq(:belongs_to)
    end

    it 'has one image' do
      association = Post.reflect_on_association(:image)
      expect(association.macro).to eq(:has_one)
    end

    it 'has many reactions' do
      association = Post.reflect_on_association(:reactions)
      expect(association.macro).to eq(:has_many)
    end
  end
end
