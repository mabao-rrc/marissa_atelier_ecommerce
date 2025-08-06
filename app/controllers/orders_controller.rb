class OrdersController < ApplicationController
  def new
    # Step 1: Load cart items from session to display on the checkout form
    @cart_items = load_cart_items
  end

  def create
    # Step 2: Load cart items again and calculate subtotal
    @cart_items = load_cart_items
    subtotal = @cart_items.sum { |item| item[:product].price * item[:quantity] }

    # Step 3: Calculate GST, PST, and HST based on the selected province
    province = params[:province]
    gst, pst, hst = calculate_taxes(subtotal, province)

    # Step 4: Round all tax values and compute the final total
    total = (subtotal + gst + pst + hst).round(2)

    # Step 5: Create a new Order and associate it with the current customer
    order = Order.new(
      customer: current_customer,
      province: province,
      subtotal: subtotal,
      gst: gst.round(2),
      pst: pst.round(2),
      hst: hst.round(2),
      total: total,
      order_date: Time.current,
      status: 'Processing',
      total_price: total
    )

    if order.save
      begin
        # Step 6: Save each cart item as a separate OrderItem
        @cart_items.each do |item|
          OrderItem.create!(
            order: order,
            product: item[:product],
            quantity: item[:quantity],
            unit_price: item[:product].price
          )
        end

        # Step 7: Clear the cart and redirect to invoice
        session[:cart] = {}
        redirect_to invoice_path(order), notice: "Order placed successfully!"

      rescue => e
        # If saving OrderItems fails, rollback the order
        order.destroy
        redirect_to checkout_path, alert: "Order failed while saving items: #{e.message}"
      end
    else
      # Step 8: If saving the order fails, redirect with error
      redirect_to checkout_path, alert: "There was a problem placing your order."
    end
  end

  def show
    # Step 9: Find the order by ID and verify ownership by current customer
    @order = Order.find_by(id: params[:id], customer: current_customer)

    if @order.nil?
      redirect_to root_path, alert: "Order not found."
      return
    end

    # Step 10: Load associated order items for display in the invoice
    @order_items = @order.order_items.includes(:product)
  end

  private

  # Helper method: Load cart items from session, return product + quantity
  def load_cart_items
    items = []
    (session[:cart] || {}).each do |product_id, quantity|
      product = Product.find_by(id: product_id)
      if product
        items << {
          product: product,
          quantity: quantity.to_i
        }
      end
    end
    items
  end

  # Helper method: Return tax values based on the user's province
  def calculate_taxes(subtotal, province)
    gst = pst = hst = 0

    case province
    when 'MB'
      gst = subtotal * 0.05
      pst = subtotal * 0.07
    when 'ON'
      hst = subtotal * 0.13
    when 'QC'
      gst = subtotal * 0.05
      pst = subtotal * 0.09975
    when 'BC'
      gst = subtotal * 0.05
      pst = subtotal * 0.07
    when 'NS'
      hst = subtotal * 0.15
    else
      gst = subtotal * 0.05 # Default GST
    end

    [gst, pst, hst]
  end
end
