module CategoriesHelper

  # Method to generate tree view of categories
  # This is faster than using recursive partical views.
  def nested_categories_view(categories)
    content_tag(:ul,
      categories.map do |category,children|
        content_tag(:li,
          content_tag(:div,
            content_tag(:span, nil, {class: 'glyphicon glyphicon-chevron-right', style: 'padding-right: 10px; color: #666;'}) +
            link_to(category.name, show_category_path(category)) +
            " (#{category.fields.keys.sort.join(', ')})" +
            link_to(
              content_tag(:span, nil, {class: 'glyphicon glyphicon-remove'}), destroy_category_path(category),
                    :data => { confirm: 'Are you sure you want to delete this category and its children?' },
                    :method => :delete,
                    :action => :delete,
                    class: 'btn btn-danger btn-xs pull-right'), {class: 'panel-heading'}
          ) + content_tag(:div, '', {class: 'clearfix'}) + nested_categories_view(children),
        {class: 'panel panel-default', style: 'margin: 5px 5px 5px 0px;'})
      end.join.html_safe
    )
  end

end
