class AddNumLectureToUserCourses < ActiveRecord::Migration[6.0]
  def change
    add_column :user_courses, :num_lecture, :integer
  end
end
