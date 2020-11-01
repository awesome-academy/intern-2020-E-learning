class CourseLecture < ApplicationRecord
  COURSE_LECTURE_PARAMS =
    %i(id name number video_link course_id _destroy).freeze

  belongs_to :course

  scope :order_by_number, ->{order number: :asc}
  scope :get_lecture_by_course, ->(course_id){where course_id: course_id}
end
