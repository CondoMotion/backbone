module Api
  module V1
    class BaseController < ApplicationController
      around_filter :scope_current_company

      def default_serializer_options
        {root: false}
      end
    end
  end
end