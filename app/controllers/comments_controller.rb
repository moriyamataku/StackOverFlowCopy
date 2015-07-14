class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_parent, only: [:create, :destroy]

  def create
    comment = @parent.comments.new(comment_param)
    comment.user = current_user
    if comment.save
      render "comments/update_comments"
    else
      render "comments/update_comments_error"
    end
  end

  def destroy
    comment = @parent.comments.find_by!(user: current_user, id: params[:id])
    comment.destroy!
    render "comments/update_comments"
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
