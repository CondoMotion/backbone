class Company < ActiveRecord::Base
  attr_accessor :stripe_card_token, :plan_id

  # Associations
  belongs_to :owner, class_name: "User"
  has_one :address, as: :addressable, dependent: :destroy
  has_one :subscription, dependent: :destroy
  has_one :subdomain, as: :subdomainable, dependent: :destroy
  has_many :users
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :logo, :name, :phone, :website, :stripe_card_token, :plan_id, :address_attributes, :owner_id, :subdomain_attributes, :subscription_attributes

  # Validations
  validates_presence_of :name
  validate :owner_must_be_company_manager, on: :update
  
  # Nested attributes
  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :subdomain
  accepts_nested_attributes_for :subscription
  
  # Callbacks

  # Virtual attributes
  def self.current_id=(id)
    Thread.current[:company_id] = id
  end

  def self.current_id
    Thread.current[:company_id]
  end

  def owner_must_be_company_manager
    unless User.find(self.owner_id).company_id == self.id
      errors.add(:owner_id, "must be a member of this company")
    end
  end

  # Callback functions
end
