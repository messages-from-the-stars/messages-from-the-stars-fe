class SatelliteFacade

    def self.get_user_satellites(user_id)
        json = SatelliteService.get_user_satellites(user_id)[:data]
        json.map do |satellite_data|
            Satellite.new(satellite_data)
        end 
    end 

    # def self.discover_satellites(user_id)
    #     json = SatelliteService.get_satellites_in_range(user_id)[:data]
    #     json.map do |satellite_data|
    #         Satellite.new(satellite_data)
    #     end 
    # end 

end 