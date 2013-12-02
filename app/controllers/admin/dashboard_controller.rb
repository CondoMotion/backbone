module Admin
  class DashboardController < BaseController
    before_filter :authenticate_admin_user!
    def index
    end
  end
end