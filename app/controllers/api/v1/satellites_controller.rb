class Api::V1::SatellitesController < ApplicationController
  def show
    @satellite = SatelliteFacade.get_satellite_position(params[:id])
    @visibility = SatelliteFacade.get_satellite_visibility(params[:id], @lat, @long)
    @weather_forecasts = WeatherFacade.get_weather_forecast(@lat, @long)
    @messages = SatelliteFacade.get_sat_message_id(params[:id])
    @user = User.find_or_create_by(id: params[:user_id])
  end
end