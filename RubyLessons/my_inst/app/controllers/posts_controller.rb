class PostsController < ApplicationController
  before_action :authorize, except: %i[edit update destroy]
  before_action :set_post, only: %i[edit update destroy]

  def index
    @user = current_user
    @posts = Post.includes(:author, :reactions, :comments).where.not(author: current_user).order(created_at: :desc)
    @post_reactions = Post::Reaction.group_by_posts(current_user.id)
    @post_comments = Post::Comment.group_by_posts
  end

  def new
    @post = Post.new(author: current_user)
  end

  def create
    @post = Post.new(post_params.merge(author: current_user))

    if @post.save
      redirect_to profile_path, notice: 'Post was successfully created'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to profile_path, notice: 'Post was successfully updated'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy

    if @post.destroyed?
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

  def set_post
    @post = Post.find(params[:id])
    authorize! @post
  end
end
