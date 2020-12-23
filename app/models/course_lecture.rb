class CourseLecture < ApplicationRecord
  COURSE_LECTURE_PARAMS =
    %i(id name number video_link course_id _destroy).freeze

  belongs_to :course
  has_many :user_lectures, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  validates :name, :video_link, presence: true
  validates :number, presence: true,
                     numericality: {only_integer: true},
                     uniqueness: {scope: :course_id}

  scope :order_by_number, ->{order number: :asc}

  scope :get_next_number, (lambda do |current_num|
    where "number > ?", current_num if current_num.present?
  end)

  scope :get_previous_number, (lambda do |current_num|
    where "number < ?", current_num if current_num.present?
  end)

  scope :by_course_id, (lambda do |course_id|
    where course_id: course_id if course_id.present?
  end)
end
