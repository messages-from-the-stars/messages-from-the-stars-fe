require 'rails_helper'

RSpec.describe WeatherService do
  context '#get_weather_forecast' do
    it 'returns the daily weather forecast for an area', :vcr do
      response = WeatherService.get_weather_forecast(33.44, -94.04)

      expect(response).to be_a Hash

      expect(response[:daily]).to be_an Array
      
      expect(response[:daily].first[:weather][0][:main]).to be_a String 

      expect(response[:daily].first[:dt]).to be_a Integer
    end
  end
end