# frozen_string_literal: true

# likes_controller
class LikesController < ApplicationController
  before_action :set_current_post
  before_action :set_likes_service

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
    @likes_service.toggle_like(@post)
    update_likes
  end

  private

  def set_likes_service
    @likes_service = LikesService.new(current_user)
  end

  def set_current_post
    @post = Post.find(params[:post_id])
  end
end
