# frozen_string_literal: true

# user controller
class UserController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin, only: [:index]
  def index
    @users = User.all
  end

  def destroy
    @user = User.find(params[:id])
    Friendship.where(friend_id: @user.id).destroy_all
    Friendship.where(user_id: @user.id).destroy_all
    return unless @user.destroy

    redirect_to friend_requests_friends_path
  end

  private

  def authorize_admin
    authorize! :index, User
  end
end
