require 'rails_helper'

RSpec.describe MessageFacade do

  describe "#get_message" do

    it 'returns a message' do

      @message_call = JSON.parse(File.read('spec/fixtures/message.json'), symbolize_names: true)

      allow(MessageService).to receive(:get_message).and_return(@message_call)

      message_id = @message_call[:data][:id]

      results = MessageFacade.get_message(message_id)

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

end