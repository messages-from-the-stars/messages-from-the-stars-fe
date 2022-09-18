require 'rails_helper'

RSpec.describe 'Satellite Show Page' do
  context '#happypath' do
    before(:each) do
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
      {"provider" => "google_oauth2",
          "uid" => "10000000000000000",
          "info" => {
          "name" => "John Smith",
          "email" => "john@example.com",
          "first_name" => "John",
          "last_name" => "Smith",
          },
          "credentials" => {
          "token" => "Token",
          },
      })
      
      @satellites = JSON.parse(File.read('spec/fixtures/satellites.json'), symbolize_names: true)
      @visible_sat_times = JSON.parse(File.read('spec/fixtures/satellite_visibility.json'), symbolize_names: true)
      @weather_data = JSON.parse(File.read('spec/fixtures/weather_data.json'), symbolize_names: true)
      
      allow(SatelliteService).to receive(:get_user_satellites).and_return(@satellites)
      allow(SatelliteService).to receive(:get_satellite_visibility).and_return(@visible_sat_times)
      allow(WeatherService).to receive(:get_weather_forecast).and_return(@weather_data)

      @found_satellites = JSON.parse(File.read('spec/fixtures/above_satellites.json'), symbolize_names: true)

      allow(SatelliteService).to receive(:get_satellites_in_range).and_return(@found_satellites)

      @sat_call = JSON.parse(File.read('spec/fixtures/satellite.json'), symbolize_names: true)
      @sat_id = @sat_call[:info][:satid]
      allow(SatelliteService).to receive(:get_satellite).and_return(@sat_call)

      visit '/auth/google_oauth2'
    end 
    
    it 'shows a satellites information' do
      visit "api/v1/satellites/#{@sat_id}"
      
      expect(page).to have_content("NORAD ID: 25544")
      expect(page).to have_content('Satellite Name: SPACE STATION')
      expect(page).to have_content('Current Latitude / Longitude')
      expect(page).to have_content("Visibility in the next 7 days")

      within "visibility1" do
        expect(page).to have_content("Date: Sep 16, at 5:41 PM")
        expect(page).to have_content("Weather Forecast: Clear")
      end
    end


  end
end