class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc)

    @post_reactions = Post::Reaction.group_by_posts(current_user.id)
    @post_comments = Post::Comment.group_by_posts 
  end

  def create
    @user_to_subscribe = User.find(params[:user_id])
    current_user.subscribe_to(@user_to_subscribe)
    redirect_to @user_to_subscribe, notice: 'You are now subscribed.'
  end

  def destroy
    @user_to_unsubscribe = User.find(params[:user_id])
    current_user.unsubscribe_from(@user_to_unsubscribe)
    redirect_to @user_to_unsubscribe, notice: 'You have unsubscribed.'
  end
end
