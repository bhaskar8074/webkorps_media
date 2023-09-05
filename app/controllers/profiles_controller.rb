class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile

  def index
    @profiles = Profile.all
  end

  def show
    @all_profiles = Profile.where.not(user_id: current_user.id)
    @request_sender_ids = Friendship.where(friend_id: current_user.id, status: 'pending').pluck(:user_id)
    @profiles = @all_profiles.where.not(user_id: @request_sender_ids)
    @friend_count = current_user.friendships.where(status: 'accepted').count
  end

  def edit
  end

  def update
    if @profile.update(profile_params)
      if params[:profile][:profile_picture]
        uploaded_file = params[:profile][:profile_picture]
        cloudinary_response = Cloudinary::Uploader.upload(uploaded_file, :transformation => [
          {:width => 800, :height => 800, :crop => :limit}, # Resize to fit within 800x800
          {:quality => "auto:low"} # Automatically adjust quality for compression
        ])
        @profile.update(profile_picture_public_id: cloudinary_response['public_id'])
      end
      redirect_to profile_path, notice: 'Profile was successfully updated.'
    else
      render :edit
    end
  end

  def send_friend_request
    friend = current_user
    friendship = User.find(params[:id]).friendships.build(friend: friend, status: 'pending')
    p "******#{friend}"
    p "*****#{friendship.inspect}"
    if friendship.save
      flash[:notice] = "Friend request sent to #{friend.profile.first_name}."
    else
      flash[:alert] = "Unable to send friend request."
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
