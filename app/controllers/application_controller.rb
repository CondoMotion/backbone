class ApplicationController < ActionController::Base
  protect_from_forgery

protected

  def current_company
    Company.find_by_subdomain! request.subdomain
  end
  helper_method :current_company

  def scope_current_company
    Company.current_id = current_company.id
    yield
  ensure
    Company.current_id = nil
  end
end
