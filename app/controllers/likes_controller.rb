class LikesController < ApplicationController
  before_action :set_current_post
  def toggle_like
    if(@like = @post.likes.find_by(user_id: current_user.id))
        @like.destroy
    else
        @post.likes.create(user: current_user)
    end

    respond_to do |format|
        format.turbo_stream do
            render turbo_stream: turbo_stream.replace(
                "post#{@post.id}features",
                partial: "posts/post_features",
                locals: {post: @post}
            )
        end
    end

  end

  private

  def set_current_post
    @post = Post.find(params[:post_id])
  end
end