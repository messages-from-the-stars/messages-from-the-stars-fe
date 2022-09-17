class WeatherService

    def self.get_weather_forecast(lat, long)
        response = BaseService.open_weather_conn.get("/data/3.0/onecall?lat=#{lat}&lon=#{long}&exclude=minutely,hourly&appid=#{ENV['open_key']}")
        JSON.parse(response.body, symbolize_names: true)
    end

end 