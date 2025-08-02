class Category < ApplicationRecord
  # ----------------------------
  # Associations
  # ----------------------------
  has_many :product_categories, dependent: :destroy
  has_many :products, through: :product_categories

  # ----------------------------
  # Validations
  # ----------------------------
  validates :name, presence: true, uniqueness: true

  # ----------------------------
  # Ransack Allowlist
  # ----------------------------
  def self.ransackable_associations(auth_object = nil)
    ["product_categories", "products"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["id", "name", "created_at", "updated_at"]
  end
end
