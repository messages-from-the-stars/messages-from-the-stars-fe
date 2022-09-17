class WeatherFacade

    def self.get_weather_forecast(lat, long)
        json = WeatherService.get_weather_forecast(lat, long)[:daily]
         
        json.map do |weather_data|
            WeatherForecasts.new(weather_data)
        end 
    end 

end