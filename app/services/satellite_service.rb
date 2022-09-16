class SatelliteService

    def self.get_user_satellites(user_id)
        response = BaseService.connection.get("/api/v1/users/#{user_id}/satellites")
        BaseService.get_json(response)
    end

    def self.get_satellite(sat_id)
      response = BaseService.n2yo_conn.get("tle/#{sat_id}")
      BaseService.get_json(response)
    end

end 