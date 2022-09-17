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

    lat_long = [39.6431, -104.8987]
          
    @satellites = JSON.parse(File.read('spec/fixtures/satellites.json'), symbolize_names: true)
            
    allow(SatelliteService).to receive(:get_user_satellites).and_return(@satellites)

    @found_satellites = JSON.parse(File.read('spec/fixtures/above_satellites.json'), symbolize_names: true)

    allow(SatelliteService).to receive(:get_satellites_in_range).and_return(@found_satellites)

    visit '/auth/google_oauth2'
  end

  describe '#get_satellites_in_range' do
    it 'should display title Discover Satellites' do

      visit discover_users_path

      expect(page).to have_content("Satellites Above You")
    end

    it 'should display max ten satellites in range of user' do

      visit discover_users_path

      within '#satellites0' do
        expect(page).to have_content("Name: ESSA 3 (TOS-A) ID: 2435")
      end

      within '#satellites1' do
        expect(page).to have_content("Name: DELTA 1 DEB ID: 2700")
      end
    end
  end
end