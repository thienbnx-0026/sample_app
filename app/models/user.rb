class User < ApplicationRecord
  before_save :downcase_email
  validates :name, presence: true,
    length: {maximum: Settings.maximum_length_name}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
    length: {maximum: Settings.maximum_length_email},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password,
    presence: true,
    length: {minimum: Settings.minimum_length_pass}

  def self.digest string
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine.MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create string, cost: cost
  end

  def downcase_email
    email.downcase!
  end
end
