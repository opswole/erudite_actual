class User < ApplicationRecord
  # Security
  audited
  has_secure_password
  has_many :sessions, dependent: :destroy
  # Content Enrollment(s)
  has_one :enrollment, dependent: :destroy
  has_one :course, through: :enrollment
  has_many :units, through: :course
  has_many :topics, through: :units
  has_many :course_ownerships, dependent: :destroy
  has_many :owned_courses, through: :course_ownerships, source: :course
  # Messaging/Notifications
  has_many :messages, dependent: :destroy
  has_many :mentions, dependent: :destroy
  has_many :mentioned_messages, through: :mentions, source: :message
  # Avatar Stuff ('ake Sulleyyy')
  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [ 100, 100 ]
  end

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
