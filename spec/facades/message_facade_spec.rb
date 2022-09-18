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

end