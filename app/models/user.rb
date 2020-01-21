class User < ApplicationRecord
  devise :omniauthable, omniauth_providers: %i[facebook]
  has_many :posts
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :likes
  has_many :liked_posts, through: :likes, source: :post
  has_many :comments
  has_one_attached :banner_picture
  has_one_attached :avatar
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :about, length: { maximum: 255 }
  validate :banner_file_format
  validate :avatar_file_format
 

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

  # get an array of users who have accepted friend requests
  def mutual_friend_ids
    friendships.where("\"accepted?\" = true").pluck(:friend_id)
  end

  def feed
    Post.where("user_id IN (:friend_ids) OR user_id = :user_id", friend_ids: mutual_friend_ids, user_id: id)
  end

  def set_avatar(size)
    avatar.variant(combine_options: {
        auto_orient: true,
        gravity: "center",
        resize: "#{size}x#{size}^",
        crop: "#{size}x#{size}+0+0"
      })
  end

  def set_banner(size)
    banner_picture.variant(combine_options: {
        auto_orient: true,
        gravity: "center",
        resize: "#{size*2}x#{size}^",
        crop: "#{size*2}x#{size}+0+0"
      })
  end

  def self.from_omniauth(auth)
    # If account with email already exists, link the user to this provider
    if existing_user = find_by(email: auth.info.email)
      existing_user.update_attributes(provider: auth.provider, uid: auth.uid) if existing_user.provider.nil? && existing_user.uid.nil?
    end
    where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.firstname = auth.info.first_name   # assuming the user model has a name
      user.lastname = auth.info.last_name
      # attach avatar via activestorage
      file = open(auth.info.image + "?type=large")
      user.avatar.attach(
        io: file,
        filename: "avatar.jpg",
        content_type: file.content_type
      )
      # user.avatar = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  private
    def banner_file_format
      # banner_picture is nil upon user creation, skip validation
      return if banner_picture.nil?
      if banner_picture.attached?
        errors.add(:banner_picture, " - not an image") unless banner_picture.image? 
      end
    end

    def avatar_file_format
      # banner_picture is nil upon user creation, skip validation
      return if avatar.nil?
      if avatar.attached?
        errors.add(:avatar, " - not an image") unless avatar.image? 
      end
    end

end
