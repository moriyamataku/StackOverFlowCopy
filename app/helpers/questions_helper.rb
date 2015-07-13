module QuestionsHelper
  def question_answer_count_class(question)
    if question.get_answers_count == 0
      ''
    elsif question.solved
      'answered-accepted'
    else
      'answered'
    end
  end
end
