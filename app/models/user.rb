class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  normalizes :email_address, with: ->(e) { e.strip.downcase }

  enum :account_type, {
    student: 0,
    teacher: 1,
    administrator: 2
  }
end
