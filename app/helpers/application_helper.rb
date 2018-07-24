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
end
