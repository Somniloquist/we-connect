class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  def accept
    mutual_friendship = Friendship.where(user_id: self.friend_id, friend_id: self.user_id).first
    self.update_attribute(:accepted?, true)
    mutual_friendship.update_attribute(:accepted?, true)
  end
end
