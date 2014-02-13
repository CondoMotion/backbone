class PrototypesController < ApplicationController
  layout "prototype"
  
  def index
    params[:pp] = "disable"
    @issues = 20
  end

  def resident
    params[:pp] = "disable"
    @names = ["Jon Smith", "Nick Jones", "Sam Taylor", "Monica Reed", "James Green", "Jane Folders", "Marcus Xavier", "Hugo Lander", "Alan Voyers", "Timothy Allen", "Fred Bore", "Randolph Saunders"]
  end
end
