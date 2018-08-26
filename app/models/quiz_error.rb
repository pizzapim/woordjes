class QuizError < ApplicationRecord
  # Associations
  belongs_to :quiz_result

  # Validations
  validates_each :word1, :word2, :answer do |link, attribute, value|
    link.errors.add(attribute, "can't be too long.") if value.length > 15
  end

  def word_with_direction
    if self.quiz_result.quiz_type == 'normal'
      return self.word1
    else
      return self.word2
    end
  end

  def correct_answer_with_direction
    if self.quiz_result.quiz_type == 'normal'
      return self.word2
    else
      return self.word1
    end
  end
end
