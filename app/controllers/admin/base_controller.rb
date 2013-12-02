module Admin
  class BaseController < ::ApplicationController
    around_filter :scope_current_company
    layout "admin"
  end
end