class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_one :image, -> { with_attached_photos } ,as: :imageable
  has_many :reactions

  accepts_nested_attributes_for :image

  validates :title, presence: true, length: { maximum: 300 }

  def self.with_reactions
    reactions = Post::Reaction.group(:post_id, :kind).count
    @reactions = reactions.each_with_object({}) do |(key, value), result_hash|
      id, action = key
      result_hash[id] ||= {}
      result_hash[id][action.to_sym] = value
    end
  end
end
