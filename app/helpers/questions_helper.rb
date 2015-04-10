module QuestionsHelper
  def answers_count_text(question)
    content_tag(:div, class: "mini-counts") do
      question.get_answers_count
    end + content_tag(:div) do
      '回答'
    end
  end

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
