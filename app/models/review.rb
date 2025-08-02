class Review < ApplicationRecord
  belongs_to :customer
  belongs_to :product

  validates :customer_id, :product_id, :rating, :comment, presence: true
  validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
end
