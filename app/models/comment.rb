class Comment < ApplicationRecord
  after_create :increment_count
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable
  validates :body, presence: true

  # searches for and returns the post this comment belongs to
  def parent_post
    get_parent_post
  end

  private

    def get_parent_post
      parent = commentable
      # Keep searching until a post is found (non comment)
      while parent.is_a? Comment
        parent = parent.commentable
      end

      parent
    end

    def increment_count
      parent = get_parent_post
      parent.increment! :comments_count
    end
end
