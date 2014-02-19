module AdvertsHelper

  def nested_categories_tree(categories)
    content_tag(:ul,
      categories.map do |category,children|
        content_tag(:li,
          content_tag(:p,
            link_to(category.name, category)
          ) + nested_categories_tree(children)
        )
      end.join.html_safe
    )
  end
end
