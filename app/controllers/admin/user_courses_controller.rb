class Admin::UserCoursesController < Admin::BaseController
  def update
    user_course = UserCourse.find params[:id]
    @users = user_course.course.users
    if user_course.update user_course_params
      flash[:success] = t "message.user_course.update_success"
      SendEmailJob.perform_later user_course
    else
      flash[:danger] = t "message.user_course.update_fail"
      redirect_to courses_path
    end
  end

  private

  def user_course_params
    params.require(:user_course).permit UserCourse::USER_COURSE_PARAMS
  end
end
