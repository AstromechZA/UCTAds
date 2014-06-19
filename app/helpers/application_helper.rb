module ApplicationHelper

  def title(page_title)
    content_for(:title) { page_title }
  end

  def bootstrap_class_for(type)
     return {
        'info' => 'alert-info',
        'success' => 'alert-success',
        'notice' => 'alert-success',
        'error' => 'alert-danger',
        'alert' => 'alert-danger',
        'warning' => 'alert-warning'
      }[type] || type.to_s
  end

  def text_truncate(text, limit=100)
    truncate(text, length: limit, separator: ' ')
  end



end
