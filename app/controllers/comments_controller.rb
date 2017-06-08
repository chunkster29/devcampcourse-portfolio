class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
  end
  
  def show 
    @comments = Comment.page(params[:page]).per(5)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end