class MessagesController < ApplicationController
  before_action :logged_in_user, :remote_ip

  def show
    @message = MessageFacade.get_message(params[:id])
    sat_norad_id = SatelliteFacade.get_norad_id(@message.satellite_id)[:data][:attributes][:norad_id]
    @satellite = SatelliteFacade.get_satellite_position(sat_norad_id)
    @map_url = MapMaker.new(@lat,@long,@satellite.sat_lat,@satellite.sat_lng,@message.start_lat,@message.start_lng).result_url
  end

  def new 
    @sat_id = params[:sat_id]
  end 

  def create 
    if params[:message] != ""
      SatelliteFacade.create_user_satellite(params[:sat_id], session[:user_id])

      MessageFacade.create_message(@lat, @long, params[:message], params[:sat_id])
      redirect_to '/users/dashboard'
      flash[:success] = "Message sent!"    
    else 
      redirect_to '/messages/new'
      flash[:error] = "Your message can't be blank!"
    end 
  end 

end