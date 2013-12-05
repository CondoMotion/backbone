class Subscription < ActiveRecord::Base
  belongs_to :company
  belongs_to :plan

  attr_accessible :email, :last_4_digits, :name, :stripe_customer_token, :plan_id

  validates_presence_of :name, :email, :plan_id

  before_destroy :delete_stripe_customer
  before_update :update_stripe

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

  def update_stripe
    customer = self.stripe_customer
    if company.stripe_card_token.present?
      customer.card = company.stripe_card_token
    end
    customer.email = email
    customer.description = name
    customer.update_subscription(plan: plan.name)
    customer.save
    self.last_4_digits = customer.active_card.last4
    self.stripe_customer_token = customer.id
  rescue Stripe::StripeError => e
    logger.error "Stripe Error: " + e.message
    errors.add :base, "Unable to update your subscription. #{e.message}."
    false
  end

end