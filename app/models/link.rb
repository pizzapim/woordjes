class Link < ApplicationRecord
  # Associations
  belongs_to :list

  # Validations
  validates_each :word1, :word2 do |link, attribute, value|
    link.errors.add(attribute, :required_too) if value.length < 1
    link.errors.add(attribute, :too_long) if value.length > 50
  end
end
