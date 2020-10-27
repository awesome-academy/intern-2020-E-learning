class User < ApplicationRecord
  has_one :user_details, dependent: :delete_all
  has_many :user_courses, dependent: :delete_all
  has_many :comments, dependent: :destroy
  has_many :instructor_courses, dependent: :destroy
  has_many :courses, through: :user_courses, dependent: :destroy
end
