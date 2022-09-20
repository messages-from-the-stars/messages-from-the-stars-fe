class DiscoverController < ApplicationController
  before_action :remote_ip, :logged_in_user

  def index
    @satellites = SatelliteFacade.above_satellites(@lat, @long)
    @message_count_arrays = []
    @satellites.each do |satellite|
      @message_count_arrays << MessageFacade.get_message_count(satellite.satid) 
    end 
  end
end