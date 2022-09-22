class SatellitesController < ApplicationController
  before_action :logged_in_user, :remote_ip, 

  def show
    @sat_id = SatelliteFacade.create_satellite(params[:sat_id])
    @satellite = SatelliteFacade.get_satellite_position(params[:sat_id])
    if @satellite != 404 
      @visibility = SatelliteFacade.get_satellite_visibility(params[:sat_id], @lat, @long)
      @weather_forecasts = WeatherFacade.get_weather_forecast(@lat, @long)
      @messages = SatelliteFacade.get_sat_message_id(@sat_id)
      @map_url = SatMapMaker.new(@satellite.sat_lat, @satellite.sat_lng).result_url
    end 
  end
end