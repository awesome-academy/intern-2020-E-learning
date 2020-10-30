class Course < ApplicationRecord
  COURSE_PARAMS = %i(name description status estimate_time).freeze
  enum status: {unactive: 0, active: 1, on_progress: 2}

  has_many :categories, through: :course_categories, dependent: :destroy
  has_many :user_courses, dependent: :destroy
  has_many :instructor_courses, dependent: :destroy
  has_many :course_lectures, dependent: :destroy
  has_many :course_categories, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :courses, through: :user_courses, dependent: :destroy
  has_many :categories, through: :course_categories, dependent: :destroy

  validates :status, inclusion: {in: statuses.keys}

  scope :order_by_created_at, ->{order created_at: :desc}
end
