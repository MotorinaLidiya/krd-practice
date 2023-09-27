class Post::Reaction < ApplicationRecord
  enum kind: %i[like dislike]

  belongs_to :user
  belongs_to :post

  validates :kind, presence: true
  validates :user, uniqueness: { scope: :post, message: 'has already put a reaction' }

  def self.group_by_posts(user_id)
    reactions = group(:post_id, :kind).count
    user_reactions = where(user_id: user_id).pluck(:post_id, :kind).to_h

    reactions.each_with_object({}) do |(key, value), result_hash|
      post_id, action = key
      result_hash[post_id] ||= {}
      result_hash[post_id][action.to_sym] = value

      # set kind if user already have reaction
      if result_hash[post_id][:user].blank? && user_reactions.keys.include?(post_id)
        result_hash[post_id][:user] = user_reactions[post_id]
      end
    end
  end
end
