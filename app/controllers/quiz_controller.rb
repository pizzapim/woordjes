class QuizController < ApplicationController

  before_action :authenticate_user!
  before_action :find_list
  before_action :valid_options_params, only: :quiz
  before_action :save_quiz_options, only: :quiz

  def quiz
    gon.list = @list.as_json(for_js: true)
    gon.quiz = params[:quiz]
  end

  private

  def find_list
    @list = current_user.lists.find(params[:list_id])
  end

  def valid_options_params
    unless request.post?
      params[:quiz] = session[:quiz]
    end
    errors = []
    unless params.key?(:quiz) && params[:quiz].key?(:direction)
      errors.push("Please fill in the options.")
    else
      errors.push("Please choose a valid quiz type.") unless view_context.quiz_types.include?(params[:quiz][:quiz_type])
      errors.push("Please choose a valid quiz direction.") unless ["normal", "reversed"].include?(params[:quiz][:direction])
    end
    if errors.any?
      flash[:errors] = errors.join(" ")
      render :new
    end
  end

  def save_quiz_options
    session[:quiz] = params[:quiz].slice(:quiz_type, :direction) if request.post?
  end
end
