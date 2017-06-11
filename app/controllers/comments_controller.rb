class CommentsController < ApplicationController
  before_action :set_comment, only: [:create, :destroy]
  
  def create
    @comment = @blog.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
     ActionCable.server.broadcast "comments", render(partial: 'comments/comment', object: @comment)
     #flash[:success] = "Comment was created successfully"
     #redirect_to recipe_path(@recipe)
    else
     flash[:danger] = "Comment was not created"
     redirect_to :back
    end
  end
  
  def destroy
    @comment = @blog.comments.find(params[:id])
    @comment.destroy
    redirect_to @blog
  end

  private
  
  def set_comment
    @blog = Blog.friendly.find(params[:blog_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end


 