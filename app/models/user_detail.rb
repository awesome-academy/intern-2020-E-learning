class UserDetail < ApplicationRecord
  USER_DETAIL_PARAMS = %i(id name birthday workplace location status).freeze

  enum status: {unactive: 0, active: 1}

  belongs_to :user, optional: true

  validates :name, presence: true,
    length: {maximum: Settings.name.max_length,
             minimum: Settings.name.min_length}
  validates :birthday, presence: true
  validates :workplace, :location, presence: true,
            allow_nil: true
  validates :status, inclusion: {in: statuses.keys}

  before_validation :valid_age

  private

  def valid_age
    return if valid_birthday_range.include?(birthday)

    errors.add :birthday, I18n.t("errors.invalid_birthday")
  end

  def valid_birthday_range
    maximum_date..minimum_date
  end

  def minimum_date
    12.years.ago.to_date
  end

  def maximum_date
    100.years.ago.to_date
  end
end
