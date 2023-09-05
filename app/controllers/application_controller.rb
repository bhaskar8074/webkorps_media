class ApplicationController < ActionController::Base
    
    def after_sign_in_path_for(resource)
      if current_user.profile.present?
        root_path
      else
        edit_profile_path
      end
    end
end
