class ApplicationController < ActionController::Base
  protect_from_forgery
  serialization_scope :view_context
  
protected

  def current_company
    subdomain = Subdomain.includes(:subdomainable).find_by_name!(request.subdomain)
    if subdomain.subdomainable_type = "Company"
      subdomain.subdomainable
    else
      subdomain.subdomainable.company
    end
  end
  helper_method :current_company

  def scope_current_company
    Company.current_id = current_company.id
    yield
  ensure
    Company.current_id = nil
  end
    
  def check_admin_user_company
    if admin_user_signed_in?
      unless current_admin_user.company == current_company
        redirect_to admin_root_url(subdomain: current_admin_user.company.subdomain.name), flash: { error: "You're not a member of that company." }
      end
    end
  end
end
