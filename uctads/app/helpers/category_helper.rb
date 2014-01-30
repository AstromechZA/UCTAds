module CategoryHelper

  # Method to generate tree view of categories
  # This is faster than using recursive partical views.
  def nested_categories_view(categories)
    ('<ul>' + categories.map do |category, sub_categories|
      o = '<li>'
      o += '<p>' + category.name + ' : '
      o += (category.fields.nil? ? '[]' : category.fields.keys.to_s) + '</p>'
      o += nested_categories_view(sub_categories)
      o + '</li>'
    end.join + '</ul>').html_safe
  end

end
