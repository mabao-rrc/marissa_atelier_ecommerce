class Category < ApplicationRecord
  has_many :product_categories, dependent: :destroy
  has_many :products, through: :product_categories

  validates :name, presence: true, uniqueness: true

  # Allowlist searchable associations
  def self.ransackable_associations(auth_object = nil)
    ["product_categories", "products"]
  end

  # Allowlist searchable attributes
  def self.ransackable_attributes(auth_object = nil)
    ["id", "name", "created_at", "updated_at"]
  end
end
