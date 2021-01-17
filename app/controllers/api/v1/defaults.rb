module API
  module V1
    module Defaults
      extend ActiveSupport::Concern

      included do
        prefix "api"
        version "v1", using: :path
        format :json

        helpers API::Helpers::AuthenticateHelpers

        rescue_from ActiveRecord::RecordNotFound do |e|
          error_response(message: e.message, status: 404)
        end

        rescue_from :all do |e|
          raise e if Rails.env.development?

          error_response(message: e.message, status: 500)
        end

        helpers do
          def api_error! message, error_code, status, header
            error!({message: message, code: error_code}, status, header)
          end

          def response_success data
            {status: :success, data: data.as_json}
          end
        end
      end
    end
  end
end
