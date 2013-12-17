class PrototypesController < ApplicationController
  layout "prototype"
  def index
    params[:pp] = "enable"
  end
end