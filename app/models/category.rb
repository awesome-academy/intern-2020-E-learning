class Category < ApplicationRecord
  has_many :course_categories, dependent: :destroy
  has_many :courses, through: :course_categories, dependent: :destroy
end
