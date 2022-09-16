class SatelliteService

    def self.get_user_satellites(user_id)
        response = BaseService.connection.get("/api/v1/users/#{user_id}/satellites")
        BaseService.get_json(response)
    end

    def self.get_satellites_in_range(user_id) #Work in progress#
        ip = request.remote_ip
        location = Geocoder.search(ip)
        lat_long = location.first.coordinates
        "https://api.n2yo.com/rest/v1/satellite/above/#{lat_long[0]}/#{lat_long[1]}/0/15/0/&apiKey=K7K7BG-KXR3U4-D6VBTT-4XC8"
        response = BaseService.connection.get("/api/v1/users/#{user_id}/discover")
        BaseService.get_json(response)
    end

end 