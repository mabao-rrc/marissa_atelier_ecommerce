class Product < ApplicationRecord
  # ----------------------------
  # Associations
  # ----------------------------

  # belongs_to :brand   # ← Commented out since brand_id is not in the schema

  has_many :order_items
  has_many :orders, through: :order_items
  has_many :reviews, dependent: :destroy
  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories

  # ----------------------------
  # Validations (Feature 4.2.1)
  # ----------------------------

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :stock_quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :image_url, presence: true
end
