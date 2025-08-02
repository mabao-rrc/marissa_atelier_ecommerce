class ProductCategory < ApplicationRecord
  # ----------------------------
  # Associations
  # ----------------------------
  belongs_to :product
  belongs_to :category

  # ----------------------------
  # Validations
  # ----------------------------
  # Ensure both foreign keys are present
  validates :product_id, :category_id, presence: true

  # ----------------------------
  # Ransack Allowlist for ActiveAdmin Search
  # ----------------------------
  def self.ransackable_attributes(auth_object = nil)
    ["id", "product_id", "category_id", "created_at", "updated_at"]
  end
end
