module API
  module V1
    class Base < Grape::API
      error_formatter :json, API::ErrorFormatter
      mount API::V1::Users
      mount API::V1::Courses
      mount API::V1::MyCourses
      mount API::V1::Auth
      add_swagger_documentation(
        api_version: "v1",
        hide_documentation_path: true,
        mount_path: "/api/v1/swagger_doc",
        hide_format: true
      )
    end
  end
end
