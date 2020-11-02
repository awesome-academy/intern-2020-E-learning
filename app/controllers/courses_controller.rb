class CoursesController < ApplicationController
  def index
    @courses = Course.order_by_created_at.page(params[:page]).per Settings.per
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new course_params
    if @course.save
      flash[:info] = t "message.user.create_success"
      redirect_to courses_path
    else
      flash.now[:danger] = t "message.user.create_fail"
      render :new
    end
  end

  private

  def course_params
    params.require(:course).permit Course::COURSE_PARAMS
  end
end
