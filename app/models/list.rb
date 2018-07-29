class List < ApplicationRecord
  # Associations
  belongs_to :user
  has_many :links, index_errors: true, dependent: :destroy
  has_many :quiz_results, dependent: :destroy
  accepts_nested_attributes_for :links, allow_destroy: true, reject_if: :reject_links

  def reject_links(attributes)
    exists = attributes['id'].present?
    empty = attributes.slice(:word1, :word2).values.all?(&:blank?)
    attributes.merge!({:_destroy => 1}) if exists && empty
    return (!exists && empty) # reject empty attributes if they don't exist
  end

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

  def as_json(options = nil)
    if options && options[:for_js]
      super(except: [:updated_at, :created_at, :user_id]).tap{|list| list["links"] = self.links.index_by{|link| link.id}.transform_values!{|link| link.as_json(only: [:word1, :word2])}}
    else
      super
    end
  end
end
