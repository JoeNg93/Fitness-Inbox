class Client < ApplicationRecord

  # BEFORE ACTIONS
  before_save :downcase_email

  # VALIDATES
  validates :name, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 100 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

  validates :role, presence: true

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  private

  def downcase_email
    email.downcase!
  end

end
