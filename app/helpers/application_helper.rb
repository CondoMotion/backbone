module ApplicationHelper
  def resource_name
    if request.subdomain.present? && request.subdomain != 'www'
      :admin_user
    else
      :user
    end
  end
 
  def resource
    @resource ||= User.new
  end
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
