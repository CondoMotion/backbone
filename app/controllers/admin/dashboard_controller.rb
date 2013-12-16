module Admin
  class DashboardController < BaseController
    before_filter :authenticate_admin_user!

    def index
      gon.environment = Rails.env
      gon.current_user = current_admin_user
      gon.current_company = current_company
    end
  end
end