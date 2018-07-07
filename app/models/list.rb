class List < ApplicationRecord
  # Associations
  belongs_to :user
  has_many :links, index_errors: true, dependent: :destroy
  accepts_nested_attributes_for :links, allow_destroy: true, reject_if: proc {|attributes| attributes['word1'].blank? && attributes['word2'].blank?}

  # Callbacks
  before_validation do
    if !self.subject.present?
      self.subject = self.topic2
    end
  end

  # Validations
  validates_associated :links
  validates :title, length: {minimum: 2, maximum: 25, too_short: "can't be too short.", too_long: "can't be too long."}
  validates :subject, length: {minimum: 2, maximum: 15, too_short: "can't be too short.", too_long: "can't be too long."}
  validates_each :topic1, :topic2 do |list, attribute, value|
    list.errors.add(attribute, "can't be too short.") if value.length < 2
    list.errors.add(attribute, "can't be too long.") if value.length > 15
  end
  validates :links, length: {minimum: 1, too_short: "enter at least one word."}
end
