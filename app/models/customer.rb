class Customer < ApplicationRecord
  validates :first_name, :last_name, :email, :phone, :address, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone, format: { with: /\A[\d\-\+\(\) ]+\z/, message: "only allows valid phone numbers" }
end
