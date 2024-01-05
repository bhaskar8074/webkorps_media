# frozen_string_literal: true

# home_controller
class HomeController < ApplicationController
  before_action :authenticate_user!
  def index; end
end
