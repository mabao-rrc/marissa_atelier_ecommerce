# app/controllers/storefront_controller.rb
class StorefrontController < ApplicationController
  def index
    @products = Product.all.includes(:categories)
  end
end
