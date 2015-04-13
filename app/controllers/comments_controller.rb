class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_parent, only: [:create, :destroy]

  def create
    comment = @parent.comments.new(comment_param)
    comment.user = current_user
    if comment.save
      redirect_to @question
    else
      redirect_to @question, alert: "エラー"
    end
  end

  def destroy
    comment = @parent.comments.find_by!(user: current_user, id: params[:id])
    comment.destroy!
    redirect_to @question
  end

  private

  def set_parent
    @question = Question.find(params[:question_id])
    @parent = if params[:answer_id].present?
                @question.answers.find(params[:answer_id])
              else
                @question
              end
  end

  def comment_param
    params.require(:comment).permit(:body)
  end
end
