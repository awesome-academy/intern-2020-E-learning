class CourseCategory < ApplicationRecord
  belongs_to :course
  belongs_to :category

  scope :by_category_ids, (lambda do |category_ids|
    where category_id: category_ids if category_ids.present?
  end)
end
