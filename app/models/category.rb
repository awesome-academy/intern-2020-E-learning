class Category < ApplicationRecord
  CATEGORY_PARAMS = %i(name description).freeze()

  has_many :course_categories, dependent: :destroy
  has_many :courses, through: :course_categories, dependent: :restrict_with_error

  validates :name, presence: true,
    length: {maximum: Settings.name.max_length,
             minimum: Settings.name.min_length}
  validates :description, presence: true,
    length: {maximum: Settings.description.max_length}

  scope :order_by_created_at, ->{order created_at: :desc}

  scope :by_name, (lambda do |name|
    where "name LIKE ?", "%#{name}%" if name.present?
  end)

  scope :by_description, (lambda do |description|
    where "description LIKE ?", "%#{description}%" if description.present?
  end)

  scope :published_in_month, (lambda do |date|
    where "MONTH(created_at) = ?", date.month
  end)

  class << self
    def trending
      # TODO Complete this
      # course_categories.select(:categories_id).group(:course_id).
    end

    def newest
      published_in_month(Time.zone.today).order_by_created_at
        .limit(Settings.limit_newest_cate)
    end
  end
end
