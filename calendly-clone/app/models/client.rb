class Client < ApplicationRecord
  has_many :meeting

  email_pattern = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  text = /[a-zA-Z]+/i
  
  #validating name, needs to be text, cannot be null
  validates :name, 
   format: {with: text, message: "Please enter text"},
   presence: {message: "Name cannot be blank" }

  #validaing email, cannot be null, should adher to the emal format, cannot be duplicate
  validates :email, 
   presence: {message: "Email cannot be blank" },
   uniqueness: {message: "Email already present, please login or recover"},
   format: {with: email_pattern, message: "Email invalid"}

  #validaing email, null value allowed, should number only, cannot be duplicate
  validates :contact,
   allow_nil: true,
   numericality: {message: "please enter a valid number"},
   uniqueness: {message: "Contact already present, please login or recover"}
end
