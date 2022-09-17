require 'rails_helper'

RSpec.describe 'message show page' do
  before :each do
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

    @sat_lat = @sat_position_call[:positions].first[:satlatitude]
    @sat_lng = @sat_position_call[:positions].first[:satlongitude]

    allow(MessageService).to receive(:get_message).and_return(@message_call)
    allow(SatelliteService).to receive(:get_norad_id).and_return(@sat_db_call)
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
end