class User < ApplicationRecord
  audited
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_one :enrollment, dependent: :destroy
  has_one :course, through: :enrollment
  has_many :units, through: :course
  has_many :topics, through: :units

  normalizes :email_address, with: ->(e) { e.strip.downcase }
  validates :email_address, presence: true, uniqueness: true
  validates :first_name, :last_name, presence: true

  enum :account_type, {
    student: 0,
    teacher: 1,
    administrator: 2
  }

  def full_name
    "#{first_name} #{last_name}"
  end
end
