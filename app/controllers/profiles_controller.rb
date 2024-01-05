# frozen_string_literal: true

# profile controller
class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile
  before_action :set_profiles_service

  def index
    @profiles = Profile.all
  end

  def show
    @profiles = @profiles_service.visible_profiles
    @friend_count = current_user.friendships.where(status: 'accepted').count
  end

  def edit; end

  def update_profile
    @profile_pic = params[:profile][:profile_picture]
    return unless @profile_pic

    @profiles_service.update_profile_picture(@profile, @profile_pic)
  end

  def update
    if @profile.update(profile_params)
      update_profile
      redirect_to profile_path, notice: 'Profile was successfully updated.'
    else
      render :edit
    end
  end

  def send_friend_request
    friendship = @profiles_service.send_friend_request(params)
    if friendship.save
      flash[:notice] = "Friend request sent to #{current_user.profile.first_name}."
    else
      flash[:alert] = 'Unable to send friend request.'
    end

    redirect_to profile_path(current_user)
  end

  private

  def set_profile
    @profile = current_user.profile || current_user.build_profile
  end

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :bio)
  end

  def set_profiles_service
    @profiles_service = ProfilesService.new(current_user)
  end
end
