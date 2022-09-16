class SatelliteService

    def self.get_user_satellites(user_id)
        response = BaseService.connection.get("/api/v1/users/#{user_id}/satellites")
        BaseService.get_json(response)
    end

    def self.get_satellites_in_range(lat_long)
        response = BaseService.n2yo_connection.get("/rest/v1/satellite/above/#{lat_long[0]}/#{lat_long[1]}/0/15/0/")
        JSON.parse(response.body, symbolize_names: true)
    end

end 