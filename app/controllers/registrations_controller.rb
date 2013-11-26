class RegistrationsController < Devise::RegistrationsController
  before_filter :validate_plan, only: :new

  def new
    @user = User.new
    @company = @user.build_owned_company(plan_id: params[:plan_id])
    @address = @company.build_address
  end

  def create
    build_resource(sign_up_params)

    if resource.save_with_payment
      yield resource if block_given?
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      @company = resource.build_owned_company(params[:user][:owned_company_attributes])
      @address = @company.build_address(params[:user][:owned_company_attributes][:address_attributes])
      @plan = Stripe::Plan.retrieve(params[:user][:owned_company_attributes][:plan_id])
      clean_up_passwords resource
      respond_with resource
    end
  end

  def update
    @user = User.find(current_user.id)

    @old_stripe_details = {name: @user.name, email: @user.email}

    successfully_updated = if needs_password?(@user, params)
      @user.update_with_password(params[:user])
      @user.update_stripe if stripe_details_changed?(@user, @old_stripe_details)
    else
      # remove the virtual current_password attribute update_without_password
      # doesn't know how to ignore it
      params[:user].delete(:current_password)
      @user.update_without_password(params[:user])
      @user.update_stripe if stripe_details_changed?(@user, @old_stripe_details)
    end

    if successfully_updated
      # Sign in the user bypassing validation in case his password changed
      sign_in @user, :bypass => true
      respond_to do |format|
        format.html { redirect_to after_update_path_for(@user), notice: :updated }
        format.js
      end
    else
      respond_to do |format|
        format.html { render "edit" }
        format.js
      end
    end
  end


protected
  def validate_plan
    if params[:plan_id].present?
      @plan = Stripe::Plan.retrieve(params[:plan_id])
    else
      redirect_to pricing_path, flash: { notice: "Please select a plan" }
    end
  rescue Stripe::InvalidRequestError => e
    redirect_to pricing_path, flash: { notice: "Please select a valid plan" }
  end

  def needs_password?(user, params)
    params[:user][:password].present?
  end

  def stripe_details_changed?(user, params)
    params[:email] != user.email || params[:name] != user.name
  end

  def after_update_path_for(resource)
    edit_user_registration_path
  end
end