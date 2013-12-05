class Subscription < ActiveRecord::Base
  attr_accessor :stripe_card_token
  belongs_to :company
  belongs_to :plan

  attr_accessible :email, :last_4_digits, :name, :stripe_customer_token, :plan_id, :stripe_card_token

  validates_presence_of :name, :email, :plan_id

  before_destroy :delete_stripe_customer

  def stripe_customer
    Stripe::Customer.retrieve(stripe_customer_token) unless stripe_customer_token.nil?
  rescue Stripe::StripeError => e
    logger.error "Stripe Error: " + e.message
    errors.add :base, "Unable to load your subscription. #{e.message}."
    false
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

  def update_stripe(customer, token = nil)
    customer.email = email
    customer.description = name
    customer.update_subscription(plan: plan.name)
    if token.present?
      customer.card = token
      self.last_4_digits = customer.active_card.last4
      self.stripe_customer_token = customer.id
      self.stripe_card_token = nil
    end
    customer.save
    self.save!
  rescue Stripe::StripeError => e
    logger.error "Stripe Error: " + e.message
    errors.add :base, "Unable to update your subscription. #{e.message}."
    self.stripe_card_token = nil
    false
  end

end