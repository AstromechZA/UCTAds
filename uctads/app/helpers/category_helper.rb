module CategoryHelper

  # Method to generate tree view of categories
  # This is faster than using recursive partical views.
  def nested_categories_view(categories)
    ('<ul>' + categories.map do |category, sub_categories|
      '<li><p>' + category.name + '</p>' + nested_categories_view(sub_categories) + '</li>'
    end.join + '</ul>').html_safe
  end

end
