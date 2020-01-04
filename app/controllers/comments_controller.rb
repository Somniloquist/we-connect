class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_commentable

  def new
    @comment = Comment.new
  end

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:succes] = "Comment posted!"
    else
      flash[:warning] = "Something went wrong, please try again."
    end
    redirect_back fallback_location: post_path(@comment.parent_post)
  end

  def delete
  end

  private
    def comment_params
      params.require(:comment).permit(:body)
    end
    # Assigns commentable id whether parent is a post or another comment
    def find_commentable
      @commentable = Post.find(params[:post_id]) if params[:post_id]
      @commentable = Comment.find(params[:comment_id]) if params[:comment_id]
    end
end
