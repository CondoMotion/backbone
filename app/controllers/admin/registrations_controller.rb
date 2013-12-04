module Admin
  class RegistrationsController < ::Devise::RegistrationsController
    layout "admin"
    before_filter :authenticate_admin_user!, only: [:edit, :update]
    around_filter :scope_current_company, only: [:edit, :update]
    before_filter :check_admin_user_company, only: [:edit, :update]

    def edit
      @subscription = current_company.subscription
      @stripe = @subscription.stripe_customer
      @charges = @stripe.charges
      super
    end

    def update
      @user = current_admin_user

      successfully_updated = if needs_password?(@user, params)
        @user.update_with_password(params[:admin_user])
      else
        # remove the virtual current_password attribute update_without_password
        # doesn't know how to ignore it
        params[:admin_user].delete(:current_password)
        @user.update_without_password(params[:admin_user])
      end

      if successfully_updated
        load_stripe_variables
        # Sign in the user bypassing validation in case his password changed
        sign_in @user, :bypass => true
        respond_to do |format|
          format.html { redirect_to after_update_path_for(@user), notice: :updated }
          format.js
        end
      else
        load_stripe_variables
        respond_to do |format|
          format.html { render "edit" }
          format.js
        end
      end
    end

  private
    def load_stripe_variables
      if %w[subscription card].include? params[:active_tab] 
        @subscription = current_company.subscription
        @stripe = @subscription.stripe_customer
      end
      if params[:active_tab] == "subscription"
        @charges = @stripe.charges
      end
      @partial = params[:active_tab] + "_form"
    end

    def after_update_path_for(resource)
      edit_admin_user_registration_path
    end

    def needs_password?(user, params)
      params[:admin_user][:password].present?
    end
  end
end