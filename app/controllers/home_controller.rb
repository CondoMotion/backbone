class HomeController < ApplicationController
  def index
  end

  def about
  end

  def contact
  end

  def pricing
    @plans = Stripe::Plan.all
  end
end
