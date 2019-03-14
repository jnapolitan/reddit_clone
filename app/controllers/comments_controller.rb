class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id
    @comment.post_id = params[:post_id]
    @comment.save
    flash[:errors] = @comment.errors.full_messages
    redirect_to sub_post_url(@comment.post.sub.id, @comment.post.id)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

end