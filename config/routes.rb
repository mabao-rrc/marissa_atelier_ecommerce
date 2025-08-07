Rails.application.routes.draw do
  # ✅ Devise routes for customers using custom registrations controller
  devise_for :customers, controllers: {
    registrations: 'customers/registrations'
  }

  # ✅ Devise + ActiveAdmin routes for admin users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # ✅ Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # ✅ Static pages and storefront
  get "storefront/index"
  root "storefront#index"

  # ✅ Public-facing static content pages
  get '/about', to: 'pages#show', defaults: { slug: 'about' }
  get '/contact', to: 'pages#show', defaults: { slug: 'contact' }

  # ✅ Route to display products by category (Feature 2.2)
  get '/categories/:id', to: 'categories#show', as: 'category'

  # ✅ Product search route (Feature 2.6 - keyword + category search)
  get 'products/search', to: 'products#search', as: 'search_products'

  # ✅ Public-facing product pages with review submission support
  resources :products, only: [:index, :show] do
    resources :reviews, only: [:create]
  end

  # ✅ Shopping cart and checkout (Feature 3.1.x)
  resource :cart, only: [:show] do
    post 'add_item'
    post 'remove_item'
    post 'update_item'
  end

  # ✅ Checkout and Order routes (Feature 3.1.3)
  get 'checkout', to: 'orders#new'
  post 'checkout', to: 'orders#create'
  get 'invoice/:id', to: 'orders#show', as: 'invoice'

  # ✅ Admin dashboard for managing products
  namespace :admin do
    resources :products
  end
end
