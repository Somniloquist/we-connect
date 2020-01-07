class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_commentable, only: [:new, :create, :delete]

  def new
    @comment = @commentable.comments.new
    # jquery uses commentable_id to target the dynamic form
    @commentable_id = @commentable.id
    respond_to do |format|
      format.html { render :new }
      format.js
    end
  end

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:success] = "Comment posted!"
    else
      flash[:warning] = "Something went wrong, please try again."
    end
    redirect_back fallback_location: post_path(@comment.parent_post)
  end

  def delete
  end

  def toggle_form
    @commentable = Comment.find(params[:id])
    respond_to :js
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
