class AddAvatarsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :avatars, :json
  end
end
