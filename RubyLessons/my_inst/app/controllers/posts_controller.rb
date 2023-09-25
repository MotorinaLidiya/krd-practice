class PostsController < ApplicationController
  def index
    @posts = Post.includes(:author, :image, :reactions).where.not(author: current_user)
    @post_reactions = Post.with_reactions
    authorize! @posts
  end

  def profile
    @posts = Post.includes(:author, :image, :reactions).where(author: current_user)
    @post_reactions = Post.with_reactions
    authorize! @posts
  end

  def new
    @post = Post.new(author: current_user)
    authorize! @post
  end

  def create
    @post = Post.new(post_params.merge(author: current_user))
    authorize! @post

    if @post.save
      redirect_to posts_path, notice: 'Post was successfully created'
    else
      render :new
    end
  end

  def post_params
    params.require(:post).permit(
      :title,
      image_attributes: {
        photos: []
      }
    )
  end
end
