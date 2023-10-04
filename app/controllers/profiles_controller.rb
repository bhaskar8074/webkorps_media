# frozen_string_literal: true

# profile controller
class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile

  def index
    @profiles = Profile.all
  end

  def exclude_ids
    @request_sender_ids = Friendship.where(friend_id: current_user.id, status: 'pending').pluck(:user_id)
    @accepted_request_sender_ids = Friendship.where(friend_id: current_user.id, status: 'accepted').pluck(:user_id)
    @exclude_ids = @request_sender_ids + @accepted_request_sender_ids
  end

  def show
    @all_profiles = Profile.where.not(user_id: current_user.id)
    exclude_ids
    @profiles = @all_profiles.where.not(user_id: @exclude_ids)
    @friend_count = current_user.friendships.where(status: 'accepted').count
  end

  def edit; end

  def update_profile
    @profile_pic = params[:profile][:profile_picture]
    return unless @profile_pic

    uploaded_file = @profile_pic
    cloudinary_response = Cloudinary::Uploader.upload(uploaded_file, transformation: [
                                                        { width: 800, height: 800, crop: :limit },
                                                        { quality: 'auto:low' }
                                                      ])
    @profile.update(profile_picture_public_id: cloudinary_response['public_id'])
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
    friend = current_user
    friendship = User.find(params[:id]).friendships.build(friend: friend, status: 'pending')
    if friendship.save
      flash[:notice] = "Friend request sent to #{friend.profile.first_name}."
    else
      flash[:alert] = 'Unable to send friend request.'
    end

    redirect_to profile_path(friend)
  end

  def set_profile
    @profile = current_user.profile || current_user.build_profile
  end

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :bio)
  end
end
