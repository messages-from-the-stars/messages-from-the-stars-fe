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
    
    @user = JSON.parse(File.read('spec/fixtures/user.json'), symbolize_names: true)
    @satellites = JSON.parse(File.read('spec/fixtures/satellites.json'), symbolize_names: true)
    @visible_sat_times = JSON.parse(File.read('spec/fixtures/satellite_visibility.json'), symbolize_names: true)
    @weather_data = JSON.parse(File.read('spec/fixtures/weather_data.json'), symbolize_names: true)
    @found_satellites = JSON.parse(File.read('spec/fixtures/above_satellites.json'), symbolize_names: true)
    @found_messages = JSON.parse(File.read('spec/fixtures/message.json'), symbolize_names: true)

    allow(SatelliteService).to receive(:get_satellites_in_range).and_return(@found_satellites)
    allow(SatelliteService).to receive(:get_satellite_visibility).and_return(@visible_sat_times)
    allow(WeatherService).to receive(:get_weather_forecast).and_return(@weather_data)
    allow(SatelliteService).to receive(:get_user_satellites).and_return(@satellites)
    allow(UserService).to receive(:find_or_create_user).and_return(@user)
    allow(SatelliteService).to receive(:get_sat_message).and_return(@found_messages)

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
        expect(page).to have_content("Launched on: 1966-10-02")
      end

      within '#satellites1' do
        expect(page).to have_content("Name: DELTA 1 DEB ID: 2700")
        expect(page).to have_content("Launched on: 1965-11-06")
      end
    end
  end

  describe '#link_satellite_show' do
    it 'Below the satellite Name and ID is a link to the satellite show page' do
      satellite = DiscoverSatellite.new(satid: 2700, satname: 'DELTA 1 DEB', launch_date: '1965-11-06')

      visit discover_users_path

      within '#satellites1' do

        expect(page).to have_content("Name: DELTA 1 DEB ID: 2700")
        expect(page).to have_link("View Satellite Info")

        click_link('View Satellite Info')
      end

      expect(current_path).to eq(api_v1_satellite_path(satellite.satid))
      expect(page).to have_content("DELTA 1 DEB's Show")
    end
  end

   describe '#get_sat_message' do
    it 'return number of messages attached to a returned satellite' do
      visit discover_users_path

      expect(page).to have_content("Name: THORAD DELTA 1 DEB ID: 13002")
      expect(page).to have_content("Messages")

    end
  end
end