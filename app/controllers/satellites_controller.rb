class SatellitesController < ApplicationController
  before_action :remote_ip

  def show
    @satellite = SatelliteFacade.get_satellite_position(params[:sat_id])
    @visibility = SatelliteFacade.get_satellite_visibility(params[:sat_id], @lat, @long)
    @weather_forecasts = WeatherFacade.get_weather_forecast(@lat, @long)
    @messages = SatelliteFacade.get_sat_message_id(params[:sat_id])
    @sat_id = SatelliteFacade.create_user_satellite(params[:sat_id], session[:user_id])
  end
end