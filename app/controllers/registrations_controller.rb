class RegistrationsController < ApplicationController
  before_filter :load_plan, only: :new

  def new
    @user = User.new
    @company = @user.build_owned_company
    @address = @company.build_address
  end

  def create
    @user = User.new(params[:user])
    @company = @user.build_owned_company(params[:user][:owned_company_attributes])
    @address = @company.build_address(params[:user][:owned_company_attributes][:address_attributes])

    if @user.save_with_payment
      sign_in @user
      redirect_to admin_root_url(subdomain: @company.subdomain.parameterize), notice: "Welcome! You have signed up successfully."
    else
      render 'new'
    end
  end

private
  
  def load_plan
    @plan = Plan.find_by_name(params[:plan_id])
    unless @plan
      redirect_to pricing_path, flash: { error: "Please select a valid plan." }
    end
  end
end