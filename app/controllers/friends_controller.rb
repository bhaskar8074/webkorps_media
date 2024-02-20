# frozen_string_literal: true

# friends controller
class FriendsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_friends_service

  def index
    @user_profiles = @friends_service.friends

  end

  def accept_friend_request
    friendship = @friends_service.accept_friend_request
    flash[:notice] = "You are now friends with #{friendship.friend.profile.first_name}."
    redirect_to friend_requests_friends_path
  end

  def reject_friend_request
    friendship = @friends_service.reject_friend_request
    return unless friendship

    flash[:notice] = "Friend request from #{friendship.friend.profile.first_name} rejected."
    redirect_to friend_requests_friends_path
  end

  def friend_requests
    @friend_requests = @friends_service.friend_requests
  end

  private

  def set_friends_service
    @friends_service = FriendsService.new(current_user, params)
  end
end
