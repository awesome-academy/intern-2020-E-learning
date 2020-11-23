class UserCoursesController < ApplicationController
  before_action :logged_in_user, :create_student_course_params, only: :create
  before_action :get_course, only: :new

  def index
    @courses = Course.active
                     .page(params[:page])
                     .per Settings.user_course_per
  end

  def new
    return unless current_user.enrolled_course? params[:course_id]

    flash[:success] = t "message.course.welcome_back"
    redirect_to course_lectures_path(course_id: params[:course_id])
  end

  def create
    user_course = UserCourse.new user_course_params
    if user_course.save
      flash[:success] = t "message.enroll.success"
      redirect_to course_lectures_path(course_id: params[:course_id])
    else
      flash.now[:danger] = t "message.enroll.fail"
      redirect_to new_user_course_path(course_id: params[:course_id])
    end
  end

  private

  def user_course_params
    params.require(:user_course).permit UserCourse::USER_COURSE_PARAMS
  end

  def create_student_course_params
    params.merge! user_course:
      {course_id: params[:course_id],
       user_id: current_user.id,
       status: UserCourse.statuses[:learning],
       relationship: UserCourse.relationships[:student]}
  end

  def get_course
    @course = Course.find_by id: params[:course_id]
    return if @course

    flash[:danger] = t "message.course.not_found"
    redirect_to user_courses_path
  end
end
