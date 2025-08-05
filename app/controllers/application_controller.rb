class ApplicationController < ActionController::Base
  # Only allow modern browsers
  allow_browser versions: :modern

  # ✅ Redirect to homepage after customer logs out
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
end
