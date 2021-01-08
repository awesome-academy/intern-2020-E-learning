class UserLecture < ApplicationRecord
  USER_LECTURE_PARAMS = %i(course_lecture_id user_id status).freeze
  enum status: {not_learn: 0, learned: 1}

  belongs_to :user
  belongs_to :course_lecture

  validates :status, inclusion: {in: statuses.keys}

  scope :by_user_id, (lambda do |user_id|
    where user_id: user_id if user_id.present?
  end)

  scope :by_course_lecture_ids, (lambda do |course_lecture_ids|
    where course_lecture_id: course_lecture_ids if course_lecture_ids.present?
  end)

  after_commit :update_num_lecture, on: :create

  private

  def update_num_lecture
    course_lecture = CourseLecture.find_by id: course_lecture_id
    course = Course.find_by id: course_lecture.course_id
    user_course = UserCourse.find_by user_id: user_id, course_id: course.id
    user_course.update_attributes(num_lecture: user_course.num_lecture+1)
  end
end
