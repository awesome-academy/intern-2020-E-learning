class Admin::InstructorsController < Admin::BaseController
  before_action :create_instructor_params, only: :create

  def index; end

  def new; end

  def create
    user_course = UserCourse.new user_course_params
    if user_course.save
      flash[:success] = t "message.user_course.successful"
    else
      flash.now[:danger] = t "message.user_course.fail"
    end
    redirect_to user_courses_path
  end

  private

  def get_courses
    @courses
  end

  def user_course_params
    params.require(:user_course).permit UserCourse::USER_COURSE_PARAMS
  end

  def create_instructor_params
    params.merge! user_course:
      {user_id: current_user.id,
      course_id: params[:course_id]
      relationship: UserCourse.relationships[:instructor]}
  end
end
