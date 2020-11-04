class CoursesController < ApplicationController
  before_action :get_course, only: %i(edit update destroy)

  def index
    @courses = Course.order_by_created_at.page(params[:page]).per Settings.per
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new course_params
    if @course.save
      flash[:info] = t "message.course.create_success"
      redirect_to courses_path
    else
      flash.now[:danger] = t "message.course.create_fail"
      render :new
    end
  end

  def update
    if @course.update course_params
      flash[:success] = t "message.course.update_success"
      redirect_to courses_path
    else
      flash.now[:danger] = t "message.course.update_fail"
      render :edit
    end
  end

  def edit; end

  def destroy
    @course.status = 0
    if @course.save
      flash[:info] = t "message.course.create_success"
      redirect_to courses_path
    else
      flash.now[:danger] = t "message.course.create_fail"
      render :new
    end
  end

  private

  def course_params
    params.require(:course).permit Course::COURSE_PARAMS
  end

  def get_course
    @course = Course.find_by id: params[:id]
    return if @course

    flash[:danger] = t "message.course.not_found"
    redirect_to courses_path
  end
end
