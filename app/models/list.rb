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
  validates :title, presence: true, length: {minimum: 2, maximum: 25}
  validates :subject, presence: true, length: {minimum: 2, maximum: 30}
  validates :topic1, presence: true, length: {minimum: 2, maximum: 30}
  validates :topic2, presence: true, length: {minimum: 2, maximum: 30}
  validates :links, presence: true

  def as_json(options = nil)
    if options && options[:for_js]
      super(except: [:updated_at, :created_at, :user_id]).tap{|list| list["links"] = self.links.index_by{|link| link.id}.transform_values!{|link| link.as_json(only: [:word1, :word2])}}
    else
      super
    end
  end
end
