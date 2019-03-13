class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id
    @comment.post_id = params[:post_id]

    if @comment.save
      render json: @comment
    else
      render json: @comment.errors.full_messages
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
