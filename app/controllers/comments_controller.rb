class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_parent, only: [:create, :destroy]

  def create
    comment = @parent.comments.new(comment_param)
    comment.user = current_user
    comment.save
    redirect_to @question
  end

  def destroy
    comment = @parent.comments.find_by!(user: current_user)
    comment.destroy!
    redirect_to @question
  end

  private

  def set_parent
    @question = Question.find(params.require(:question_id))
    if params.fetch(:answer_id, {}).present?
      @parent = @question.answers.find(params.require(:answer_id))
    else
      @parent = @question
    end
  end

  def comment_param
    params.require(:comment).permit(:body)
  end
end
