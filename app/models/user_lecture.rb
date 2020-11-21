class UserLecture < ApplicationRecord
  enum status: {not_learn: 0, learned: 1}

  belongs_to :user
  belongs_to :course_lecture

  validates :user_id, :course_lecture_id, presence: true
  validates :status, inclusion: {in: statuses.keys}

  scope :by_user_id, (lambda do |user_id|
    where user_id: user_id if user_id.present?
  end)
  scope :by_course_lecture_ids, (lambda do |course_lecture_ids|
    where course_lecture_id: course_lecture_ids if course_lecture_ids.present?
  end)
end
