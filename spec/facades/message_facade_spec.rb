require 'rails_helper'

RSpec.describe MessageFacade do

  describe "#get_message" do
    it 'returns a message', :vcr do 
      results = MessageFacade.get_message(96)

      expect(results).to be_a Message
    end
  end

  describe "#create_message" do
    it 'creates a message' do 
      response = {status: 200}
      lat =  40.7143
      long = -74.006
      sat_id = 12345
      message = "Hello there, this is a test"

      allow(MessageService).to receive(:create_message).and_return(response)
      message = MessageService.create_message(lat, long, message, sat_id)

      expect(message[:status]).to eq(200)
    end
  end

  describe "#get_message_count" do
    it 'returns a message count', :vcr do
      results = MessageFacade.get_message_count(22195)

      expect(results).to be_a Array 
    end
  end

end