class Post::Reaction < ApplicationRecord
  enum kind: %i[like dislike]

  belongs_to :user
  belongs_to :post

  validates :kind, presence: true
end
