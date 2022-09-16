class SatelliteFacade

    def self.get_user_satellites(user_id)
        json = SatelliteService.get_user_satellites(user_id)[:data]
        json.map do |satellite_data|
            Satellite.new(satellite_data)
        end 
    end 

    def self.get_satellite(sat_id)
      json = SatelliteService.get_satellite(sat_id)[:info]
      SatelliteAPI.new(json)
    end

end 