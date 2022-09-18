require 'rails_helper'

RSpec.describe MessageService do

  describe '#get_message' do

    it 'returns a message response' do
      @message_call = JSON.parse(File.read('spec/fixtures/message.json'), symbolize_names: true)

      allow(MessageService).to receive(:get_message).and_return(@message_call)

      message_id = @message_call[:data][:id]

      message = MessageService.get_message(message_id)

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

end