class Post < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :likes_users, through: :likes, source: :user
  validates :user_id, presence: true
  validates :body, presence: true
  default_scope -> { order(created_at: :desc) }
end
