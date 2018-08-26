class QuizController < ApplicationController
  before_action :authenticate_user!
  before_action :find_list

  def quiz
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

    session[:quiz] = params[:quiz].slice(:quiz_type, :direction) if request.post?

    gon.list = @list.as_json(for_js: true)
    gon.quiz = params[:quiz]
    gon.t = I18n.t("quizzes.#{params[:quiz][:quiz_type]}")
  end

  private

  def find_list
    @list = current_user.lists.find(params[:list_id])
  end
end
