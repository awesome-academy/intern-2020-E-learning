class CourseLecture < ApplicationRecord
  COURSE_LECTURE_PARAMS =
    %i(id name number video_link course_id _destroy).freeze

  belongs_to :course

  validates :name, :video_link, presence: true
  validates :number,
    presence: true,
    numericality: {only_integer: true},
    uniqueness: {scope: :course_id}

  scope :order_by_number, ->{order number: :asc}
  scope :get_next_number, ->(current_num){where "number > ?", current_num}
  scope :get_previous_number, ->(current_num){where "number < ?", current_num}
end
