class PrototypesController < ApplicationController
  layout "prototype"
  def index
    params[:pp] = "enable"
    @issues = 40
  end
end