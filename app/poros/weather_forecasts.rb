class WeatherForecasts
    attr_reader :status, :date

    def initialize(data)
        @status = data[:weather][0][:main]
        @date = Time.at(data[:dt]).strftime("%b %e")
    end 

end 