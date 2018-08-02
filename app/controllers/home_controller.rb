class HomeController < ApplicationController
  def index
    @new_user = User.new
  end
end
