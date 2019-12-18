module ApplicationHelper
  def friend_requests
  friend_requests = Friendship.joins(:user)
                              .where(friend_id: current_user, accepted?: false)
                              .where.not(requested_by_id: current_user.id).count
  end
end
