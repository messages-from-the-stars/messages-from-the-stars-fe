class DiscoverController < ApplicationController
  before_action :remote_ip

  def index
    @satellites = SatelliteFacade.above_satellites(@lat, @long)
  end

end