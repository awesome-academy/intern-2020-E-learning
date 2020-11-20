class UserCourse < ApplicationRecord
  USER_COURSE_PARAMS = %i(id status).freeze

  belongs_to :user
  belongs_to :course
  enum status: {learning: 0, pending: 1, finish: 2, not_allowed: 3}
  enum relationship: {student: 0, instructor: 1}

  validates :user_id, :course_id, presence: true
  validates :status, inclusion: {in: statuses.keys}
  validates :relationship, inclusion: {in: relationships.keys}
end
