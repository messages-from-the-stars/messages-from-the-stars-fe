class MessagesController < ApplicationController

  def show
    @message = MessageFacade.get_message(params[:id])

    sat_norad_id = SatelliteFacade.get_norad_id(@message.satellite_id)[:data][:attributes][:norad_id]

    @satellite = SatelliteFacade.get_satellite_position(sat_norad_id)
  end

end