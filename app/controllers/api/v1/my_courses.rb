module API
  module V1
    class MyCourses < Grape::API
      include API::V1::Defaults

      before do
        authenticate_user!
      end

      resource :my_courses do
        desc "Return all courses user participate in"
        get "/:page/:per", root: :my_courses do
          course_ids = current_user.user_courses
                                   .by_status(params[:status])
                                   .pluck(:course_id)
                                   .uniq
          Course.active
                .includes(:user_courses)
                .references(:user_courses)
                .by_ids(course_ids)
                .page(params[:page])
                .per params[:per]
        end
      end
    end
  end
end
