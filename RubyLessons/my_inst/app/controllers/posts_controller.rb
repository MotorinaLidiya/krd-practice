class PostsController < ApplicationController
  before_action :authorize
  before_action :set_actions, only: %i[index profile]

  def index
    @posts = Post.includes(:author, :reactions, :comments).where.not(author: current_user).order(created_at: :desc)
  end

  def profile
    @posts = current_user.posts.includes(:author, :reactions, :comments).order(created_at: :desc)
  end

  def new
    @post = Post.new(author: current_user)
  end

  def create
    @post = Post.new(post_params.merge(author: current_user))

    if @post.save
      redirect_to profile_path, notice: 'Post was successfully created'
    else
      debugger
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to profile_path, notice: 'Post was successfully updated'
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to profile_path, notice: 'Post was successfully destroyed'
    else
      redirect_to profile_path, alert: 'Post was not destroyed'
    end
  end
  
  private

  def post_params
    params.require(:post).permit(
      :title,
      images: []
    )
  end

  def authorize
    authorize! :post
  end

  def set_actions
    @post_reactions = Post::Reaction.group_by_posts(current_user.id)
    @post_comments = Post::Comment.group_by_posts
  end
end
