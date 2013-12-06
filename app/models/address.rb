class Address < ActiveRecord::Base
  # Associations
  belongs_to :addressable, polymorphic: true
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :address1, :address2, :city, :state, :zip

  # Validations
  validates_presence_of :address1, :city, :state, :zip
  validates_numericality_of :zip
  validates_length_of :zip, is: 5
  
  # Nested attributes
  
  # Callbacks

  # Virtual attributes
  def city_state_zip
    city + ", " + state + " " + zip
  end

  # Callback functions
end
