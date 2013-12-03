module Admin
  class BaseController < ::ApplicationController
    around_filter :scope_current_company
    before_filter :check_admin_user_company
    layout "admin"
  end
end