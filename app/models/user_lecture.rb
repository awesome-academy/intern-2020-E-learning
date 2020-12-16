class UserLecture < ApplicationRecord
  USER_LECTURE_PARAMS = %i(course_lecture_id user_id status).freeze
  enum status: {not_learn: 0, learned: 1}

  belongs_to :user
  belongs_to :course_lecture

  validates :status, inclusion: {in: statuses.keys}
end
