class UserCourseMailer < ApplicationMailer
  def change_status user_course
    @user_course = user_course
    user = user_course.user
    mail to: user.email,
             subject: I18n.t("mail.status_change_title",
                             course_name: user_course.course.name)
  end
end
