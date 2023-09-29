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

    it 'is not valid without an author' do
      post = build(:post, author: nil, title: 'Title')
      expect(post).not_to be_valid
    end
  end

  describe 'associations' do
    it 'belongs to an author (user)' do
      expect(Post.belongs_to :author).to be_truthy
    end

    it 'has many images' do
      expect(Post.has_many_attached :images).to be_truthy
    end

    it 'has many reactions' do
      expect(Post.has_many :reactions).to be_truthy
    end
  end
end
