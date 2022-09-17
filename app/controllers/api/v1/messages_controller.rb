class Api::V1::MessagesController < ApplicationController

  def show
    @message = MessageFacade.get_message(params[:id])
  end

end