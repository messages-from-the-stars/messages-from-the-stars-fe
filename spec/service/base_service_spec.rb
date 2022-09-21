require 'rails_helper'

RSpec.describe BaseService do
  describe '#n2yo_connection' do
    it 'returns a response' do
      service = BaseService.n2yo_connection

      expect(service).to be_a(Object)
    end
  end

  describe '#open_weather_connection' do
    it 'returns a response' do
      service = BaseService.open_weather_conn

      expect(service).to be_a(Object)
    end
  end

  describe '#messages_stars_be_connection' do
    it 'returns a response' do
      service = BaseService.connection 

      expect(service).to be_a(Object)
    end
  end
end