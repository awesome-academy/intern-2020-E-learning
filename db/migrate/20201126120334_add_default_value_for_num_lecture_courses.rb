class AddDefaultValueForNumLectureCourses < ActiveRecord::Migration[6.0]
  def change
    change_column :user_courses, :num_lecture, :integer, default: 0
  end
end
