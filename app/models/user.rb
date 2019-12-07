class User < ApplicationRecord
  has_many :friendships
  has_many :friends, through: :friendships
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :birthday, presence: true
  validates :gender, presence: true

  def add_friend(other_user)
    friends << other_user
    other_user.friends << self
  end

  def remove_friend(other_user)
    friends.delete(other_user)
    other_user.friends.delete(self)
  end

end
