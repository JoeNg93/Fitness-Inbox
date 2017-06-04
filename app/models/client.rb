class Client < ApplicationRecord

  # BEFORE ACTIONS
  before_save :downcase_email

  # RELATIONSHIPS
  has_many :unread_messages, -> { Message.unread }, class_name: 'Message', foreign_key: 'receiver_id'

  # VALIDATES
  validates :name, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 100 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

  validates :role, presence: true

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  private

  def downcase_email
    email.downcase!
  end

end
