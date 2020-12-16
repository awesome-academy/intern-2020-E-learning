module UserLecturesHelper
  def learned_lecture? course_lecture
    course_lecture.user_lectures.first&.learned?
  end
end
