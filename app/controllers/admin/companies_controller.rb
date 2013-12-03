module Admin
  class CompaniesController < BaseController
    before_filter :authenticate_admin_user!, except: :show

    def show
      if admin_user_signed_in? 
        redirect_to admin_root_url
      else
        @company = current_company
      end
    end

    def edit
      @company = current_company
    end

    def update
      @company = current_company

      if @company.update_attributes(params[:company])
        respond_to do |format|
          format.html { redirect_to edit_admin_company_path, notice: "Company details successfully updated." }
          format.js
        end
      else
        respond_to do |format|
          format.html { render 'edit' }
          format.js
        end
      end
    end
  end
end