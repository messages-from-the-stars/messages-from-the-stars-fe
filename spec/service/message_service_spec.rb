require 'rails_helper'

RSpec.describe MessageService do

  describe '#get_message' do
    it 'returns a message response', :vcr do
      message = MessageService.get_message(1)

      expect(message).to be_a(Hash)

      expect(message).to have_key(:data)
      expect(message[:data]).to be_a(Hash)

      expect(message[:data]).to have_key(:type)
      expect(message[:data][:type]).to be_a(String)

      expect(message[:data]).to have_key(:attributes)
      expect(message[:data][:attributes]).to be_a(Hash)

      expect(message[:data][:attributes]).to have_key(:satellite_id)
      expect(message[:data][:attributes][:satellite_id]).to be_a(Integer)

      expect(message[:data][:attributes]).to have_key(:start_lat)
      expect(message[:data][:attributes][:start_lat]).to be_a(Float)

      expect(message[:data][:attributes]).to have_key(:start_lng)
      expect(message[:data][:attributes][:start_lng]).to be_a(Float)

      expect(message[:data][:attributes]).to have_key(:content)
      expect(message[:data][:attributes][:start_lng]).to be_a(Float)

      expect(message[:data][:attributes]).to have_key(:created_at)
      expect(message[:data][:attributes][:created_at]).to be_a(String)
    end

  end
  describe '#create_message' do
    it 'returns a response when a message is created', :vcr do
      response = {status: 200}
      lat =  40.7143
      long = -74.006
      sat_id = 10
      message = "Hello there, this is a test"

      # allow(MessageService).to receive(:create_message).and_return(response)

      message = MessageService.create_message(lat, long, message, sat_id)

      expect(message[:data][:id]).to be_a(String)

      expect(message[:data]).to have_key(:attributes)
      expect(message[:data][:attributes]).to be_a(Hash)

      expect(message[:data][:attributes]).to have_key(:satellite_id)
      expect(message[:data][:attributes][:satellite_id]).to be_a(Integer)

      expect(message[:data][:attributes]).to have_key(:start_lat)
      expect(message[:data][:attributes][:start_lat]).to be_a(Float)

      expect(message[:data][:attributes]).to have_key(:start_lng)
      expect(message[:data][:attributes][:start_lng]).to be_a(Float)

      expect(message[:data][:attributes]).to have_key(:content)
      expect(message[:data][:attributes][:start_lng]).to be_a(Float)

      expect(message[:data][:attributes]).to have_key(:created_at)
      expect(message[:data][:attributes][:created_at]).to be_a(String)
    end 
  end 
end