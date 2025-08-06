class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  validates :customer_id, :order_date, :status, :total_price, presence: true
  validates :total_price, numericality: { greater_than_or_equal_to: 0 }
end
