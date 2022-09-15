class SatelliteFacade

    def self.get_user_satellites(user_id)
        json = SatelliteService.get_user_satellites(user_id)[:data]
        json.map do |satellite_data|
            Satellite.new(satellite_data)
        end 
    end 

end 