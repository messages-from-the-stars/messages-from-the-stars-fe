require "rails_helper"

RSpec.describe WeatherForecasts do
    it "exists" do
        data = {
            "dt": 1663437600,
            "sunrise": 1663416059,
            "sunset": 1663460428,
            "moonrise": 0,
            "moonset": 1663442220,
            "moon_phase": 0.75,
            "temp": {
                "day": 301.16,
                "min": 292.93,
                "max": 303.19,
                "night": 298.34,
                "eve": 300.31,
                "morn": 294.1
            },
            "feels_like": {
                "day": 302.96,
                "night": 298.69,
                "eve": 301.68,
                "morn": 294.37
            },
            "pressure": 1018,
            "humidity": 63,
            "dew_point": 293.46,
            "wind_speed": 3.29,
            "wind_deg": 139,
            "wind_gust": 9.88,
            "weather": [
                {
                    "id": 802,
                    "main": "Clouds",
                    "description": "scattered clouds",
                    "icon": "03d"
                }
            ],
            "clouds": 45,
            "pop": 0.15,
            "uvi": 7.7
        }

        weather = WeatherForecasts.new(data)

        expect(weather).to be_a WeatherForecasts
        expect(weather.status).to eq("Clouds")
        expect(weather.date).to eq("Sep 17")
    end 
end 