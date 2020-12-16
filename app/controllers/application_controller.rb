class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    "/users/#{current_user.id}"
  end

  def restrict_access(check_user_id)
    unless current_user.id == check_user_id
      flash[:notice] = "You don't have permission!"
      redirect_to root_path
    end
  end

  def admin?
    unless current_user&.admin?
      flash[:notice] = "You don't have permission!"
      redirect_to root_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

end
