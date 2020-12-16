class MyCoursesController < ApplicationController
  before_action :get_current_user_courses, only: :index

  def index
    authorize! :read, :my_courses
    @q = Course.ransack params[:q], auth_object: set_ransackable_auth_object
    @courses = @q.result
                 .active
                 .includes(:user_courses)
                 .references(:user_courses)
                 .by_ids(@course_ids)
                 .page(params[:page])
                 .per Settings.user_course_per
  end

  private

  def get_current_user_courses
    @course_ids = current_user.user_courses
                              .by_status(params[:status])
                              .pluck(:course_id)
                              .uniq
  end
end
