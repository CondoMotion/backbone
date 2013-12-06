class Subdomain < ActiveRecord::Base
  attr_accessible :name
  belongs_to :subdomainable, polymorphic: true
  validates :name, uniqueness: true, presence: true
  before_validation :format_subdomain

protected
  def format_subdomain
    self.name = self.name.parameterize
  end
end
