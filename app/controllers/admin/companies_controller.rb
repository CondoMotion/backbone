module Admin
  class CompaniesController < BaseController

    def show
      if admin_user_signed_in? 
        redirect_to admin_root_url
      else
        @company = current_company
      end
    end
  
  end
end