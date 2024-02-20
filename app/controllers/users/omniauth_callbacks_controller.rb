class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # skip_before_action :verify_authenticity_token, only: :google_oauth2
  def google_oauth2
    Rails.logger.debug(params.inspect)
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in @user
      if @user.profile.present?
        redirect_to root_path
      else
        redirect_to edit_profile_path
      end
    else
      session["devise.google_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end
