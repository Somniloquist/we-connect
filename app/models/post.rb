class Post < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  belongs_to :user
  has_many :likes
  has_many :likes_users, through: :likes, source: :user
  has_many :comments, as: :commentable
  validates :user_id, presence: true
  validates :body, presence: true
  has_one_attached :image

  def set_image(size, crop)
    if crop
      image.variant(combine_options: {
          auto_orient: true,
          gravity: "center",
          resize: "#{size}x#{size}^",
          crop: "#{size}x#{size}+0+0"
        })
           else
      image.variant(combine_options: {
          auto_orient: true,
          gravity: "center",
          resize: "#{size}x#{size}^"
        })
    end
  end

end
