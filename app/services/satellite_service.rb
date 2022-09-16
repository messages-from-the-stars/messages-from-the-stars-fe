class SatelliteService

    def self.get_user_satellites(user_id)
        response = BaseService.connection.get("/api/v1/users/#{user_id}/satellites")
        BaseService.get_json(response)
    end

    def self.get_satellite(sat_id)
      response = BaseService.n2yo_conn.get("tle/#{sat_id}")
      BaseService.get_json(response)
    end 

    def self.get_satellites_in_range(lat_long)
        response = BaseService.n2yo_connection.get("/rest/v1/satellite/above/#{lat_long[0]}/#{lat_long[1]}/0/15/0/")
        JSON.parse(response.body, symbolize_names: true)
    end

    def self.get_satellite_visibility(id, lat, long)
        response = BaseService.n2yo_connection.get("/rest/v1/satellite/visualpasses//#{id}/#{lat}/#{long}/0/10/300/&apiKey=J5ZTGL-KKTATM-TUCKZ5-4XEF")
        JSON.parse(response.body, symbolize_names: true)
    end

end 