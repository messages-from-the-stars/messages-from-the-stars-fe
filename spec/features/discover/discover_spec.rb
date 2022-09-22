require 'rails_helper'

RSpec.describe 'Discover page' do
  context '#happypath' do
    before(:each) do
      Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]

      @user = JSON.parse(File.read('spec/fixtures/user.json'), symbolize_names: true)
      @satellites = JSON.parse(File.read('spec/fixtures/satellites.json'), symbolize_names: true)
      @visible_sat_times = JSON.parse(File.read('spec/fixtures/satellite_visibility.json'), symbolize_names: true)
      @weather_data = JSON.parse(File.read('spec/fixtures/weather_data.json'), symbolize_names: true)
      @found_satellites = JSON.parse(File.read('spec/fixtures/above_satellites.json'), symbolize_names: true)
      @found_messages = JSON.parse(File.read('spec/fixtures/messages.json'), symbolize_names: true)
      @position = JSON.parse(File.read('spec/fixtures/sat_position_response.json'), symbolize_names: true)
      @message_array = JSON.parse(File.read('spec/fixtures/message_array.json'), symbolize_names: true)
      @sat_id = 25544
      @lat = 39.75
      @long = -104.99
      
      allow(SatelliteService).to receive(:get_satellite_position).and_return(@position)
      allow(SatelliteService).to receive(:get_satellites_in_range).and_return(@found_satellites)
      allow(SatelliteService).to receive(:get_satellite_visibility).and_return(@visible_sat_times)
      allow(WeatherService).to receive(:get_weather_forecast).and_return(@weather_data)
      allow(SatelliteService).to receive(:get_user_satellites).and_return(@satellites)
      allow(UserService).to receive(:find_or_create_user).and_return(@user)
      allow(SatelliteService).to receive(:get_sat_message).and_return(@found_messages)
      allow(MessageService).to receive(:get_message_count).and_return(@message_array)
      allow_any_instance_of(ApplicationController).to receive(:remote_ip).and_return(@lat, @long)
      allow(SatelliteService).to receive(:create_satellite).and_return(200)

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
          expect(page).to have_content("3 Messages")
        end

        within '#satellites1' do
          expect(page).to have_content("Name: DELTA 1 DEB ID: 2700")
          expect(page).to have_content("Launched on: 1965-11-06")
          expect(page).to have_content("0 Messages")
        end
      end
    end

    describe '#link_satellite_show' do
      it 'Below the satellite Name and ID is a link to the satellite show page' do
        satellite = DiscoverSatellite.new(satid: 2700, satname: 'DELTA 1 DEB', launch_date: '1965-11-06')

        visit discover_users_path
      
        within '#satellites1' do

          expect(page).to have_content("Name: DELTA 1 DEB ID: 2700")
          expect(page).to have_button("View DELTA 1 DEB's Info")

          click_button("View DELTA 1 DEB's Info")
        end
       
        expect(current_path).to eq('/satellite')
        expect(page).to have_content("NORAD ID 25544")
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

  context '#sadpath' do
    it 'redirects a non-logged in user to the landing page' do
      visit '/users/dashboard'
      
      expect(current_path).to eq("/")
    end
  end 
end