class Post::Comment < ApplicationRecord
  belongs_to :post
  belongs_to :author, class_name: 'User'

  validates :body, presence: true

  def self.group_by_posts
    includes(:author).group_by(&:post_id).transform_values do |comments|
      {
        count: comments.size,
        comments: comments.map do |comment|
          {
            id: comment.id,
            user_id: comment.author_id,
            email: comment.author.email,
            body: comment.body,
            created_at: comment.created_at.strftime('%d.%m.%Y %H:%M')
          }
        end
      }
    end
  end
end
