class Company < ActiveRecord::Base
  attr_accessor :stripe_card_token, :plan_id

  # Associations
  belongs_to :owner, class_name: "User"
  has_one :address, as: :addressable, dependent: :destroy
  has_one :subscription, dependent: :destroy
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :logo, :name, :phone, :subdomain, :website, :stripe_card_token, :plan_id, :address_attributes

  # Validations
  validates_presence_of :name, :subdomain
  validates_uniqueness_of :subdomain
  
  # Nested attributes
  accepts_nested_attributes_for :address
  
  # Callbacks
  before_create :format_subdomain

  # Callback function
  def format_subdomain
    self.subdomain = self.subdomain.parameterize
  end

  # Virtual attributes
end
