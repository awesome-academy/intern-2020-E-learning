class CourseSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :status, :estimate_time, :created_at
end
