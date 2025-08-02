class Product < ApplicationRecord
  # ----------------------------
  # Associations
  # ----------------------------

  belongs_to :brand   # ← Add this line

  has_many :order_items
  has_many :orders, through: :order_items
  has_many :reviews
  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories

  # ----------------------------
  # Validations
  # ----------------------------

  validates :name, :description, :price, :stock_quantity, :image_url, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :stock_quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
