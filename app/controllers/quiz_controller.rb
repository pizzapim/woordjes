class QuizController < ApplicationController

  before_action :authenticate_user!

  def new
    @list = current_user.lists.find(params[:list_id])
  end

  def start
    @list = current_user.lists.find(params[:list_id])
  end
end
