class UserCoursesController < ApplicationController
  before_action :logged_in_user, only: %i(create)
  before_action :get_courses, only: :index
  before_action :get_user_course, :user_course_params, only: :update
  before_action :get_users_and_courses, only: :update
  after_action :get_course_lectures, only: :new

  def index
    @courses = Course.active
                     .page(params[:page])
                     .per Settings.user_course_per
  end

  def new
    @course = Course.find_by id: params[:course_id]
    @user_course = UserCourse.find_by course_id: params[:course_id]
    return unless @user_course&.learning?

    flash[:success] = t "message.course.welcome_back"
    redirect_to course_lectures_path(course_id: params[:course_id])
  end

  def create
    create_student_course_relationship
    if @user_course.save
      flash[:warning] = t "message.enroll.wait"
      redirect_to root_path
    else
      flash.now[:danger] = t "message.enroll.fail"
    end
  end

  def update
    if @user_course.update user_course_params
      flash[:success] = t "user_course.update_success"
    else
      flash[:fail] = t "user_course.update_fail"
      redirect_to courses_path
    end
  end

  private

  def create_student_course_relationship
    @user_course = UserCourse.new
    @user_course.course_id = params[:course_id]
    @user_course.user_id = get_current_user.id
    @user_course.status = UserCourse.statuses[:pending]
    @user_course.relationship = UserCourse.relationships[:student]
  end

  def get_courses
    @courses = Course.by_name(params[:text_search])
                     .by_description(params[:text_search])
  end

  def get_user_course
    @user_course = UserCourse.find_by id: params[:id]
    return if @user_course

    flash[:danger] = "message.user_course.not_found"
    redirect_to courses_path
  end

  def user_course_params
    params.require(:user_course).permit UserCourse::USER_COURSE_PARAMS
  end

  def get_users_and_courses
    @course = Course.find_by(id: @user_course.course_id)
    @users = @course.users
  end

  def get_course_lectures
    if @course
      @course_lecture = @course.course_lecture
    else
      flash[:danger] = t "message.course.not_found"
      redirect_to user_course_list_path
    end
  end
end
