class Link < ApplicationRecord
  # Associations
  belongs_to :list

  # Validations
  validates_each :word1, :word2 do |link, attribute, value|
    link.errors.add(attribute, "can't be too short.") if value.length < 1
    link.errors.add(attribute, "can't be too long.") if value.length > 15
  end
end
