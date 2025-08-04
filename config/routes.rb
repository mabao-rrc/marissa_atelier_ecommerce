Rails.application.routes.draw do
  get "products/index"
  get "products/show"
  # ✅ Public-facing product pages
  resources :products, only: [:index, :show]

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

  # Defines the root path route ("/")
  root "storefront#index"
end
