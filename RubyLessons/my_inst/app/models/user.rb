class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :rememberable, :validatable

  has_many :reactions, class_name: 'Post::Reaction', dependent: :restrict_with_error
  has_many :posts, foreign_key: :author_id, dependent: :restrict_with_error
  has_many :owners, class_name: 'Subscriber', foreign_key: 'owner_id', dependent: :destroy
  has_many :subscriptions, class_name: 'Subscriber', foreign_key: 'subscriber_id', dependent: :destroy

  def subscribe_to(user)
    subscriptions.create(owner: user)
  end

  def unsubscribe_from(user)
    subscriptions.find_by(owner_id: user.id)&.destroy
  end

  def subscribed_to?(user)
    subscriptions.exists?(owner_id: user.id)
  end
end
