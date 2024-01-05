# frozen_string_literal: true

class FriendsService
  def initialize(user, params)
    @user = user
    @params = params
  end

  def friends
    @friends_ids = @user.friendships.where(status: 'accepted').pluck(:friend_id)
    @user_profiles = Profile.where(user_id: @friends_ids)
  end

  def accept_friend_request
    friendship = @user.friendships.find(@params[:id])
    save_friendships friendship
  end

  def reject_friend_request
    friendship = @user.friendships.find(@params[:id])
    friendship.destroy
  end

  def friend_requests
    @friend_requests = Friendship.all.where(status: 'pending', user_id: @user.id)
  end

  private

  def save_friendships(friendship)
    reverse_friendship = friendship.friend.friendships.build(friend: @user, status: 'accepted')
    reverse_friendship.save
    friendship.update(status: 'accepted')
    friendship
  end
end
