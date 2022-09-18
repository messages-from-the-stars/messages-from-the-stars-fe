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

    def self.get_satellite_position(norad_id)
        json = SatelliteService.get_satellite_position(norad_id)
        SatellitePosition.new(json)
    end

  
    def self.above_satellites(lat, long)
        json = SatelliteService.get_satellites_in_range(lat, long)[:above]
        json[0..9].map do |data|
            DiscoverSatellite.new(data)
        end
    end

    def self.get_satellite_visibility(sat_id, lat, long)
        json = SatelliteService.get_satellite_visibility(sat_id, lat, long)[:passes]
        if json != nil 
            json.map do |visibility_data|
                SatelliteVisibility.new(visibility_data, sat_id)
            end
        end  
    end
    
    def self.get_norad_id(sat_db_id)
        json = SatelliteService.get_norad_id(sat_db_id)
    end

end 