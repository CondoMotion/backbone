class HomeController < ApplicationController
  def index
  end

  def about
  end

  def contact
  end

  def pricing
    @plans = Plan.all
  end
end
