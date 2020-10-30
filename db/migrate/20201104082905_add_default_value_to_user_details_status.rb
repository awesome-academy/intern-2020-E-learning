class AddDefaultValueToUserDetailsStatus < ActiveRecord::Migration[6.0]
  def change
    change_column :user_details, :status, :integer, default: 1
  end
end
