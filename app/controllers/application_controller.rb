class ApplicationController < ActionController::Base
  rescue_from "CanCan::AccessDenied" do |exception|
    redirect_to root_url
  end
  
    
    def after_sign_in_path_for(resource)
      if current_user.profile.present?
        root_path
      else
        edit_profile_path
      end
    end
end
