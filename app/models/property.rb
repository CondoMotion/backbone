class Property < ActiveRecord::Base
  attr_accessible :name, :signup_password, :subdomain
end
