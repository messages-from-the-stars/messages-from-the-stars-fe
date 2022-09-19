require 'rails_helper'

RSpec.describe 'landing page' do
  describe '#index' do
    it 'displays the title of the application and description body' do

      visit root_path

      expect(page).to have_content("Messages from the Stars")
      expect(page).to have_content("Catch a satellite")
      expect(page).to have_content("Create a message")
      expect(page).to have_content("Cast your message into the cosmic ocean")
      expect(page).to have_content("Log In")
    end
  end

  describe '#happy path' do
    it 'has button to log in user, click button to authorize log in via Google' do
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
      
      @user = JSON.parse(File.read('spec/fixtures/user.json'), symbolize_names: true)
      @satellites = JSON.parse(File.read('spec/fixtures/satellites.json'), symbolize_names: true)
      @visible_sat_times = JSON.parse(File.read('spec/fixtures/satellite_visibility.json'), symbolize_names: true)
      @weather_data = JSON.parse(File.read('spec/fixtures/weather_data.json'), symbolize_names: true)
      @lat = 39.75
      @long = -104.99

      allow(SatelliteService).to receive(:get_user_satellites).and_return(@satellites)
      allow(SatelliteService).to receive(:get_satellite_visibility).and_return(@visible_sat_times)
      allow(WeatherService).to receive(:get_weather_forecast).and_return(@weather_data)
      allow(UserService).to receive(:find_or_create_user).and_return(@user)
      allow_any_instance_of(ApplicationController).to receive(:remote_ip).and_return(@lat, @long)

      visit root_path

      expect(page).to have_link('Log In')

      click_link('Log In')

      expect(current_path).to eq(dashboard_users_path)
    end
  end

  describe '#sad_path' do
    it 'Displays Invalid credentials if log in fails' do
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:google_oauth2] =     OmniAuth::AuthHash.new(
        {"provider" => "google_oauth2",
          "uid" => "10000000000000000",
          "info" => {
            "name" => "John Smith",
            "email" => "john@example.com",
            "first_name" => "John",
            "last_name" => "Smith",
          },
          "credentials" => {
            "token" => "",
          },
        })
      @lat = 39.75
      @long = -104.99
      
      allow_any_instance_of(ApplicationController).to receive(:remote_ip).and_return(@lat, @long)

      visit root_path

      click_link('Log In')

      expect(current_path).to eq(root_path)
      expect(page).to have_content('Invalid Credentials')
    end
  end
end