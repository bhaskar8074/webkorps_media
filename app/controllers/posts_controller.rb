# frozen_string_literal: true

# posts controller
class PostsController < ApplicationController
  def friends
    @friends = current_user.friendships.where(status: 'accepted')
  end

  def index
    friends
    @q = Post.ransack(params[:q])
    @posts = @q.result.where(visibility: 'see_by_public')
               .or(@q.result.where(visibility: 'see_by_friends', user_id: @friends.pluck(:friend_id)))
               .order(created_at: 'desc')
               .page(params[:page])
               .per(3)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    file = params[:post][:post_img].present?
    return unless file

    cloudinary_upload = Cloudinary::Uploader.upload(params[:post][:post_img])
    @post.post_img = cloudinary_upload['secure_url']
  end

  private

  def post_params
    params.require(:post).permit(:caption, :post_img, :visibility)
  end
end
