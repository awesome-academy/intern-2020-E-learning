class UserCoursesController < ApplicationController
  before_action :logged_in_user,
                :create_student_course_params,
                only: %i(create new)
  before_action :get_course_and_course_lectures, only: :new
  before_action :get_user_course,
                :user_course_params,
                :get_users_and_courses,
                only: :update

  def index
    @q = Course.ransack params[:q], auth_object: set_ransackable_auth_object
    @courses = @q.result
                 .active
                 .page(params[:page])
                 .per Settings.user_course_per
  end

  def new
    @course = Course.find_by id: params[:course_id]
    @user_course = current_user.user_courses
                               .find_by course_id: params[:course_id]
    return unless @user_course&.learning?

    flash[:success] = t "message.course.welcome_back"
    redirect_to course_lectures_path(course_id: params[:course_id])
  end

  def create
    user_course = UserCourse.new user_course_params
    if user_course.save
      flash[:warning] = t "message.enroll.wait"
      redirect_to user_courses_path
    else
      flash.now[:danger] = t "message.enroll.fail"
      redirect_to new_user_course_path(course_id: params[:course_id])
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

  def get_course_and_course_lectures
    @course = Course.find_by id: params[:course_id]
    if @course
      @course_lectures = @course.course_lecture
    else
      flash[:danger] = t "message.course.not_found"
      redirect_to user_courses_path
    end
  end

  def get_courses
    @courses = Course.by_name(params[:text_search])
                     .by_description params[:text_search]
  end

  def get_user_course
    @user_course = UserCourse.find_by id: params[:id]
    return if @user_course

    flash[:danger] = t "message.user_course.not_found"
    redirect_to courses_path
  end

  def get_users_and_courses
    @course = @user_course.course
    @users = @course.users
  end
end
