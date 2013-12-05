class Plan < ActiveRecord::Base
  has_many :subscriptions

  attr_accessible :amount, :interval, :name

  def trial_period_days
    30
  end

  def titleized_name
    name.titleize
  end
end
