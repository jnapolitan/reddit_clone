class PostsController < ApplicationController
  before_action :require_user_owns_post!, only: [:edit, :update]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id

    if @post.save
      render json: @post
    else
      render json: @post.errors.full_messages
    end
  end

  def show
    @post = Post.find(params[:id])
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors.full_messages
    end
  end

  private

  def post_params
    params.require(:post).permit(
      :title, :url, :content, sub_ids: []
    )
  end

  def require_user_owns_post!
    return if current_user.posts.find(params[:id])

    render json: ['Only the post owner can edit.']
  end
end
