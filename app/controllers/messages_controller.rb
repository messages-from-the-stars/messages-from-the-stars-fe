class MessagesController < ApplicationController
  before_action :remote_ip

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
      MessageFacade.create_message(@lat, @long, params[:message], params[:sat_id])
      redirect_to '/users/dashboard'
      flash[:success] = "Message sent!"    
    else 
      redirect_to '/messages/new'
      flash[:error] = "Your message can't be blank!"
    end 
  end 

end