class UserLecture < ApplicationRecord
  enum status: {not_learn: 0, learned: 1}

  belongs_to :user
  belongs_to :course_lecture

  validates :user_id, :course_lecture_id, presence: true
  validates :status, inclusion: {in: statuses.keys}
end
