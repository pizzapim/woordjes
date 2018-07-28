class QuizResult < ApplicationRecord
  # Associations
  belongs_to :list
  has_many :quiz_errors, dependent: :destroy
end
