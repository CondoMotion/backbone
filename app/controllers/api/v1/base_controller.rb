module Api
  module V1
    class BaseController < ApplicationController
      around_filter :scope_current_company
    end
  end
end