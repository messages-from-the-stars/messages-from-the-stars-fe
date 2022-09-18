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
      @position = JSON.parse(File.read('spec/fixtures/sat_position_response.json'), symbolize_names: true)
      
      allow(SatelliteService).to receive(:get_user_satellites).and_return(@satellites)
      allow(SatelliteService).to receive(:get_satellite_visibility).and_return(@visible_sat_times)
      allow(WeatherService).to receive(:get_weather_forecast).and_return(@weather_data)
      
      @found_satellites = JSON.parse(File.read('spec/fixtures/above_satellites.json'), symbolize_names: true)
      
      allow(SatelliteService).to receive(:get_satellites_in_range).and_return(@found_satellites)
      allow(SatelliteService).to receive(:get_satellite_position).and_return(@position)

      @sat_call = JSON.parse(File.read('spec/fixtures/satellite.json'), symbolize_names: true)
      @sat_id = @sat_call[:info][:satid]
      allow(SatelliteService).to receive(:get_satellite).and_return(@sat_call)

      @messages = JSON.parse(File.read('spec/fixtures/message.json'), symbolize_names: true)
      allow(SatelliteService).to receive(:get_sat_message).and_return(@messages)

      visit '/auth/google_oauth2'
    end 
    
    it 'shows a satellites information' do
      visit "api/v1/satellites/#{@sat_id}"
      
      expect(page).to have_content("NORAD ID: 25544")
      expect(page).to have_content('Satellite Name: SPACE STATION')
      expect(page).to have_content("Current Latitude / Longitude: -6.24147627, 91.26942017")
      expect(page).to have_content("Visibility in the next 7 days")

      within "#visibility0" do
        expect(page).to have_content("Date: Sep 16, at 5:41 PM")
        expect(page).to have_content("Weather Forecast: Clear")
      end
      within "#visibility1" do
        expect(page).to have_content("Date: Sep 16, at 7:23 PM")
        expect(page).to have_content("Weather Forecast: Clear")
      end
      within "#visibility2" do
        expect(page).to have_content("Date: Sep 17, at 6:47 PM")
        expect(page).to have_content("Weather Forecast: Clouds")
      end
      within "#visibility3" do
        expect(page).to have_content("Date: Sep 17, at 8:30 PM")
        expect(page).to have_content("Weather Forecast: Clouds")
      end
    end

    it 'can show a satellites messages' do
      visit "api/v1/satellites/#{@sat_id}"

      expect(page).to have_content("13 Total Messages")

      within "#messages0" do
        expect(page).to have_content("What a piece of work is man! How noble in reason, how infinite in faculty!")
      end

      within "#messages4" do
        expect(page).to have_content("Neither a borrower nor a lender be; For loan oft loses both itself and friend")
      end
    end

    it 'has a button to add satellite to users tracking' do
      visit "api/v1/satellites/#{@sat_id}"

      click_on "Add SPACE STATION to Tracking"

      expect(page).to have_content("?")
    end
  end
end