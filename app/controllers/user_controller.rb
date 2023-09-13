class UserController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin, only: [:index]
    def index
        @users = User.all
    end

    def destroy
        debugger
        @user = User.find(params[:id])
        @user.destroy
    end

    private 

    def authorize_admin
        authorize! :index, User
    end
end
