class RegistrationsController < Devise::RegistrationsController
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

  def after_update_path_for(resource)
    edit_user_registration_path
  end
end