class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :reactions, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many_attached :images

  validates :title, presence: true
end
