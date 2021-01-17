module API
  module V1
    class Courses < Grape::API
      include API::V1::Defaults

      before do
        authenticate_user!
      end

      helpers do
        def course_params
          ActionController::Parameters.new(params[:course])
                                      .permit Course::COURSE_PARAMS
        end
      end

      resource :courses do
        desc "Return all courses"
        get ":page/:per", root: :courses do
          Course.page(params[:page]).per params[:per]
        end

        desc "Return a course"
        params do
          requires :id, type: String, desc: "ID of the course"
        end
        get ":id", root: "course" do
          Course.find params[:id]
        end

        desc "Create course"
        params do
          requires :course, type: Hash do
            requires :name, type: String, desc: "name of the course"
            requires :description,
                     type: String,
                     desc: "description of the course"
            requires :status, type: String, desc: "status of the course"
          end
        end
        post "", root: "course" do
          Course.create! course_params
        end
      end
    end
  end
end
