Rails.application.routes.draw do
  get "categories/show"
  get "storefront/index"
  get "products/index"
  get "products/show"

  # ✅ Public-facing product pages with review submission support
  resources :products, only: [:index, :show] do
    resources :reviews, only: [:create]
  end
  
  # ✅ Admin dashboard for managing products
  namespace :admin do
    resources :products
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  get "up" => "rails/health#show", as: :rails_health_check

  # ✅ Public-facing static content pages
  get '/about', to: 'pages#show', defaults: { slug: 'about' }
  get '/contact', to: 'pages#show', defaults: { slug: 'contact' }

  # ✅ Route to display products by category (Feature 2.2)
  get '/categories/:id', to: 'categories#show', as: 'category'

  # Defines the root path route ("/")
  root "storefront#index"
end
