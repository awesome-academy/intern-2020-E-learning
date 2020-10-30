class User < ApplicationRecord
  USER_PARAMS = [:id,
                 :email,
                 :password,
                 :password_confirmation,
                 :user_detail,
                 :role_id,
                 user_detail_attributes: UserDetail::USER_DETAIL_PARAMS].freeze

  enum role: {admin: 0, user: 1, instructor: 2}

  has_one :user_detail, dependent: :destroy, inverse_of: :user
  has_many :user_courses, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :courses, through: :instructor_courses, dependent: :destroy
  has_many :courses, through: :user_courses, dependent: :destroy

  validates :email, presence: true,
    length: {maximum: Settings.email.max_length},
    format: {with: URI::MailTo::EMAIL_REGEXP},
    uniqueness: {case_sensitive: false}
  validates :password, presence: true,
    length: {minimum: Settings.password.min_length},
    allow_nil: true
  validates :role, inclusion: {in: roles.keys}

  has_secure_password

  before_save :downcase_email

  accepts_nested_attributes_for :user_detail, allow_destroy: true

  private

  def downcase_email
    email.downcase!
  end
end
