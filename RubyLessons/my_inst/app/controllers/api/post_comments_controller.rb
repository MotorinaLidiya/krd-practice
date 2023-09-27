class Api::PostCommentsController < ActionController::API
  def create
    Post::Comment.create(post_params)

    render json: Post::Comment.group_by_posts[post_params[:post_id]]
  end

  def destroy
    comment = Post::Comment.find(params[:id])
    comment.destroy if comment.present? && comment.author_id == params['author_id']

    render json: Post::Comment.group_by_posts[params['post_id'] || comment.post_id]
  end

  private

  def post_params
    params.require(:data).permit(:post_id, :author_id, :body)
  end
end
