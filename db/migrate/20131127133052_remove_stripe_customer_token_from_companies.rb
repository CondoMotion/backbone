class RemoveStripeCustomerTokenFromCompanies < ActiveRecord::Migration
  def change
    remove_column :companies, :stripe_customer_token
  end
end
