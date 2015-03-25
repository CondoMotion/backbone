class PrototypesController < ApplicationController
  layout "prototype"
  
  def index
    @issues = 20
  end

  def page
    respond_to do |format|
      format.html { render params[:page] }
      format.js { render partial: "prototypes/#{params[:page].gsub('::', '/')}.html" }
    end
  end

  def resident
    @names = ["Jon Smith", "Nick Jones", "Sam Taylor", "Monica Reed", "James Green", "Jane Folders", "Marcus Xavier", "Hugo Lander", "Alan Voyers", "Timothy Allen", "Fred Bore", "Randolph Saunders"]
  end
end
