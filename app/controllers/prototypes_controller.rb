class PrototypesController < ApplicationController
  layout :set_layout
  
  def index
    @issues = 20
  end

  def page
    expires_now
    respond_to do |format|
      format.html { render "prototypes/#{params[:page].gsub('::', '/')}" }
      format.js { render partial: (website? ? "prototypes/website/iframe" : "prototypes/#{params[:page].gsub('::', '/')}"), formats: [:html] }
    end
  end

  def resident
    @names = ["Jon Smith", "Nick Jones", "Sam Taylor", "Monica Reed", "James Green", "Jane Folders", "Marcus Xavier", "Hugo Lander", "Alan Voyers", "Timothy Allen", "Fred Bore", "Randolph Saunders"]
  end

  def website?
    params[:page].split("::")[0] == "website"
  end

  def set_layout
    if website?
      "website"
    else
      "prototype"
    end
  end
end
