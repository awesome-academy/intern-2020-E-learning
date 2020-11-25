class Admin::UserCoursesController < Admin::BaseController
  before_action :get_user_course, :user_course_params, :get_users_and_courses,
   only: :update

  def update
    if @user_course.update user_course_params
      flash[:success] = t "user_course.update_success"
    else
      flash[:fail] = t "user_course.update_fail"
      redirect_to courses_path
    end
  end

  private

  def user_course_params
    params.require(:user_course).permit UserCourse::USER_COURSE_PARAMS
  end

  def get_user_course
    @user_course = UserCourse.find_by id: params[:id]
    return if @user_course

    flash[:danger] = "message.user_course.not_found"
    redirect_to admin_courses_path
  end

  def get_users_and_courses
    @course = Course.find_by(id: @user_course.course_id)
    @users = @course.users
  end
end
