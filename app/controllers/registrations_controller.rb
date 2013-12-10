class RegistrationsController < ApplicationController
  before_filter :load_plan, only: :new

  def new
    @user = User.new
    @company = @user.build_owned_company
    # @address = @company.build_address
    @subdomain = @company.build_subdomain
    @subscription = @company.build_subscription
    @subscription.plan = @plan
  end

  def create
    @user = User.new(params[:user])
    @user.company = @user.owned_company
    @user.owned_company.subscription.name = @user.name
    @user.owned_company.subscription.email = @user.email

    if @user.save
      sign_in @user
      redirect_to admin_root_url(subdomain: @user.company.subdomain.name), notice: "Welcome! You have signed up successfully."
    else
      render 'new'
    end
  end

private
  
  def load_plan
    @plan = Plan.find_by_name(params[:plan_id])
    unless @plan
      redirect_to pricing_url, flash: { error: "Please select a valid plan." }
    end
  end
end