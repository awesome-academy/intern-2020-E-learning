module UserCourseHelper
  def user_course user, course
    @user_course = UserCourse.find_by user_id: user.id, course_id: course.id
  end
end
