class User < ActiveRecord::Base
  # Associations
  # TODO: Check for other managers and transfer ownership before destroying company
  has_one :owned_company, class_name: "Company", foreign_key: :owner_id, dependent: :destroy
  belongs_to :company

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :owned_company_attributes, :company_attributes

  # Validations
  validates_presence_of :name
  
  # Nested attributes
  accepts_nested_attributes_for :owned_company, :company

  # Callbacks
  before_create :set_company

  # Callback functions
  def set_company
    self.company = self.owned_company if self.owned_company
  end

  # Virtual attributes
  def first_name
    name.split(" ", 2).first
  end

  def last_name
    name.split(" ", 2).last
  end
end