require 'rails_helper'

RSpec.describe 'message new page' do
    before :each do
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

      @messages = JSON.parse(File.read('spec/fixtures/messages.json'), symbolize_names: true)
      allow(SatelliteService).to receive(:get_sat_message).and_return(@messages)

      @message = JSON.parse(File.read('spec/fixtures/message.json'), symbolize_names: true)
      allow(MessageService).to receive(:create_message).and_return(@message)

      @lat = 39.75
      @long = -104.99
      allow_any_instance_of(ApplicationController).to receive(:remote_ip).and_return(@lat, @long)

      visit '/auth/google_oauth2'
    end 

    it 'has a form to create a new message' do
        satellite = DiscoverSatellite.new(satid: 2700, satname: 'DELTA 1 DEB', launch_date: '1965-11-06')

        visit discover_users_path

        click_button("View DELTA 1 DEB's Info")
        
        click_on "Add New Message to SPACE STATION"

        expect(current_path).to eq("/messages/new")

        fill_in("message", with: "Hello there, this is a test")
        click_button('Send Message')

        expect(current_path).to eq('/users/dashboard')
        expect(page).to have_content("Message sent!")
    end

    it 'will not let you send a blank message' do
        visit "/messages/new" 

        click_button('Send Message')

        expect(page).to have_content("Your message can't be blank!")
        expect(current_path).to eq("/messages/new")
    end

end
