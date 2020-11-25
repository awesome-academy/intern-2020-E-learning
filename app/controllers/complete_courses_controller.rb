class CompleteCoursesController < ApplicationController
  before_action :get_similar_course, only: :index

  def index; end

  private

  def get_similar_course
    @courses = []
    return if params[:category_ids].blank?

    course_ids_category = CourseCategory.by_category_ids(params[:category_ids])
                                        .pluck :course_id
    course_ids_learned = UserCourse.by_user_id(current_user.id)
                                   .pluck :course_id
    course_ids = course_ids_category.select {
      |id| course_ids_learned.exclude? id
    }
    @courses = Course.by_ids(course_ids).limit Settings.limit_course_suggest
  end
end
