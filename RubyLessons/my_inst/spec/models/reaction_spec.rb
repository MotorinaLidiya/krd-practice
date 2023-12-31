require 'rails_helper'

RSpec.describe Post::Reaction, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post) }
  let(:post_reaction) { create(:post_reaction, user: user, post: post) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(post_reaction).to be_valid
    end

    it 'is not valid without a kind' do
      reaction = build(:post_reaction, kind: nil, user: user, post: post)
      expect(reaction).not_to be_valid
    end

    it 'is not valid with an empty kind' do
      reaction = build(:post_reaction, kind: '', user: user, post: post)
      expect(reaction).not_to be_valid
    end
  end

  describe 'associations' do
    it 'belongs to a user' do
      expect(described_class.belongs_to :user).to be_truthy
    end

    it 'belongs to a post' do
      expect(described_class.belongs_to :post).to be_truthy
    end
  end

  describe 'enums' do
    it 'defines an enum for kind with like and dislike' do
      expect(Post::Reaction.kinds.keys).to contain_exactly('like', 'dislike')
    end
  end
end
