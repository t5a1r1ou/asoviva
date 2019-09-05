# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name area])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name area])
  end

  private

  def after_sign_in_path_for(_resource)
    posts_path
  end

  def after_update_path_for(_resource)
    posts_path
  end
end
