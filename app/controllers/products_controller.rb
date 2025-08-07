class ProductsController < ApplicationController
  # Displays all products (default listing)
  def index
    @products = Product.all
  end

  # Displays a single product's details
  def show
    @product = Product.find(params[:id])
  end

  # Feature 2.6 – Search products by keyword and optional category
  def search
    keyword = params[:keyword].to_s.strip
    category_id = params[:category_id]

    # Load all categories for the dropdown in the search form
    @categories = Category.all

    # Start with all products and build conditions dynamically
    @products = Product.all

    # Filter by keyword in name or description (use LIKE for SQLite compatibility)
    if keyword.present?
      @products = @products.where("name LIKE ? OR description LIKE ?", "%#{keyword}%", "%#{keyword}%")
    end

    # Filter by selected category, if provided
    if category_id.present?
      @products = @products.joins(:categories).where(categories: { id: category_id })
    end
  end
end
