module ApplicationHelper
  # Returns the full title on a per-page basis
  def full_title(page_title = '')
    base_title = "Members Only"
    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end
end
