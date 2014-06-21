module AdvertsHelper

  def nested_categories_tree(categories)
    li_s = []

    categories.keys.each do |k|
      content = content_tag(:i, nil, {class: 'fa fa-angle-right', style: 'padding-right: 10px;'})
      content = link_to( content + k.name, 'javascript:void(0);', onclick: 'AdvertStageOneBuilder.next('+k.id.to_s+')')
      content = content_tag(:div, content, {class: 'panel-heading panel-heading-sm'}) + nested_categories_tree(categories[k])
      content = content_tag(:li, content, {class: 'panel panel-default', style: 'margin: 5px 5px 5px 0px;'})
      li_s << content
    end

    content_tag(:ul, li_s.join.html_safe)
  end

  def build_side_bar(categories, selected=nil)
    style = selected.nil? ? 'font-weight: bold' : ''
    content = content_tag(:span, nil) + link_to("All", adverts_path, style: style)
    content = content_tag(:div, content)
    content = content_tag(:li, content)
    html = content_tag(:ul, content.html_safe, class: 'sidebar-categories')

    html += build_side_bar_tree(categories, selected)

    html
  end

  def build_side_bar_tree(categories, selected=nil)
    li_s = []

    categories.keys.sort_by {|k| k.name }.each do |k|
      style = (selected.nil? or k.id != selected) ? '' : 'font-weight: bold'
      content = content_tag(:span, nil) + link_to(k.name, adverts_by_category_path(k), style: style)
      content = content_tag(:div, content) + build_side_bar_tree(categories[k], selected)
      content = content_tag(:li, content)
      li_s << content
    end

    content_tag(:ul, li_s.join.html_safe, class: 'sidebar-categories')
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
