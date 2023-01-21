class Agent < ApplicationRecord
  has_many :meetings

  email_pattern = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  text = /[a-zA-Z]+/i

  # validating name, cannot be null and should contain string only
  validates :name,
            format: { with: text, message: 'Please enter text' },
            presence: { message: 'Name cannot be blank' }

  # validaing email, cannot be null, should adher to the emal format, cannot be duplicate
  validates :email, presence: { message: 'Email cannot be blank' },
                    uniqueness: { message: 'Email already present, please login or recover' },
                    format: { with: email_pattern, message: 'invalid email' }

  def available?(date, time)
    meetings.exists?(date: date, time: time)
  end
end
