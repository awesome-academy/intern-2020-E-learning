class Admin::StudentManagementsController < Admin::BaseController
  def index
    course_ids = if params[:pending]
                   UserCourse.by_status(Settings.status.pending)
                             .pluck(:course_id)
                             .uniq
                 end

    @q = Course.ransack params[:q], auth_object: set_ransackable_auth_object
    @courses = @q.result
                 .active
                 .order_by_created_at
                 .by_ids(course_ids)
                 .page(params[:page])
                 .per Settings.per
  end

  def show
    @course = Course.find params[:id]
    @users = User.includes(:user_courses)
                 .references(:user_courses)
                 .by_course_id @course.id
  end
end
