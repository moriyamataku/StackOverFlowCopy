class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_question, only: [:show, :edit, :update, :up_vote, :down_vote, :cancel_vote, :favorite, :cancel_favorite]
  after_action :regist_view, only: :show

  def index
    @questions = Question.order(updated_at: :desc).page(params[:page])
    @questions = @questions.tab(params[:tab]) if params[:tab].present?
    @questions = @questions.tagged_with(params[:tag]) if params.fetch(:tag, {}).present?
  end

  def show
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user
    @question.regist_tags(tag_params)
    if @question.save
      redirect_to questions_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    @question.update(question_params)
    @question.regist_tags(tag_params)
    if @question.save
      redirect_to @question
    else
      render :edit
    end
  end

  def up_vote
    @question.do_vote(current_user, true)
  end

  def down_vote
    @question.do_vote(current_user, false)
  end

  def cancel_vote
    @question.cancel_vote(current_user)
  end

  def favorite
    @question.regist_favorite(current_user)
  end

  def cancel_favorite
    @question.cancel_favorite(current_user)
  end

  private

  def set_question
    @question = Question.find(params.require(:id))
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def tag_params
    params.require(:tag_value)
  end

  def regist_view
    if user_signed_in?
      @question.regist_view(current_user)
    end
  end
end
