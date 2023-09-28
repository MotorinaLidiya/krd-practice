class UsersController < ApplicationController
  before_action :set_user, except: %i[profile subscribtions]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.includes(:author, :reactions, :comments).order(created_at: :desc)

    set_reactions
  end

  def profile
    authorize! :user
    @user = current_user
    @posts = @user.posts.includes(:author, :reactions, :comments).order(created_at: :desc)

    set_reactions
  end

  def subscribtions
    authorize! :user
    @user = current_user
    @posts = Post.where(author_id: @user.subscriptions.pluck(:owner_id))
                  .includes(:author, :reactions, :comments)
                  .order(created_at: :desc)
    set_reactions

  end

  def subscribe
    subscribtion = Subscribtion.new(owner: @user, subscriber: current_user)

    if subscribtion.save
      redirect_to user_path(@user), notice: 'You are successfully subscribed'
    else
      redirect_to user_path(@user), notice: 'Failed to subscribe'
    end
  end

  def unsubscribe
    subscribtion = Subscribtion.find_by(owner: @user, subscriber: current_user).destroy

    if subscribtion.destroyed?
      redirect_to user_path(@user), notice: 'You are successfully unsubscribed'
    else
      redirect_to user_path(@user), notice: 'Failed to unsubscribe'
    end
  end

  private

  def set_reactions
    @post_reactions = Post::Reaction.group_by_posts(@user.id)
    @post_comments = Post::Comment.group_by_posts 
  end

  def set_user
    @user = User.find(params[:id])
    authorize! @user
  end
end
