class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :rememberable, :validatable

  has_many :reactions, class_name: 'Post::Reaction', dependent: :restrict_with_error
  has_many :posts, foreign_key: :author_id, dependent: :restrict_with_error
end
