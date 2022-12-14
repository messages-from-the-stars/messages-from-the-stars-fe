require 'rails_helper'

RSpec.describe 'Satellite Show Page' do
  context '#happypath' do
    before(:each) do
      Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]

      @user = JSON.parse(File.read('spec/fixtures/user.json'), symbolize_names: true)
      @found_satellites = JSON.parse(File.read('spec/fixtures/above_satellites.json'), symbolize_names: true)
      @satellites = JSON.parse(File.read('spec/fixtures/satellites.json'), symbolize_names: true)
      @visible_sat_times = JSON.parse(File.read('spec/fixtures/satellite_visibility.json'), symbolize_names: true)
      @weather_data = JSON.parse(File.read('spec/fixtures/weather_data.json'), symbolize_names: true)
      @position = JSON.parse(File.read('spec/fixtures/sat_position_response.json'), symbolize_names: true)
      @sat_id = 25544
      @sat_db_call = JSON.parse(File.read('spec/fixtures/sat_db_response.json'), symbolize_names: true)
      @message = JSON.parse(File.read('spec/fixtures/message.json'), symbolize_names: true)
      @messages = JSON.parse(File.read('spec/fixtures/messages.json'), symbolize_names: true)
      @lat = 39.75
      @long = -104.99
      
      allow(SatelliteService).to receive(:get_satellites_in_range).and_return(@found_satellites)
      allow(SatelliteService).to receive(:get_user_satellites).and_return(@satellites)
      allow(SatelliteService).to receive(:get_satellite_visibility).and_return(@visible_sat_times)
      allow(WeatherService).to receive(:get_weather_forecast).and_return(@weather_data)
      allow(SatelliteService).to receive(:get_satellite_position).and_return(@position)
      allow(SatelliteService).to receive(:get_sat_message).and_return(@messages)
      allow(UserService).to receive(:find_or_create_user).and_return(@user)
      allow_any_instance_of(ApplicationController).to receive(:remote_ip).and_return(@lat, @long)
      allow(SatelliteService).to receive(:create_satellite).and_return(200)
      allow(MessageService).to receive(:get_message).and_return(@message)
      allow(SatelliteService).to receive(:get_norad_id).and_return(@sat_db_call)

      visit '/auth/google_oauth2'
    end 
    
    it 'shows a satellites information' do
      visit "/satellite"

      expect(page).to have_content("NORAD ID 25544")
      expect(page).to have_content('SPACE STATION')
      expect(page).to have_content("Latitude: -6.24147627")
      expect(page).to have_content("Longitude: 91.26942017")
      expect(page).to have_content("Visibility in the next 10 days")

      within "#visibility0" do
        expect(page).to have_content("Sep 16, at 5:41 PM")
        expect(page).to have_content("Weather Forecast: Clear")
      end
      within "#visibility1" do
        expect(page).to have_content("Sep 16, at 7:23 PM")
        expect(page).to have_content("Weather Forecast: Clear")
      end
      within "#visibility2" do
        expect(page).to have_content("Sep 17, at 6:47 PM")
        expect(page).to have_content("Weather Forecast: Clouds")
      end
      within "#visibility3" do
        expect(page).to have_content("Sep 17, at 8:30 PM")
        expect(page).to have_content("Weather Forecast: Clouds")
      end
    end

    it 'can show a satellites messages' do
      visit "/satellite"
  
      expect(page).to have_content("13 Total Messages")

      within "#messages0" do
        expect(page).to have_content("Message 1")
      end
      within "#messages4" do
        expect(page).to have_content("Message 5")
      end
    end

    it 'can link to the send a message page' do
      visit "/satellite"

      click_on "Cast a New Message"

      expect(current_path).to eq("/messages/new")
      expect(page).to have_content("Cast a New Message")
      expect(page).to have_button("Send Message")
      expect(page).to have_field(:message)
    end

    it 'can link to a specific message show page' do
      visit "/satellite"

      within "#messages0" do
        click_on "1"
        expect(current_path).to eq("/messages/1")
      end
    end

    it 'has an image thats a map of its current location' do
      visit "/satellite"

      expect(page).to have_content("Current Location")
      expect(page).to have_css("img")
    end
  end

  context '#sadpath' do
    it 'redirects a non-logged in user to the landing page' do
      visit "/satellite"
        
      expect(current_path).to eq("/")
    end
  end
  
  context '#sadpath' do
    before(:each) do
      Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]

      @user = JSON.parse(File.read('spec/fixtures/user.json'), symbolize_names: true)
      @found_satellites = JSON.parse(File.read('spec/fixtures/above_satellites.json'), symbolize_names: true)
      @satellites = JSON.parse(File.read('spec/fixtures/satellites.json'), symbolize_names: true)
      @visible_sat_times = JSON.parse(File.read('spec/fixtures/satellite_visibility.json'), symbolize_names: true)
      @weather_data = JSON.parse(File.read('spec/fixtures/weather_data.json'), symbolize_names: true)
      @position = JSON.parse(File.read('spec/fixtures/sat_position_response.json'), symbolize_names: true)
      @position_bad = JSON.parse(File.read('spec/fixtures/sat_position_response_bad.json'), symbolize_names: true)
      @sat_id = 999999999
      @sat_db_call = JSON.parse(File.read('spec/fixtures/sat_db_response.json'), symbolize_names: true)
      @message = JSON.parse(File.read('spec/fixtures/message.json'), symbolize_names: true)
      @messages = JSON.parse(File.read('spec/fixtures/messages.json'), symbolize_names: true)
      @lat = 39.75
      @long = -104.99
      
      allow(SatelliteService).to receive(:get_satellites_in_range).and_return(@found_satellites)
      allow(SatelliteService).to receive(:get_user_satellites).and_return(@satellites)
      allow(SatelliteService).to receive(:get_satellite_visibility).and_return(@visible_sat_times)
      allow(WeatherService).to receive(:get_weather_forecast).and_return(@weather_data)
      allow(SatelliteService).to receive(:get_satellite_position).and_return(@position_bad)
      allow(SatelliteService).to receive(:get_sat_message).and_return(@messages)
      allow(UserService).to receive(:find_or_create_user).and_return(@user)
      allow_any_instance_of(ApplicationController).to receive(:remote_ip).and_return(@lat, @long)
      allow(SatelliteService).to receive(:create_satellite).and_return(@position)
      allow(MessageService).to receive(:get_message).and_return(@message)
      allow(SatelliteService).to receive(:get_norad_id).and_return(@sat_db_call)

      visit '/auth/google_oauth2'
    end 
    
    it 'shows an error if your satellite has no info' do
      visit "/satellite"

      expect(page).to have_content("Oh no! Your satellite is lost is space. Try to find a different one.")
    end
  end 
end