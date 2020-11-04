class CourseLecture < ApplicationRecord
  COURSE_LECTURE_PARAMS =
    %i(id name number video_link course_id _destroy).freeze

  belongs_to :course

  scope :order_by_number, ->{order number: :asc}
  scope :get_next_number, (lambda do |current_num|
    where "number > ?", current_num if current_num.present?
  end)
  scope :get_previous_number, (lambda do |current_num|
    where "number < ?", current_num if current_num.present?
  end)
end
