require 'rails_helper'

RSpec.describe 'Discover page' do
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
    
    remote_ip = '161.185.160.93'
          
    @satellites = JSON.parse(File.read('spec/fixtures/satellites.json'), symbolize_names: true)
    @visible_sat_times = JSON.parse(File.read('spec/fixtures/satellite_visibility.json'), symbolize_names: true)
     
    allow(SatelliteService).to receive(:get_user_satellites).and_return(@satellites)
    allow(SatelliteService).to receive(:get_satellite_visibility).and_return(@visible_sat_times)

    visit '/auth/google_oauth2'
  end

  describe '#get_satellites_in_range' do
    it 'should display title Discover Satellites' do

      visit discover_users_path

      expect(page).to have_content("Discover Satellites")
    end
  end
end