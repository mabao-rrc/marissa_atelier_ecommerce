class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # ----------------------------
  # Validations
  # ----------------------------

  validates :username, presence: true, uniqueness: true
  validates :first_name, :last_name, :email, :phone, :address, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone, format: { with: /\A[\d\-\+\(\) ]+\z/, message: "only allows valid phone numbers" }
end
