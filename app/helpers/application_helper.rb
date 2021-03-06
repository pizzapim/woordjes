module ApplicationHelper
  def more_fields(f)
    new_link = f.object.class.reflect_on_association(:links).klass.new
    fields = f.fields_for(:links, new_link, child_index: "new_links") do |builder|
      render("link_fields", f: builder)
    end
    fields
  end

  def quiz_types
    ["normal"]
  end

  def quiz_types_collection
    quiz_types.map{|type| [t("quiz_types.#{type}"), type]}
  end

  def resource
    @new_user || User.new
  end

  def resource_name
    :user
  end

  def resource_class
    User
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
