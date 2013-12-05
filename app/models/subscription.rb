class Subscription < ActiveRecord::Base
  attr_accessor :stripe_card_token
  belongs_to :company
  belongs_to :plan

  attr_accessible :email, :last_4_digits, :name, :stripe_customer_token, :plan_id

  validates_presence_of :name, :email, :plan_id

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

  def update_stripe_details(customer)
    customer.email = email
    customer.description = name
    customer.update_subscription(plan: plan.name)
    customer.save
  end

  # def update_stripe
  #   customer = self.stripe_customer
  #   customer.card = stripe_card_token if stripe_card_token.present?
  #   customer.email = email
  #   customer.description = name
  #   customer.update_subscription(plan: plan.name)
  #   customer.save
  #   last_4_digits = customer.active_card.last4
  #   stripe_customer_token = customer.id
  #   stripe_card_token = nil
  #   save!
  # rescue Stripe::StripeError => e
  #   logger.error "Stripe Error: " + e.message
  #   errors.add :base, "Unable to update your subscription. #{e.message}."
  #   stripe_card_token = nil
  #   false
  # end

end