class AddDefaultValueToUsersAbout < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :about, :string, :default => ""
  end
end
