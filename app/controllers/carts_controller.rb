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

  # Removes a product from the cart
  def remove_item
    product_id = params[:product_id].to_s
    if session[:cart]&.key?(product_id)
      session[:cart].delete(product_id)
      flash[:notice] = "Item removed from cart."
    end
    redirect_to cart_path
  end

  # Updates the quantity of a product in the cart
  def update_item
    product_id = params[:product_id].to_s
    new_quantity = params[:quantity].to_i

    if session[:cart]&.key?(product_id)
      if new_quantity > 0
        session[:cart][product_id] = new_quantity
        flash[:notice] = "Quantity updated."
      else
        flash[:alert] = "Quantity must be at least 1."
      end
    end

    redirect_to cart_path
  end
end
