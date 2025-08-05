class CartsController < ApplicationController
  # Adds a product to the cart stored in session
  def add_item
    product_id = params[:product_id].to_s
    session[:cart] ||= {}
    session[:cart][product_id] ||= 0
    session[:cart][product_id] = session[:cart][product_id].to_i + 1

    redirect_to cart_path, notice: "Item added to cart."
  end

  # Displays all cart items with product info and quantity
  def show
    @cart_items = []
    (session[:cart] || {}).each do |product_id, quantity|
      product = Product.find_by(id: product_id)
      if product
        @cart_items << {
          product: product,
          quantity: quantity.to_i
        }
      end
    end
  end
end
