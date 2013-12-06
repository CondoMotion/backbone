module Admin
  class SubscriptionsController < BaseController
    before_filter :authenticate_admin_user!

    def update
      @subscription = current_company.subscription
      @partial = params[:active_tab] + "_form"

      if @subscription.update_attributes(params[:subscription])
        @subscription.update_stripe
        respond_to do |format|
          format.js
        end
      else
        respond_to do |format|
          format.js
        end
      end
    end

  end
end