module Admin
  class PasswordsController < ::Devise::PasswordsController
    layout "admin"
  end
end