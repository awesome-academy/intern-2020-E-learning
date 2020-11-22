class CourseLecturesController < ApplicationController
  before_action :get_course, :get_course_lectures, only: %i(index show)
  before_action :redirect_lecture, only: :show

  def index; end

  def show
    @course_lecture = @course.course_lecture.find_by number: params[:number]
    redirect_to course_lectures_path unless @course_lecture
  end

  private

  def get_course
    @course = Course.find_by id: params[:course_id]
    return if @course

    flash[:danger] = t "message.course.not_found"
    redirect_to admin_courses_path
  end

  def get_course_lectures
    @course_lectures = @course.course_lecture
                              .order_by_number
  end

  def redirect_lecture
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
    return if @course_lecture

    flash[:success] = t "message.course.first_course"
    redirect_to course_lectures_path(course_id: params[:course_id])
  end
end
