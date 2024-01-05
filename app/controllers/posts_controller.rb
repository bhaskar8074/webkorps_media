# frozen_string_literal: true

# posts controller
class PostsController < ApplicationController
  before_action :set_posts_service

  def index
    @q = Post.ransack(params[:q])
    @posts = @post_service.get_posts(@q, params)
  end

  def new
    @post = Post.new
  end

  def create
    return unless @post_service.create_post(params)

    redirect_to posts_path
  end

  private

  def set_posts_service
    @post_service = PostsService.new(current_user)
  end
end
