module AdvertsHelper

  def nested_categories_tree(categories)
    content_tag(
      :ul,
      categories.map do |category,children|
        content_tag(
          :li,
          content_tag(
            :div,
            content_tag(:span, nil, {class: 'glyphicon glyphicon-chevron-right', style: 'padding-right: 10px; color: #666;'}) +
            link_to(category.name, 'javascript:void(0);', onclick: 'AdvertStageOneBuilder.next('+category.id.to_s+')'),
            {class: 'panel-heading'}
          ) + nested_categories_tree(children),
          {class: 'panel panel-default', style: 'margin: 5px 5px 5px 0px;'}
        )
      end.join.html_safe
    )
  end
end
