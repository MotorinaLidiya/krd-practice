class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :rememberable, :validatable

  has_many :reactions, class_name: 'Post::Reaction'
end
