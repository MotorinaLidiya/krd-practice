require 'rails_helper'

RSpec.describe Post::Comment, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post) }
  let(:comment) { create(:comment, post: post, author: user) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(comment).to be_valid
    end

    it 'is not valid without a body' do
      comment = build(:comment, post: post, author: user, body: nil)
      expect(comment).not_to be_valid
    end
  end

  describe 'associations' do
    it 'belongs to a post' do
      expect(described_class.belongs_to :post).to be_truthy
    end

    it 'belongs to an author (User)' do
      association = described_class.reflect_on_association(:author)
      expect(described_class.belongs_to :author).to be_truthy
      expect(association.options[:class_name]).to eq('User')
    end
  end
end
