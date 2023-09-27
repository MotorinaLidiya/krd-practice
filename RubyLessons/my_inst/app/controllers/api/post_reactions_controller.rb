class Api::PostReactionsController < ActionController::API
  def like
    action('like')
  end

  def dislike
    action('dislike')
  end

  private

  def action(action_name)
    @post_reaction = Post::Reaction.find_by(post_params)

    if @post_reaction.present? && @post_reaction.send("#{action_name}?")
      @post_reaction.destroy
    elsif @post_reaction.present?
      @post_reaction.update(kind: action_name)
    else
      Post::Reaction.create(post_params.merge(kind: action_name))
    end

    render json: Post::Reaction.group_by_posts(post_params[:user_id])[post_params[:post_id]]
  end

  def post_params
    params.require(:data).permit(:post_id, :user_id)
  end
end
