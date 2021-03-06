# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google
    callback_from :google
  end

  def twitter
    callback_from :twitter
  end

  def callback_from(provider)
    provider = provider.to_s
    @user = User.find_for_oauth(request.env['omniauth.auth'])

    if @user.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: provider.capitalize
      sign_in_and_redirect @user, event: :authentication
      session[:user_id] = @user.id

    else
      session["devise.#{provider}_data"] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end

  private

  def after_sign_in_path_for(resource)
    if resource.sign_in_count == 1
      edit_user_path(resource)
    else
      posts_path
    end
  end
end
