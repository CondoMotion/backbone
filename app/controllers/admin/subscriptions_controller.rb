module Admin
  class SubscriptionsController < BaseController
    before_filter :authenticate_admin_user!

    def update
      @subscription = current_company.subscription
      @partial = params[:active_tab] + "_form"
      # @charges = @stripe.charges if params[:active_tab] == "subscription"

      if @subscription.update_attributes(params[:subscription])
        @stripe = @subscription.stripe_customer
        @subscription.update_stripe(@stripe, @subscription.stripe_card_token)
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