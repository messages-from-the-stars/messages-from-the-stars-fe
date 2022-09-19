class Api::V1::SatellitesController < ApplicationController
  before_action :remote_ip

  def show
    @satellite = SatelliteFacade.get_satellite_position(params[:id])
    @visibility = SatelliteFacade.get_satellite_visibility(params[:id], @lat, @long)
    @weather_forecasts = WeatherFacade.get_weather_forecast(@lat, @long)
    @messages = SatelliteFacade.get_sat_message_id(params[:id])
    SatelliteFacade.create_user_satellite(params[:id], session[:user_id])
  end
end