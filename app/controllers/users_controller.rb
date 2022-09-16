class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show]

  def create
    user_info = request.env['omniauth.auth']
    if user_info['credentials']['token'].present?
      @user = User.find_or_create_by(uid: user_info['uid'])
      update_user(user_info)
      set_session(@user)
      redirect_to dashboard_users_path
    else
      redirect_to root_path
      flash[:error] = 'Invalid Credentials'
    end
  end

  def show
    @user = User.find(session[:user_id])
    @satellites = SatelliteFacade.get_user_satellites(session[:user_id])
    @visible_times = @satellites.map do |satellite|
      SatelliteFacade.get_satellite_visibility(satellite.id, @lat, @long)
    end.flatten  
  end

  private

  def set_session(user)
    session[:user_id] = user.id
  end

  def update_user(user_info)
    @user.username = user_info[:info]['email']
    @user.uid = user_info['uid']
    @user.token = user_info['credentials']['token']
    @user.save
  end
end