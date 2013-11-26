class Address < ActiveRecord::Base
  # Associations
  belongs_to :addressable, polymorphic: true
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :address1, :address2, :city, :state, :zip

  # Validations
  validates_presence_of :address1, :city, :state, :zip
  
  # Nested attributes
  
  # Callbacks

  # Callback functions

  # Virtual attributes
  def city_state_zip
    city + ", " + state + " " + zip
  end
end
