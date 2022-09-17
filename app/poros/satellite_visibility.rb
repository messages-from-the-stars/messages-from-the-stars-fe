class SatelliteVisibility
    attr_reader :starting_time, :sat_id 

    def initialize(data, sat_id)
        @sat_id = sat_id 
        @starting_time = Time.at(data[:startUTC]).strftime("%b %e, at %l:%M %p")
    end 

end 