class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_commentable

  def new
    @comment = Comment.new
  end

  def create
  end

  def delete
  end

  private
    # Assigns commentable id whether parent is a post or another comment
    def find_commentable
      @commentable = Post.find(params[:post_id]) if params[:post_id]
      @commentable = Comment.find(params[:comment_id]) if params[:comment_id]
    end
end
