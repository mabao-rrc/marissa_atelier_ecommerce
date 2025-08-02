class ContactPage < ApplicationRecord
  validates :title, :slug, :content, presence: true
end
