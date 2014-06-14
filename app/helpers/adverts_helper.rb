module AdvertsHelper

  def nested_categories_tree(categories)
    content_tag(
      :ul,
      categories.map do |category,children|
        content_tag(
          :li,
          content_tag(
            :div,
            content_tag(:i, nil, {class: 'fa fa-angle-right', style: 'padding-right: 10px; color: #666;'}) +
            link_to(category.name, 'javascript:void(0);', onclick: 'AdvertStageOneBuilder.next('+category.id.to_s+')'),
            {class: 'panel-heading'}
          ) + nested_categories_tree(children),
          {class: 'panel panel-default', style: 'margin: 5px 5px 5px 0px;'}
        )
      end.join.html_safe
    )
  end

  def build_side_bar_tree(categories, selected=nil)

    li_s = []

    categories.keys.sort_by {|k| k.name }.each do |k|
      content = content_tag(:span, nil)
      if selected.nil? or k.id != selected
        content += link_to(k.name, adverts_by_category_path(k))
      else
        content += link_to(k.name, adverts_by_category_path(k), style: 'font-weight: bold')
      end
      content = content_tag(:div, content) + build_side_bar_tree(categories[k], selected)
      content = content_tag(:li, content)
      li_s << content
    end

    content_tag(:ul, li_s.join.html_safe)
  end

  def format_number_rands(n)
    number_to_currency(n, unit: 'R', precision: 0, delimiter: ',')
  end

  def format_number_cents(n)
    n = n % 1
    "." + (n % 1 * 100).round.to_i.to_s.rjust(2, '0')
  end

  def format_number_pretty(n)
    number_to_currency(n, unit: 'R', precision: ((n%1) > 0.001) ? 2 : 0, delimiter: ',')
  end

end
