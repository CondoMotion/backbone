module NavigationHelper
  def nav_link_to(text, route)
    content_tag :li, class: ("active" if current_page?(route)) do
      link_to text, route
    end
  end

  def prototype_partial_link(text, partial, target, options = {})
    link_to text, prototype_page_path(page: partial), remote: true, class: "prototype-partial-link #{options[:class]}", data: { target: target }, style: options[:style]
  end
end