require 'rails_helper'

RSpec.describe 'message new page' do
    before :each do
      Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]

      @user = JSON.parse(File.read('spec/fixtures/user.json'), symbolize_names: true)
      @satellites = JSON.parse(File.read('spec/fixtures/satellites.json'), symbolize_names: true)
      @visible_sat_times = JSON.parse(File.read('spec/fixtures/satellite_visibility.json'), symbolize_names: true)
      @weather_data = JSON.parse(File.read('spec/fixtures/weather_data.json'), symbolize_names: true)
      @found_satellites = JSON.parse(File.read('spec/fixtures/above_satellites.json'), symbolize_names: true)
      @found_messages = JSON.parse(File.read('spec/fixtures/messages.json'), symbolize_names: true)
      @position = JSON.parse(File.read('spec/fixtures/sat_position_response.json'), symbolize_names: true)
      @message_array = JSON.parse(File.read('spec/fixtures/message_array.json'), symbolize_names: true)
      @message = JSON.parse(File.read('spec/fixtures/message.json'), symbolize_names: true)
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
      allow(SatelliteService).to receive(:create_user_satellite).and_return(@sat_call)
      allow(MessageService).to receive(:create_message).and_return(@message)

      visit '/auth/google_oauth2'
    end 

    it 'has a form to create a new message' do
        satellite = DiscoverSatellite.new(satid: 2700, satname: 'DELTA 1 DEB', launch_date: '1965-11-06')

        visit discover_users_path

        click_button("View DELTA 1 DEB's Info")
        
        click_on "Cast a New Message"

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
