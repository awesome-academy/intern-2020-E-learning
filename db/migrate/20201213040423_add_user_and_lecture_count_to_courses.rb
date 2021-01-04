class AddUserAndLectureCountToCourses < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :user_courses_count, :integer
    add_column :courses, :course_lectures_count, :integer
  end
end
