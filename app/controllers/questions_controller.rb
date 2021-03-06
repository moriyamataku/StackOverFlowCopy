class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_question, only: [:show, :edit, :update, :up_vote, :down_vote, :cancel_vote, :favorite, :cancel_favorite]
  after_action :regist_view, only: :show

  def index
    @questions = Question.search_by_type(params[:tab]).page(params[:page])
    @questions = @questions.tagged_with(params[:tag]) if params[:tag].present?
  end

  def show
  end

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.build(question_params)
    @question.regist_tags(tag_params)
    if @question.save
      redirect_to @question
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
    render 'update_votes'
  end

  def down_vote
    @question.do_vote(current_user, false)
    render 'update_votes'
  end

  def cancel_vote
    @question.cancel_vote(current_user)
    render 'update_votes'
  end

  def favorite
    @question.regist_favorite(current_user)
    render 'update_favorites'
  end

  def cancel_favorite
    @question.cancel_favorite(current_user)
    render 'update_favorites'
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def tag_params
    params.fetch(:tag_value, {})
  end

  def regist_view
    @question.regist_view(current_user) if user_signed_in?
  end
end
