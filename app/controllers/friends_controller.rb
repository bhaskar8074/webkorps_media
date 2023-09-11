class FriendsController < ApplicationController
  before_action :authenticate_user!

  def friends
    @friends_ids= current_user.friendships.where(status: "accepted").pluck(:friend_id)
    p "*********************************************#{@friends_ids.inspect}"
    @user_profiles = Profile.where(user_id: @friends_ids)
    
  end

  def accept_friend_request
    friendship = current_user.friendships.find(params[:id])
    reverse_friendship = friendship.friend.friendships.build(friend: current_user, status: 'accepted')
    reverse_friendship.save
    friendship.update(status: 'accepted')
    flash[:notice] = "You are now friends with #{friendship.friend.profile.first_name}."
    redirect_to friend_requests_friends_path
  end

  def reject_friend_request
    friendship = current_user.friendships.find(params[:id])
    friendship.destroy
    flash[:notice] = "Friend request from #{friendship.friend.profile.first_name} rejected."
    redirect_to friend_requests_friends_path
  end
  
  def destroy
    friend = User.find(params[:id])
    friendship = current_user.friendships.find_by(friend_id: friend.id)

    if friendship&.destroy
      flash[:notice] = "Removed #{friendship.friend.profile.first_name} from your friends."
    else
      flash[:alert] = "Unable to remove friend."
    end
    redirect_to root_path
  end

  def friend_requests
    @friend_requests = Friendship.all.where(status: 'pending', user_id: current_user.id)
    p current_user.friendships.inspect
    puts "Current User ID: #{current_user.id}"
    p @friend_requests
  end
end
