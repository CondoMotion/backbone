module NavigationHelper
  def nav_link_to(text, route)
    content_tag :li, class: ("active" if current_page?(route)) do
      link_to text, route
    end
  end
end