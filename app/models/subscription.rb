class Subscription < ActiveRecord::Base
  attr_accessor :stripe_card_token
  belongs_to :company
  belongs_to :plan

  attr_accessible :email, :last_4_digits, :name, :stripe_customer_token, :plan_id, :stripe_card_token

  validates_presence_of :name, :email, :plan_id

  before_create :create_stripe_customer
  before_destroy :delete_stripe_customer

  def quantity
    1
  end

  def stripe_customer
    Stripe::Customer.retrieve(stripe_customer_token) unless stripe_customer_token.nil?
  rescue Stripe::StripeError => e
    logger.error "Stripe Error: " + e.message
    errors.add :base, "Unable to load your subscription. #{e.message}."
    false
  end

  def update_stripe #(customer, token = nil)
    customer = self.stripe_customer
    customer.email = email
    customer.description = name
    customer.update_subscription(plan: plan.name)
    if self.stripe_card_token.present?
      customer.card = self.stripe_card_token
    end
    customer.save
    self.last_4_digits = customer.active_card.last4
    self.stripe_customer_token = customer.id
    self.stripe_card_token = nil
    self.save!
  rescue Stripe::StripeError => e
    logger.error "Stripe Error: " + e.message
    errors.add :base, "Unable to update your subscription. #{e.message}."
    self.stripe_card_token = nil
    false
  end

protected

  def create_stripe_customer
    customer = Stripe::Customer.create(description: self.name, email: self.email, plan: self.plan.name, card: self.stripe_card_token)
    self.stripe_customer_token = customer.id
    self.last_4_digits = customer.active_card.last4
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
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

end