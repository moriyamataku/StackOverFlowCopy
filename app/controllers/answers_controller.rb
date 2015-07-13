class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_answer, only: [:edit, :update, :up_vote, :down_vote, :cancel_vote, :mark, :cancel_mark]

  def create
    @question = Question.find(params[:question_id])
    @answer = Answer.new(answer_params)
    @answer.question = @question
    @answer.user = current_user
    @answer.save
    redirect_to @question
  end

  def edit
  end

  def update
    @answer.update(answer_params)
    if @answer.save
      redirect_to @question
    else
      render :edit
    end
  end

  def mark
    @answer.set_mark
  end

  def cancel_mark
    @answer.cancel_mark
  end

  def up_vote
    @answer.do_vote(current_user, true)
  end

  def down_vote
    @answer.do_vote(current_user, false)
  end

  def cancel_vote
    @answer.cancel_vote(current_user)
  end

  private
    def answer_params
      params.require(:answer).permit(:body)
    end

    def set_answer
      @question = Question.find(params[:question_id])
      @answer = if params.fetch(:answer_id, {}).present?
                  @question.answers.find(params[:answer_id])
                else
                  @question.answers.find(params[:id])
                end
    end
end
