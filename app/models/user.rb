class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  normalizes :email_address, with: ->(e) { e.strip.downcase }
  validates :email_address, presence: true, uniqueness: true
  validates :email_address, :first_name, :last_name, presence: true

  enum :account_type, {
    student: 0,
    teacher: 1,
    administrator: 2
  }

  def full_name
    "#{first_name} #{last_name}"
  end
end
