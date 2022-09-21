require 'rails_helper'

RSpec.describe 'message show page' do
  context "#happypath" do 
    before :each do
        Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]

        @user = JSON.parse(File.read('spec/fixtures/user.json'), symbolize_names: true)
        @satellites = JSON.parse(File.read('spec/fixtures/satellites.json'), symbolize_names: true)
        @visible_sat_times = JSON.parse(File.read('spec/fixtures/satellite_visibility.json'), symbolize_names: true)
        @weather_data = JSON.parse(File.read('spec/fixtures/weather_data.json'), symbolize_names: true)
        @found_messages = JSON.parse(File.read('spec/fixtures/messages.json'), symbolize_names: true)
        @message_array = JSON.parse(File.read('spec/fixtures/message_array.json'), symbolize_names: true)
        @message = JSON.parse(File.read('spec/fixtures/message.json'), symbolize_names: true)
        @sat_db_call = JSON.parse(File.read('spec/fixtures/sat_db_response.json'), symbolize_names: true)
        @sat_position_call = JSON.parse(File.read('spec/fixtures/sat_position_response.json'), symbolize_names: true)
        @message_id = @message[:data][:id]
        @lat = 39.75
        @long = -104.99
        
        allow(SatelliteService).to receive(:get_satellite_position).and_return(@position)
        allow(SatelliteService).to receive(:get_satellite_visibility).and_return(@visible_sat_times)
        allow(WeatherService).to receive(:get_weather_forecast).and_return(@weather_data)
        allow(SatelliteService).to receive(:get_user_satellites).and_return(@satellites)
        allow(UserService).to receive(:find_or_create_user).and_return(@user)
        allow(SatelliteService).to receive(:get_sat_message).and_return(@found_messages)
        allow(MessageService).to receive(:get_message_count).and_return(@message_array)
        allow_any_instance_of(ApplicationController).to receive(:remote_ip).and_return(@lat, @long)
        allow(SatelliteService).to receive(:get_norad_id).and_return(@sat_db_call)
        allow(SatelliteService).to receive(:get_satellite_position).and_return(@sat_position_call)
        allow(MessageService).to receive(:get_message).and_return(@message)

        visit '/auth/google_oauth2'
    end

    it 'displays message content' do
      visit "/messages/#{@message_id}" 

      expect(page).to have_content("Message: What a piece of work is man! How noble in reason, how infinite in faculty! In form and moving how express and admirable! In action how like an angel, in apprehension how like a god! The beauty of the world. The paragon of animals.")
    end
    
    it 'displays starting lat/lng for message'do
      visit "/messages/#{@message_id}"
      
      expect(page).to have_content("Start Lat: 40.57418114605389")

      expect(page).to have_content("Start Lng: 32.18080704424722")
    end

    it 'displays current lat/lng for message' do
      visit "/messages/#{@message_id}"

      expect(page).to have_content("Current Lat:")
      expect(page).to have_content("Current Lng:")
    end

    it 'displays satellite name' do
      visit "/messages/#{@message_id}"

      expect(page).to have_content("SPACE STATION")
    end

    it 'displays satellite norad id number' do
      visit "/messages/#{@message_id}"

      expect(page).to have_content("Norad ID: 25544")
    end

    it 'generates and displays a map' do
      visit "/messages/#{@message_id}"
      
      expect(page.html).to include("http://maps.googleapis.com/maps/api/staticmap?&amp;size=600x400&amp;style=visibility:on&amp;maptype=satellite&amp;markers=size:medium|color:blue|label:U|,&amp;markers=size:medium|color:red|label:S|-6.24147627,91.26942017&amp;markers=size:medium|color:green|label:M|40.57418114605389,32.18080704424722&amp;key=")
    end

    it 'displays date the message was created' do
      visit "/messages/#{@message_id}"

      expect(page).to have_content("Message Launched: 12 September 2022, 6:42 PM")

    end

    it 'diplays how long the message has been traveling' do
      visit "/messages/#{@message_id}"

      expect(page).to have_content("Message has been traveling for ")
    end

    it 'displays how many times the message has traveled around the world since launch' do
      visit "/messages/#{@message_id}"

      expect(page).to have_content("This message has orbited around the world")
    end
  end 

  context '#sadpath' do
    it 'redirects a non-logged in user to the landing page' do
      @message = JSON.parse(File.read('spec/fixtures/message.json'), symbolize_names: true)
      @message_id = @message[:data][:id]
      
      visit "/messages/#{@message_id}"
        
      expect(current_path).to eq("/")
    end
  end 
end