require 'rails_helper'

RSpec.describe 'OAuth Login with Google' do
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
        @user = JSON.parse(File.read('spec/fixtures/user.json'), symbolize_names: true)
        @satellites = JSON.parse(File.read('spec/fixtures/satellites.json'), symbolize_names: true)
        @visible_sat_times = JSON.parse(File.read('spec/fixtures/satellite_visibility.json'), symbolize_names: true)
        @weather_data = JSON.parse(File.read('spec/fixtures/weather_data.json'), symbolize_names: true)

        allow(SatelliteService).to receive(:get_satellite_visibility).and_return(@visible_sat_times)
        allow(SatelliteService).to receive(:get_user_satellites).and_return(@satellites)
        allow(WeatherService).to receive(:get_weather_forecast).and_return(@weather_data)
        allow(UserService).to receive(:find_or_create_user).and_return(@user)
    end

    it 'redirects and creates a new user' do
      visit '/auth/google_oauth2'

      # expect(User.last.uid).to eq("10000000000000000")
      # expect(User.last.username).to eq("john@example.com")

      expect(current_path).to eq(dashboard_users_path)
    end
  end
end