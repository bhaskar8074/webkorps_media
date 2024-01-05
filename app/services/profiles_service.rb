# frozen_string_literal: true

# profile service
class ProfilesService
  def initialize(user)
    @user = user
  end

  def all_profiles
    Profile.where.not(user_id: @user.id).includes(:user)
  end

  def excluded_profile_ids
    request_sender_ids = Friendship.where(friend_id: @user.id, status: 'pending').pluck(:user_id)
    accepted_request_sender_ids = Friendship.where(friend_id: @user.id, status: 'accepted').pluck(:user_id)
    request_sender_ids + accepted_request_sender_ids
  end

  def visible_profiles
    all_profiles.where.not(user_id: excluded_profile_ids)
  end

  def send_friend_request(params)
    User.find(params[:id]).friendships.build(friend: @user, status: 'pending')
  end

  def update_profile_picture(profile, uploaded_file)
    return unless uploaded_file

    cloudinary_response = upload_to_cloudinary(uploaded_file)
    profile.update(profile_picture_public_id: cloudinary_response['public_id'])
  end

  private

  def upload_to_cloudinary(uploaded_file)
    Cloudinary::Uploader.upload(uploaded_file, transformation: [
      { width: 800, height: 800, crop: :limit },
      { quality: 'auto:low' }
    ])
  end
end
