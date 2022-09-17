require 'rails_helper'

RSpec.describe 'WeatherFacade' do
    it 'returns the daily weather for a give area', :vcr do
        weather =  WeatherFacade.get_weather_forecast(33.44, -94.04)

        expect(weather).to be_a(Array)
        expect(weather).to be_all(WeatherForecasts)
    end
end 