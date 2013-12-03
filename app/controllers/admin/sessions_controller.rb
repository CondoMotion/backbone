module Admin
  class SessionsController < ::Devise::SessionsController
    layout "admin"
    around_filter :scope_current_company, only: [:new, :create]

  private
    
    def after_sign_in_path_for(resource)
      admin_root_url
    end

    def after_sign_out_path_for(resource)
      company_root_url
    end
  end
end