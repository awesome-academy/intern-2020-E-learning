class SendEmailJob < ApplicationJob
  queue_as :default

  def perform user_course
    UserCourseMailer.change_status(user_course).deliver_now
  end
end
