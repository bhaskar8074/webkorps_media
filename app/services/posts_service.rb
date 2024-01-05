# forzen_string_literal: true

# post services
class PostsService
  def initialize(user)
    @user = user
  end

  def get_posts(que, params)
    friends
    @posts = que.result.where(visibility: 'see_by_public')
                .or(que.result.where(visibility: 'see_by_friends', user_id: @friends.pluck(:friend_id)))
                .order(created_at: 'desc')
                .page(params[:page])
                .per(3)
  end

  def create_post(params)
    @post = current_user.posts.build(post_params(params))
    file = params[:feed][:post_img].present?
    return unless file

    cloudinary_upload = Cloudinary::Uploader.upload(params[:feed][:post_img])
    @post.post_img = cloudinary_upload['secure_url']
    @post.save
  end

  private

  def post_params(params)
    # debugger
    params.require(:feed).permit(:caption,:post_img,:visibility)
  end

  def friends
    @friends = @user.friendships.where(status: 'accepted')
  end


  def current_user
    @user
  end
end
