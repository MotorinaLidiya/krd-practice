class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_one :image, -> { with_attached_photos } ,as: :imageable
  has_many :reactions, dependent: :destroy
  has_many :comments, dependent: :destroy

  accepts_nested_attributes_for :image

  validates :title, presence: true
end
