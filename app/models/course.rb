class Course < ApplicationRecord
  has_many :categories, through: :course_categories, dependent: :destroy
  has_many :user_courses, dependent: :destroy
  has_many :instructor_courses, dependent: :destroy
  has_many :course_lectures, dependent: :destroy
  has_many :course_categories, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :courses, through: :user_courses, dependent: :destroy
  has_many :categories, through: :course_categories, dependent: :destroy
end
