class PostsController < ApplicationController
  def index
    authorize! :post
    @posts = Post.includes(:author, :image, :reactions).where.not(author: current_user)
    @post_reactions = Post.with_reactions
  end

  def profile
    authorize! :post
    @posts = Post.includes(:author, :image, :reactions).where(author: current_user)
    @post_reactions = Post.with_reactions
  end

  def new
    authorize! :post
    @post = Post.new(author: current_user)
  end

  def create
    authorize! :post
    @post = Post.new(post_params.merge(author: current_user))

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
