class Company < ActiveRecord::Base
  attr_accessor :stripe_card_token, :plan_id

  # Associations
  belongs_to :owner, class_name: "User"
  has_one :address, as: :addressable, dependent: :destroy
  has_one :subscription, dependent: :destroy
  has_one :subdomain, as: :subdomainable, dependent: :destroy
  has_many :users
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :logo, :name, :phone, :website, :stripe_card_token, :plan_id, :address_attributes, :owner_id, :subdomain_attributes

  # Validations
  validates_presence_of :name
  
  # Nested attributes
  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :subdomain
  
  # Callbacks

  # Callback function

  # Virtual attributes
  def self.current_id=(id)
    Thread.current[:company_id] = id
  end

  def self.current_id
    Thread.current[:company_id]
  end
end
