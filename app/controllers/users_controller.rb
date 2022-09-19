class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show]
  before_action :remote_ip

  def create
    user_info = request.env['omniauth.auth']
    if user_info['credentials']['token'].present?
      @user = UserFacade.find_or_create_user(user_info['info']['name'], user_info['info']['email'])
      set_session(@user)
      redirect_to dashboard_users_path
    else
      redirect_to root_path
      flash[:error] = 'Invalid Credentials'
    end
  end

  def show 
    @satellites = SatelliteFacade.get_user_satellites(session[:user_id])
    @visible_times = @satellites.map do |satellite|
      SatelliteFacade.get_satellite_visibility(satellite.id, @lat, @long)
    end.flatten  
    @visible_times.compact!
    @message_count = @satellites.map do |satellite|
      SatelliteFacade.get_sat_message_id(satellite.id)
    end.flatten
    @weather_forecasts = WeatherFacade.get_weather_forecast(@lat, @long)
  end

  private

  def set_session(user)
    session[:user_id] = user.id
  end
end