class DiscoverController < ApplicationController

  def index
    @satellites = SatelliteFacade.above_satellites(params[:lat], params[:long])
  end

end