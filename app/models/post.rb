class Post < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  belongs_to :user
  has_many :likes
  has_many :likes_users, through: :likes, source: :user
  has_many :comments, as: :commentable
  validates :user_id, presence: true
  validates :body, presence: true
end
