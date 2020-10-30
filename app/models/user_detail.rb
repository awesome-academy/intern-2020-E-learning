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
end
