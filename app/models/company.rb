class Company < ActiveRecord::Base
  # Associations
  belongs_to :owner, class_name: "User"
  has_one :address, as: :addressable, dependent: :destroy
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :logo, :name, :phone, :subdomain, :website, :address_attributes

  # Validations
  
  # Nested attributes
  accepts_nested_attributes_for :address
  
  # Callbacks
end
