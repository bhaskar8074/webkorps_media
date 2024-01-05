# frozen_string_literal: true

# likes service
class LikesService
  def initialize(user)
    @user = user
  end

  def toggle_like(post)
    if (@like = post.likes.find_by(user_id: @user.id))
      @like.destroy
    else
      post.likes.create(user: @user)
    end
  end
end
