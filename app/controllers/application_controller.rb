class ApplicationController < ActionController::Base
  layout :layout_by_resource

  protect_from_forgery

  def after_sign_in_path_for(resource)
    dashboard_path
  end

protected
  
  def layout_by_resource
    if editing_profile
      "admin"
    else
      "application"
    end
  end

  def editing_profile
    params[:controller] == "registrations" && params[:action] == "edit"
  end
end
