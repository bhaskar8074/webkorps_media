# frozen_string_literal: true

# likes_controller
class LikesController < ApplicationController
  before_action :set_current_post

  def update_likes
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "post#{@post.id}features",
          partial: 'posts/post_features',
          locals: { post: @post }
        )
      end
    end
  end

  def toggle_like
    if (@like = @post.likes.find_by(user_id: current_user.id))
      @like.destroy
    else
      @post.likes.create(user: current_user)
    end
    update_likes
  end

  private

  def set_current_post
    @post = Post.find(params[:post_id])
  end
end
