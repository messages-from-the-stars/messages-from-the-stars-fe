class DiscoverController < ApplicationController
  before_action :remote_ip

  def index
    @satellites = SatelliteFacade.above_satellites(@lat, @long)
    @message_count = @satellites.map do |satellite|
      SatelliteFacade.get_sat_message_id(satellite.satid)
    end.flatten
  end

end