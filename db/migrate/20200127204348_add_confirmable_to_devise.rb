class AddConfirmableToDevise < ActiveRecord::Migration[5.2]
  def up
    add_column :users, :confirmation_token, :string
    add_column :users, :confirmed_at, :datetime
    add_column :users, :confirmation_sent_at, :datetime
    add_index :users, :confirmation_token, unique: true
    # To avoid a short time window between running the migration and updating all existing
    User.update_all confirmed_at: DateTime.now
  end

  def down
    remove_columns :users, :confirmation_token, :confirmed_at, :confirmation_sent_at
  end
end
