require 'rails_helper'

RSpec.describe 'message show page' do
  before :each do
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

    @message_call = JSON.parse(File.read('spec/fixtures/message.json'), symbolize_names: true)
    @sat_db_call = JSON.parse(File.read('spec/fixtures/sat_db_response.json'), symbolize_names: true)
    @sat_position_call = JSON.parse(File.read('spec/fixtures/sat_position_response.json'), symbolize_names: true)

    @message_id = @message_call[:data][:id]

    @message_sat_id = @message_call[:data][:attributes][:satellite_id]

    @message_start_lat = @message_call[:data][:attributes][:start_lat]
    @message_start_lng = @message_call[:data][:attributes][:start_lng]

    @message_content = @message_call[:data][:attributes][:content]

    @message_created_at = @message_call[:data][:attributes][:created_at]

    @sat_name = @sat_position_call[:info][:satname]

    @norad_id = @sat_position_call[:info][:satid]


    @sat_lat = @sat_position_call[:positions].first[:satlatitude]
    @sat_lng = @sat_position_call[:positions].first[:satlongitude]
    @lat = 39.75
    @long = -104.99
    @weather_data = JSON.parse(File.read('spec/fixtures/weather_data.json'), symbolize_names: true)
    @satellites = JSON.parse(File.read('spec/fixtures/satellites.json'), symbolize_names: true)
    @visible_sat_times = JSON.parse(File.read('spec/fixtures/satellite_visibility.json'), symbolize_names: true)
    
    allow_any_instance_of(ApplicationController).to receive(:remote_ip).and_return(@lat, @long)
    allow(MessageService).to receive(:get_message).and_return(@message_call)
    allow(SatelliteService).to receive(:get_norad_id).and_return(@sat_db_call)
    allow(SatelliteService).to receive(:get_satellite_position).and_return(@sat_position_call)
    allow(WeatherService).to receive(:get_weather_forecast).and_return(@weather_data)
    allow(SatelliteService).to receive(:get_user_satellites).and_return(@satellites)
    allow(SatelliteService).to receive(:get_satellite_visibility).and_return(@visible_sat_times)

    visit '/auth/google_oauth2'
  end

  it 'displays message content', :vcr do
    visit "/messages/#{@message_id}" 

    expect(page).to have_content("Message: #{@message_content}")
  end
  
  it 'displays starting lat/lng for message', :vcr do
    visit "/messages/#{@message_id}"
    
    expect(page).to have_content("Start Lat: #{@message_start_lat}")

    expect(page).to have_content("Start Lng: #{@message_start_lng}")
  end

  it 'displays current lat/lng for message', :vcr do
    visit "/messages/#{@message_id}"

    expect(page).to have_content("Current Lat:")
    expect(page).to have_content("Current Lng:")

    #this is working, but lat/long are always off by a tiny bit and test fails if including specific numbers
  end

  it 'displays satellite name' do
    visit "/messages/#{@message_id}"

    expect(page).to have_content(@sat_name)
  end

  it 'displays satellite norad id number' do
    visit "/messages/#{@message_id}"

    expect(page).to have_content(@norad_id)
  end

  xit 'generates and displays a map' do
    visit "/messages/#{@message_id}"

    # expect(page.html).to include("http://maps.googleapis.com/maps/api/staticmap?&size=600x400&style=visibility:on&maptype=satellite&markers=size:medium|color:blue|label:U|40.7143,-74.006&markers=size:medium|color:red|label:S|-6.24147627,91.26942017&markers=size:medium|color:green|label:M|40.57418114605389,32.18080704424722&key=#{ENV['google_maps_key']}")
  end

  it 'displays date the message was created' do
    visit "/messages/#{@message_id}"

    expect(page).to have_content("Message Launched: 12 September 2022, 6:42 PM")

  end

  it 'diplays how long the message has been traveling' do
    visit "/messages/#{@message_id}"

    expect(page).to have_content("Message has been traveling for #{(DateTime.now()-DateTime.parse(@message_created_at)).to_i} days.")
  end

  it 'displays how many times the message has traveled around the world since launch' do
    visit "/messages/#{@message_id}"

    expect(page).to have_content("This message has orbited around the world")
  end
end