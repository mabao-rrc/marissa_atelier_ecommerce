class ContactMessage < ApplicationRecord
  validates :full_name, :email, :subject, :message, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
