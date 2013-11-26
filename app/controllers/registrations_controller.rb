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
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    if update_resource(resource, account_update_params)
      yield resource if block_given?
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      sign_in resource_name, resource, :bypass => true
      respond_to do |format|
        format.html { respond_with resource, :location => after_update_path_for(resource) }
        format.js
      end
    else
      clean_up_passwords resource
      respond_to do |format|
        format.html { redirect_to edit_user_registration_path, flash: { error: "There was an error updating your profile: #{resource.errors.full_messages[0]}" } }
        format.js
      end
    end
  end

protected
  def validate_plan
    if params[:plan_id].present? && Stripe::Plan.retrieve(params[:plan_id])
      @plan = Stripe::Plan.retrieve(params[:plan_id])
    else
      redirect_to pricing_path, flash: { notice: "Please select a plan" }
    end
  rescue Stripe::InvalidRequestError => e
    redirect_to pricing_path, flash: { notice: "Please select a valid plan" }
  end

  def after_update_path_for(resource)
    edit_user_registration_path
  end
end