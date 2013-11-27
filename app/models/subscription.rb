class Subscription < ActiveRecord::Base
  belongs_to :company
  attr_accessible :email, :last_4_digits, :name, :stripe_customer_token

  before_destroy :delete_stripe_customer

  def stripe_customer
    Stripe::Customer.retrieve(stripe_customer_token) unless stripe_customer_token.nil?
  end

  def delete_stripe_customer
    customer = self.stripe_customer
    unless customer.nil?
      customer.delete
    end
  rescue Stripe::StripeError => e
    logger.error "Stripe Error: " + e.message
    errors.add :base, "Unable to cancel your subscription. #{e.message}."
    false
  end
end