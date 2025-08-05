# app/controllers/customers/registrations_controller.rb
class Customers::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # Permit additional fields during sign up and account update
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :username, :first_name, :last_name, :phone, :address
    ])
    devise_parameter_sanitizer.permit(:account_update, keys: [
      :username, :first_name, :last_name, :phone, :address
    ])
  end
end
