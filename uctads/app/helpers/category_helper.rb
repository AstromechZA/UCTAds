module CategoryHelper


  def nested_categories_view(categories)
    categories.map do |category, sub_categories|
      '<p>' + category.name + '</p><div style="margin-left:20px">' + nested_categories_view(sub_categories) + '</div>'
    end.join.html_safe
  end

end
