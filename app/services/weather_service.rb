class WeatherService

    def self.get_weather_forecast(lat, long)
        response = BaseService.open_weather_conn.get("/data/3.0/onecall?lat=#{lat}&lon=#{lon}&exclude=minutely,hourly&appid=d8bdaa10238469f854cde11042e2caf5s")
        JSON.parse(response.body, symbolize_names: true)
    end

end 