class AddDefaultValueToCourseStatus < ActiveRecord::Migration[6.0]
  def change
    change_column :courses, :status, :integer, default: 0
  end
end
