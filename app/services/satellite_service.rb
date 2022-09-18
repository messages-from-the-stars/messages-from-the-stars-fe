class SatelliteService

    def self.get_user_satellites(user_id)
        response = BaseService.connection.get("/api/v1/users/#{user_id}/satellites")
        BaseService.get_json(response)
    end

    def self.get_norad_id(sat_db_id)
        response = BaseService.connection.get("api/v1/satellites/#{sat_db_id}")
        BaseService.get_json(response)
    end

    def self.get_sat_message(satellite_id)
        response = BaseService.connection.get("/api/v1/messages/find_by_sat_id?sat_id=#{satellite_id}")
        BaseService.get_json(response)
    end

    def self.get_satellite(sat_id)
        response = BaseService.n2yo_conn.get("tle/#{sat_id}")
        BaseService.get_json(response)
    end

    def self.create_user_satellite(sat_id, user_id)
      response = BaseService.connection.post("/api/v1/user_satellite/create_user_satellite")
      # still in progress
    end

    def self.get_satellite_position(norad_id)
        response = BaseService.n2yo_conn.get("positions/#{norad_id}/39.739/104.990/0/1")
        BaseService.get_json(response)
    end

    def self.get_satellites_in_range(lat, long)
        response = BaseService.n2yo_connection.get("/rest/v1/satellite/above/#{lat}/#{long}/0/15/0/")
        JSON.parse(response.body, symbolize_names: true)
    end

    def self.get_satellite_visibility(id, lat, long)
        response = BaseService.n2yo_connection.get("/rest/v1/satellite/visualpasses//#{id}/#{lat}/#{long}/0/7/300/&apiKey=#{ENV['n2yo_Key']}")
        JSON.parse(response.body, symbolize_names: true)
    end
end 