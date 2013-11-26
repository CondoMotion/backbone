class User < ActiveRecord::Base
  # Associations
  has_one :owned_company, class_name: "Company", foreign_key: :owner_id, dependent: :destroy
  belongs_to :company

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :owned_company_attributes

  # Validations

  # Nested attributes
  accepts_nested_attributes_for :owned_company

  # Callbacks
  after_create :set_company

  # Callback functions
  def set_company
    if self.owned_company
      self.company = self.owned_company
      self.save
    end
  end

  # Virtual attributes
  def first_name
    name.split(" ", 2).first
  end

  def last_name
    name.split(" ", 2).last
  end

  # Stripe
  def save_with_payment
    if valid?
      customer = Stripe::Customer.create(description: name, email: email, plan: self.owned_company.plan_id, card: self.owned_company.stripe_card_token)
      self.owned_company.stripe_customer_token = customer.id
      self.save!
    end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end

  def update_stripe
    return if self.owned_company.nil?
    return unless valid?
    customer = Stripe::Customer.retrieve(self.owned_company.stripe_customer_token)
    customer.email = self.email
    customer.description = self.name
    customer.save
    true
  rescue Stripe::StripeError => e
    logger.error "Stripe Error: " + e.message
    errors.add :base, "#{e.message}."
    false
  end
end