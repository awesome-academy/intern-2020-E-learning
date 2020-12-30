class CourseLecturesController < ApplicationController
  before_action :logged_in_user,
                :get_course,
                :correct_learning_user,
                :get_course_lectures,
                only: %i(index show)
  before_action :redirect_lecture, only: :show

  load_and_authorize_resource

  def index; end

  def show
    @course_lecture = @course.course_lecture
                             .find_by number: params[:number]
    create_comment_and_get_comments @course_lecture
    create_user_lecture_params
    current_user.user_lectures.find_or_create_by user_lecture_params
    redirect_to course_lectures_path unless @course_lecture
  end

  private

  def get_course_lectures
    @course_lectures = @course.course_lecture
                              .includes(:user_lectures)
                              .order_by_number
  end

  def redirect_lecture
    @user_lectures = current_user.user_lectures
    if params[:method].eql? "next"
      next_lecture
    elsif params[:method].eql? "previous"
      previous_lecture
    end
    return unless @course_lecture

    redirect_to course_lecture_path(id: @course_lecture.id,
                                    number: @course_lecture.number,
                                    course_id: params[:course_id])
  end

  def next_lecture
    @course_lecture = @course.course_lecture
                             .get_next_number(params[:number])
                             .order_by_number
                             .first
    return if @course_lecture.present?

    flash[:success] = t "message.course.complete_course"
    redirect_to course_lectures_path(course_id: params[:course_id])
  end

  def previous_lecture
    @course_lecture = @course.course_lecture
                             .get_previous_number(params[:number])
                             .order_by_number
                             .last
    return if @course_lecture.present?

    flash[:success] = t "message.course.first_course"
    redirect_to course_lectures_path(course_id: params[:course_id])
  end

  def get_course
    @course = Course.find_by id: params[:course_id]
    return if @course

    flash[:danger] = t "message.course.not_found"
    redirect_to user_courses_path
  end

  def create_user_lecture_params
    params.merge! user_lecture: {course_lecture_id: @course_lecture.id,
                                 user_id: current_user.id,
                                 status: UserLecture.statuses[:learned]}
  end

  def user_lecture_params
    params.require(:user_lecture).permit UserLecture::USER_LECTURE_PARAMS
  end

  def correct_learning_user
    user_course = current_user.user_courses.find_by course_id: @course.id
    return if user_course&.learning? || user_course&.finish?

    flash[:danger] = t "message.user.require_login"
    redirect_to login_path
  end
end
