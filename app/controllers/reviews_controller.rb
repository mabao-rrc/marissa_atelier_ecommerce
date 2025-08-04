class ReviewsController < ApplicationController
  # -------------------------------------------------------
  # Controller: ReviewsController
  # Purpose: Handle creation of product reviews
  # Route: POST /products/:product_id/reviews
  # -------------------------------------------------------

  def create
    # Find the product associated with the review
    @product = Product.find(params[:product_id])

    # Build a new review linked to the product using strong parameters
    @review = @product.reviews.build(review_params)

    # ✅ Assign the customer ID based on the logged-in user
    @review.customer_id = current_customer.id

    # Save the review and handle success or failure
    if @review.save
      redirect_to product_path(@product), notice: 'Review submitted successfully.'
    else
      redirect_to product_path(@product), alert: 'Failed to submit review.'
    end
  end

  private

  # Strong parameters – allow only trusted input fields
  def review_params
    params.require(:review).permit(:rating, :comment)
    # Note: :customer_id is NOT permitted here; it's assigned from current_customer
  end
end
