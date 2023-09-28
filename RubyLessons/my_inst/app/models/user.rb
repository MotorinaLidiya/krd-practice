class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :rememberable, :validatable

  has_many :reactions, class_name: 'Post::Reaction', dependent: :restrict_with_error
  has_many :posts, foreign_key: :author_id, dependent: :restrict_with_error
  has_many :subscriptions, class_name: 'Subscribtion', foreign_key: 'subscriber_id', dependent: :destroy
  has_many :subscribers, class_name: 'Subscribtion', foreign_key: 'owner_id', dependent: :destroy

  def subscribed_to?(user)
    subscriptions.exists?(owner_id: user.id)
  end

  def not_subscribed_to?(user)
    !subscribed_to?(user)
  end
end
