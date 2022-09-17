require 'rails_helper'

RSpec.describe 'message show page' do
  before :each do
    @message_call = JSON.parse(File.read('spec/fixtures/message.json'), symbolize_names: true)

    @message_id = @message_call[:data][:id]

    @message_sat_id = @message_call[:data][:attributes][:satellite_id]

    @message_start_lat = @message_call[:data][:attributes][:start_lat]
    @message_start_lng = @message_call[:data][:attributes][:start_lng]

    @message_content = @message_call[:data][:attributes][:content]

    @message_created_at = @message_call[:data][:attributes][:created_at]

    allow(MessageService).to receive(:get_message).and_return(@message_call)
  end

  it 'displays message content' do
    visit "/api/v1/messages/#{@message_id}" 

    expect(page).to have_content("Message: #{@message_content}")
  end
end