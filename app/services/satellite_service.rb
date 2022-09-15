class SatelliteService

    def self.get_user_satellites(user_id)
        response = BaseService.connection.get("/api/v1/users/#{user_id}/satellites")
        BaseService.get_json(response)
    end

end 