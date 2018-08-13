class QuizResultsController < ApplicationController
  before_action :authenticate_user!

  def show
    @list = current_user.lists.find(params[:list_id])
    @quiz_result = @list.quiz_results.find(params[:quiz_result_id])
  end

  def create
    respond_to do |format|
      format.json do
        @list = current_user.lists.find(params[:list_id])
        quiz_result = @list.quiz_results.create(quiz_result_params)
        if save_data = quiz_result.save
          render json: {
            status: 'success',
            redirect_to: Rails.application.routes.url_helpers.quiz_result_path(@list.id, quiz_result.id)
          }
        else
          # TODO: This shouldn't happen unless someone is actively messing with the js variables. Maybe show a page with results generated from the javascript variables and show why it couldn't be saved and you should contact me if this is a mistake.
          render json: {status: 'failure'}
        end
      end
    end
  end

  private
  def quiz_result_params
    params.require(:quiz_result).permit(:direction, :quiz_type, :correct, {quiz_errors_attributes: [:word1, :word2, :answer]})
  end
end
