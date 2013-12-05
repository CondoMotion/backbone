class Property < ActiveRecord::Base
  # Associations
  has_one :subdomain, as: :subdomainable, dependent: :destroy

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :signup_password, :subdomain_attributes

  # Validations
  validates_presence_of :name, :signup_password
  validates_uniqueness_of :name, scope: :company_id
  
  # Scopes
  default_scope { where(company_id: Company.current_id) }

  # Nested attributes
  accepts_nested_attributes_for :subdomain
  
  # Callbacks

  # Callback function

  # Virtual attributes
end
