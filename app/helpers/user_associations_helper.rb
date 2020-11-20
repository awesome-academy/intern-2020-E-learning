module UserAssociationsHelper
  def user_course user, course
    @user_course = UserCourse.find_by user_id: user.id, course_id: course.id
  end

  def user_lecture user, course_lecture
    @user_lecture = UserLecture.find_by user_id: user.id, course_lecture_id: course_lecture.id
  end
end
