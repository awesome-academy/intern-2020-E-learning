class User < ApplicationRecord
  USER_PARAMS = %i(name email password password_confirmation).freeze

  has_one :user_details, dependent: :destroy
  has_many :user_courses, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :course, through: :instructor_courses, dependent: :destroy
  has_many :courses, through: :user_courses, dependent: :destroy

  validates :email, presence: true,
    length: {maximum: Settings.email.max_length},
    format: {with: URI::MailTo::EMAIL_REGEXP},
    uniqueness: {case_sensitive: false}
  validates :password, presence: true,
    length: {minimum: Settings.password.min_length},
    allow_nil: true

  before_save :downcase_email

  has_secure_password

  private

  def downcase_email
    email.downcase!
  end
end
