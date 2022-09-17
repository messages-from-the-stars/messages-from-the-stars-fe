class DiscoverController < ApplicationController

  def index
    @satellites = SatelliteFacade.above_satellites(params[:lat_long])
  end

end