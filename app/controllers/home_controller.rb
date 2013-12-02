class HomeController < ApplicationController
  def index
  end

  def about
  end

  def contact
  end

  def pricing
    flash.keep
    @plans = Plan.all
  end
end
