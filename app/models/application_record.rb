class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def t(attribute)
    self.class.human_attribute_name(attribute)
  end

  def ta(association, count=1)
    self.class.reflect_on_association(association).klass.model_name.human(count: count)
  end

  def taa(association, attribute)
    self.class.reflect_on_association(association).klass.human_attribute_name(attribute)
  end
end
