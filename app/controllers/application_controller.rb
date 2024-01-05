# frozen_string_literal: true

# from here all controllers inherit
class ApplicationController < ActionController::Base
  rescue_from 'CanCan::AccessDenied' do |_exception|
    redirect_to root_url
  end

  def after_sign_in_path_for(_resource)
    if current_user.profile.present?
      root_path
    else
      edit_profile_path
    end
  end
end
