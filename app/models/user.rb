class User < ApplicationRecord
  has_many :posts
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :likes
  has_many :liked_posts, through: :likes, source: :post
  has_many :comments
  has_one_attached :banner_picture
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :birthday, presence: true
  validates :gender, presence: true
  validates :about, length: { maximum: 255 }
  validate :file_format
 

  def fullname
    "#{firstname} #{lastname}"
  end

  def add_friend(other_user)
    # build mutual friendships
    friendships.build(friend_id: other_user.id, requested_by_id: id).save
    other_user.friendships.build(friend_id: id, requested_by_id: id).save
  end

  def remove_friend(other_user)
    friends.delete(other_user)
    other_user.friends.delete(self)
  end

  def friends_with?(other_user)
    self.friends.where(id: other_user.id).empty? ? false : true
  end

  def friend_requests
    Friendship.joins(:user).where(friend_id: id, accepted?: false)
                           .where.not(requested_by_id: id)
  end

  def like(post)
    post.likes.build(user: self).save
  end

  def unlike(like)
    like.delete
  end

  def likes?(post)
    likes.find_by(post_id:  post.id) ? true : false
  end

  def has_pending_friend_requests?
    friend_requests.count > 0
  end

  def feed
    Post.where("user_id IN (:friend_ids) OR user_id = :user_id", friend_ids: friend_ids, user_id: id)
  end

  private
    def file_format
      errors.add(:banner_picture, "is missing!") unless banner_picture.attached?
      errors.add(:banner_picture, " - not an image") unless banner_picture.image?
    end

end
