module API
  module V1
    class Users < Grape::API
      include API::V1::Defaults

      before do
        authenticate_user!
      end

      resource :users do
        desc "Return all users"
        get ":page/:per", root: :users do
          User.includes(:user_detail).page(params[:page]).per params[:per]
        end

        desc "Return a user"
        params do
          requires :id, type: String, desc: "ID of the user"
        end
        get ":id", root: "user" do
          User.find params[:id]
        end
      end
    end
  end
end
