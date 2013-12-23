class PrototypesController < ApplicationController
  layout "prototype"
  
  def index
    params[:pp] = "disable"
    @issues = 40
  end

  def resident
    params[:pp] = "disable"
  end
end