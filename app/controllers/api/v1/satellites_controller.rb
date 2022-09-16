class Api::V1::SatellitesController < ApplicationController
  def show
    @satellite = SatelliteFacade.get_satellite(params[:id])
  end
end