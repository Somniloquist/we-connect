class AddRequestedByToFriendships < ActiveRecord::Migration[5.2]
  def change
    add_column :friendships, :requested_by_id, :bigint
  end
end
