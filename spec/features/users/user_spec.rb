require 'rails_helper'

RSpec.describe 'OAuth Login with Google' do
  context '#happypath' do
    before(:each) do
        Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
            
        @found_satellites = JSON.parse(File.read('spec/fixtures/above_satellites.json'), symbolize_names: true)
        @user = JSON.parse(File.read('spec/fixtures/user.json'), symbolize_names: true)
        @satellites = JSON.parse(File.read('spec/fixtures/satellites.json'), symbolize_names: true)
        @visible_sat_times = JSON.parse(File.read('spec/fixtures/satellite_visibility.json'), symbolize_names: true)
        @weather_data = JSON.parse(File.read('spec/fixtures/weather_data.json'), symbolize_names: true)
        @messages = JSON.parse(File.read('spec/fixtures/messages.json'), symbolize_names: true)
        @lat = 39.75
        @long = -104.99
        
        allow(SatelliteService).to receive(:get_user_satellites).and_return(@satellites)
        allow(SatelliteService).to receive(:get_satellite_visibility).and_return(@visible_sat_times)
        allow(WeatherService).to receive(:get_weather_forecast).and_return(@weather_data)
        allow(UserService).to receive(:find_or_create_user).and_return(@user)
        allow(SatelliteService).to receive(:get_satellites_in_range).and_return(@found_satellites)
        allow(SatelliteService).to receive(:get_sat_message).and_return(@messages)
        allow_any_instance_of(ApplicationController).to receive(:remote_ip).and_return(@lat, @long)

        visit '/auth/google_oauth2'
    end

    it 'redirects and creates a new user' do
      visit '/auth/google_oauth2'

      expect(current_path).to eq(dashboard_users_path)
    end
  end
end