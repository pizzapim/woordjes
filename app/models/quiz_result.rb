class QuizResult < ApplicationRecord
  # Associations
  belongs_to :list
  has_many :quiz_errors, dependent: :destroy
  accepts_nested_attributes_for :quiz_errors

  # Validations
  validates_associated :quiz_errors
  validates :direction, inclusion: {in: ["normal", "reversed"]}
  validates :quiz_type, inclusion: {in: ["normal"]}
end
