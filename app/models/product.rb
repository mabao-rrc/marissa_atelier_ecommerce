# app/models/product.rb

class Product < ApplicationRecord
  # ----------------------------
  # Associations
  # ----------------------------

  # A product can appear in many order items (line items in a cart or order)
  has_many :order_items

  # Through those order items, a product can be part of many orders
  has_many :orders, through: :order_items

  # A product can have many customer reviews
  has_many :reviews

  # A product can belong to many categories through the categorizations join table
  has_many :categorizations
  has_many :categories, through: :categorizations

  # ----------------------------
  # Validations
  # ----------------------------

  # These fields must be present when creating or updating a product
  validates :name, :description, :price, :stock_quantity, :image_url, presence: true

  # Price must be a number greater than or equal to 0
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  # Stock quantity must be a whole number greater than or equal to 0
  validates :stock_quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
