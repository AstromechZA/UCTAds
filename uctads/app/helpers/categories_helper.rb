module CategoriesHelper

  # Method to generate tree view of categories
  # This is faster than using recursive partical views.
  def nested_categories_view(categories)
    content_tag(:ul,
      categories.map do |category,children|
        content_tag(:li,
          content_tag(:p,
            link_to(category.name, category) + ' : ' +
            (category.fields.nil? ? '[]' : category.fields.keys.sort.to_s)
          ) + nested_categories_view(children)
        )
      end.join.html_safe
    )
  end

end
